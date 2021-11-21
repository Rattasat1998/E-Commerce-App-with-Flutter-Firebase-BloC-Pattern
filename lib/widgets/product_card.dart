import 'package:ecom/bloc1/cart/cart_bloc.dart';
import 'package:ecom/bloc1/wishlist/wishlist_bloc.dart';
import 'package:ecom/models/product_model.dart';
import 'package:ecom/widgets/card_product_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final double widthFactor;
  final double leftPosition;
  final bool  isWishlist;
  const ProductCard({
    required this.product,
    this.widthFactor = 2.5,
    this.leftPosition = 5,
    this.isWishlist = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double widthValue = MediaQuery.of(context).size.width / widthFactor;
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, '/product',arguments: product);
      },
      child: Stack(
        children: [
          Container(
            width: widthValue,
            height: 150,
            child: Image.network(
            '${product.imageUrl}',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 80,
            left: leftPosition + 5,
            right: 5,
            bottom: 5,
            child: Container(
              width: widthValue - 15 - leftPosition,
              height: 65,
              decoration: BoxDecoration(
                color: Colors.grey[900]!.withAlpha(150),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${product.name}',
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(color: Colors.white),
                          ),
                          Text(
                            '\$${product.price!}',
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    BlocBuilder<CartBloc, CartState>(
                      builder: (context,state){
                        if(state is CartLoading){
                          return const Center(
                            child: CupertinoActivityIndicator(),
                          );
                        } if(state is CartLoaded){
                          return Expanded(
                              child: IconButton(
                                  onPressed: () {
                                    context.read<CartBloc>().add(CartProductAdd(product));
                                    //ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Added to your Cart')));
                                  },
                                  icon: const Icon(
                                    Icons.add_circle,
                                    color: Colors.white,
                                    size: 35,
                                  )));
                        } else{
                          return const Text('Something Wrong');
                        }
                      },
                    ),
                    isWishlist ? BlocBuilder<WishlistBloc,WishlistState>(
                      builder: (context,state){
                        return Expanded(
                            child: IconButton(
                                onPressed: () {
                                  context.read<WishlistBloc>().add(RemoveWishlistProduct(product));
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                  size: 25,
                                )));
                      },
                    )
                        : const SizedBox()
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}