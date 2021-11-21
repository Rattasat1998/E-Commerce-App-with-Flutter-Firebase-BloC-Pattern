import 'package:badges/badges.dart';
import 'package:ecom/bloc1/cart/cart_bloc.dart';
import 'package:ecom/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomNavBar extends StatelessWidget {
  final String screen;
  final Product? product;
  const CustomNavBar({
    required this.screen,
    this.product,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Container(
        color: Colors.grey[900],
        height: 60.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/');
                },
                icon: const Icon(
                  Icons.home,
                  color: Colors.white,
                )),
            BlocBuilder<CartBloc, CartState>(
              builder: (context, state){
                if(state is CartLoading){
                  return const Icon(Icons.shopping_cart);
                }
                if(state is CartLoaded){
                  return Badge(
                    position: BadgePosition.topEnd(top: 0, end: 0),
                    animationDuration: const Duration(milliseconds: 100),
                    animationType: BadgeAnimationType.scale,
                    badgeContent: Text('${state.cart.products.length}'),
                    child: IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/cart');
                        },
                        icon: const Icon(Icons.shopping_cart, color: Colors.white)),
                  );
                } else{
                  return const Icon(Icons.shopping_cart);
                }
              },
            ),
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/user');
                },
                icon: const Icon(Icons.person, color: Colors.white)),
          ],
        ),
      ),
    );
  }
  List<Widget>? _selectNavBar(context, screen) {
    switch(screen){
      case '/':
        return _buildNavBar(context);
      case '/cart':
        return _buildNavBar(context);
      case '/user':
        return _buildNavBar(context);
    }
  }

  List<Widget> _buildNavBar(context){
    return [

    ];
  }
}