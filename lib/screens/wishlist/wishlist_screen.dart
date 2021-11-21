import 'package:ecom/bloc1/wishlist/wishlist_bloc.dart';
import 'package:ecom/models/models.dart';
import 'package:ecom/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishListScreen extends StatelessWidget {
  static const String routeName = '/wishlist';

  const WishListScreen({Key? key}) : super(key: key);

  static Route route() {
    return PageRouteBuilder(
        settings: const RouteSettings(name: routeName),
        pageBuilder: (_, __, ___) => const WishListScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomWishlistAppBar(title: 'WISHLIST'),
        bottomNavigationBar: const CustomNavBar(screen: routeName),
        body: BlocBuilder<WishlistBloc, WishlistState>(
          builder: (context, state) {
            if (state is WishlistLoading) {
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            }
            if (state is WishlistLoaded) {
              if (state.wishlist.product.isNotEmpty) {

                return GridView.builder(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1, childAspectRatio: 2.4),
                    itemCount: state.wishlist.productQuantity(state.wishlist.product).keys.length,
                    itemBuilder: (BuildContext context, int index) {
                      //print(state.wishlist.productQuantity(state.wishlist.product).keys.elementAt(index),);

                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 5.0),
                          child: ProductCard(
                            product: state.wishlist.productQuantity(state.wishlist.product).keys.elementAt(index),
                            widthFactor: 1.1,
                            leftPosition: 120,
                            isWishlist: true,
                          ),
                        ),
                      );
                    });
              } else {
                return Center(
                    child: Column(
                  children: [
                    Image.asset('assets/images/logo.png'),
                    Text(
                      'Wishlist is Empty',
                      style: Theme.of(context).textTheme.headline3,
                    )
                  ],
                ));
              }
            } else {
              return const Text('Something Wrong');
            }
          },
        ));
  }
}
