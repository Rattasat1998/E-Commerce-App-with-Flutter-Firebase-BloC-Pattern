import 'package:ecom/bloc1/cart/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomWishlistAppBar extends StatelessWidget with PreferredSizeWidget {
  final String? title;
  const CustomWishlistAppBar({
    this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        child:  Text('$title',style: Theme.of(context).textTheme.headline2),
      ),
      iconTheme: const IconThemeData(color: Colors.black),
      actions: [
        BlocBuilder<CartBloc, CartState>(
          builder: (context, state){
            if(state is CartLoaded){
              return  Badge(
                position: BadgePosition.topEnd(top: 0, end: 0),
                animationDuration: const Duration(milliseconds: 500),
                animationType: BadgeAnimationType.slide,
                badgeContent: Text('${state.cart.products.length}'),
                child: IconButton(onPressed: (){
                  Navigator.pushNamed(context, '/cart');
                }, icon: const Icon(Icons.shopping_cart,color: Colors.black,)),
              );
            } else{
              return Text('');
            }
          },
        )
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(50.0);
}