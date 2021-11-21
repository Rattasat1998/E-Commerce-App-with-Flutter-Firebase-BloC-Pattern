import 'package:ecom/bloc1/cart/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final String? title;
  const CustomAppBar({
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
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/', (Route<dynamic> route) => false);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      actions: [
        IconButton(onPressed: (){
          Navigator.pushNamed(context, '/wishlist');
        }, icon: const Icon(Icons.favorite,color: Colors.black,))
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(50.0);
}