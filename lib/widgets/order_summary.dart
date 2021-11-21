import 'package:ecom/bloc1/cart/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderSummary extends StatelessWidget {
  const OrderSummary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state){
        if(state is CartLoaded){
          return Column(
            children: [
              const Divider(
                thickness: 2,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Text('SUBTOTAL',
                            style: Theme.of(context)
                                .textTheme
                                .headline5),
                        Text('\$${state.cart.subtotalString}',
                            style: Theme.of(context)
                                .textTheme
                                .headline5),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Text('DELIVERY FREE',
                            style: Theme.of(context)
                                .textTheme
                                .headline5),
                        Text('\$${state.cart.deliveryFreeString}',
                            style: Theme.of(context)
                                .textTheme
                                .headline5),
                      ],
                    ),
                  ],
                ),
              ),
              Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    decoration:
                    BoxDecoration(color: Colors.grey[200]),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.all(5),
                    height: 50,
                    decoration:
                    BoxDecoration(color: Colors.grey[900]),
                    child: Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Text('TOTAL',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(color: Colors.white)),
                          Text('\$${state.cart.totalString}',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(color: Colors.white)),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          );
        } else {
          return const Text('Something Wrong');
        }
      },
    );
  }
}
