import 'package:ecom/bloc1/cart/cart_bloc.dart';
import 'package:ecom/bloc1/checkout/checkout_bloc.dart';
import 'package:ecom/models/models.dart';
import 'package:ecom/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutScreen extends StatelessWidget {
  static const String routeName = '/checkout';

  const CheckoutScreen({Key? key}) : super(key: key);

  static Route route() {
    return PageRouteBuilder(
        settings: const RouteSettings(name: routeName),
        pageBuilder: (_, __, ___) => const CheckoutScreen());
  }

  @override
  Widget build(BuildContext context) {
    CartBloc? _cartBloc;
    return SafeArea(
      child: Scaffold(
        //resizeToAvoidBottomInset: true
        appBar: const CustomCheckoutAppBar(
          title: 'Checkout',
        ),
        bottomNavigationBar: BottomAppBar(
            color: Colors.grey[900],
            child: SizedBox(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BlocBuilder<CheckoutBloc, CheckoutState>(
                    builder: (context, state) {
                      if (state is CheckoutLoading) {
                        return BlocBuilder<CartBloc, CartState>(
                          builder: (context, state){
                            if(state is CartLoaded){
                              return ElevatedButton(
                                onPressed: () {
                                  state.cart.products.clear();
                                  Navigator.pushNamed(context, '/');
                                },
                                child: Text(
                                  'GO TO ',
                                  style: Theme.of(context).textTheme.headline3,
                                ),
                                style:
                                ElevatedButton.styleFrom(primary: Colors.white),
                              );
                            } else{
                              return Text('55');
                            }
                          },
                        );
                      }
                      if (state is CheckoutLoaded) {
                        return ElevatedButton(
                          onPressed: () {
                              context
                                  .read<CheckoutBloc>()
                                  .add(ConfirmCheckout(checkout: state.checkout));

                          },
                          child: Text(
                            'ORDER NOW',
                            style: Theme.of(context).textTheme.headline3,
                          ),
                          style:
                              ElevatedButton.styleFrom(primary: Colors.white),
                        );
                      } else {
                        return const Text('Something Wrong');
                      }
                    },
                  )
                ],
              ),
            )),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height - 170,
              child: BlocBuilder<CheckoutBloc, CheckoutState>(
                builder: (context, state) {
                  if (state is CheckoutLoading) {
                    return Center(
                      child: Image.asset('assets/images/logo.png'),
                    );
                  }
                  if (state is CheckoutLoaded) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'CUSTOMER INFORMATION',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        _buildTextFromField((value) {
                          context
                              .read<CheckoutBloc>()
                              .add(UpdateCheckout(email: value));
                        }, context, 'Email'),
                        _buildTextFromField((value) {
                          context
                              .read<CheckoutBloc>()
                              .add(UpdateCheckout(fullName: value));
                        }, context, 'Full Name'),
                        Text(
                          'DELIVERY INFORMATION',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        _buildTextFromField((value) {
                          context
                              .read<CheckoutBloc>()
                              .add(UpdateCheckout(address: value));
                        }, context, 'Address'),
                        _buildTextFromField((value) {
                          context
                              .read<CheckoutBloc>()
                              .add(UpdateCheckout(city: value));
                        }, context, 'City'),
                        _buildTextFromField((value) {
                          context
                              .read<CheckoutBloc>()
                              .add(UpdateCheckout(country: value));
                        }, context, 'Country'),
                        _buildTextFromField((value) {
                          context
                              .read<CheckoutBloc>()
                              .add(UpdateCheckout(zipCode: value));
                        }, context, 'zipCode'),
                        Text(
                          'ORDER SUMMARY',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        const OrderSummary()
                      ],
                    );
                  } else {
                    return const Text('Something Wrong');
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Padding _buildTextFromField(
      Function(String)? onChange, BuildContext context, String labelText) {
    return Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            SizedBox(
              width: 75,
              child: Text(
                labelText,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            Expanded(
                child: TextFormField(
              onChanged: onChange,
              decoration: const InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.all(5),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black))),
            ))
          ],
        ));
  }
}
