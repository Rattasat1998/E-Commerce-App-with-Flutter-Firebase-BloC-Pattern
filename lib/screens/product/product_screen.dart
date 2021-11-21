import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecom/bloc1/cart/cart_bloc.dart';
import 'package:ecom/bloc1/wishlist/wishlist_bloc.dart';
import 'package:ecom/models/models.dart';
import 'package:ecom/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductScreen extends StatelessWidget {
  static const String routeName = '/product';
  final Product product;

  const ProductScreen({Key? key, required this.product}) : super(key: key);

  static Route route({required Product product}) {
    return PageRouteBuilder(
        settings: const RouteSettings(name: routeName),
        pageBuilder: (_, __, ___) => ProductScreen(product: product));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: product.name),
      bottomNavigationBar: BottomAppBar(
          color: Colors.grey[900],
          child: SizedBox(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.share,
                      color: Colors.white,
                    )),
                BlocBuilder<WishlistBloc, WishlistState>(
                  builder: (context, state) {
                    return IconButton(
                        onPressed: () {
                          context.read<WishlistBloc>().add(AddWishlistProduct(product));
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Added to your Wishlist')));
                        },
                        icon: const Icon(Icons.favorite, color: Colors.white));
                  },
                ),
                BlocBuilder<CartBloc, CartState>(
                  builder: (context, state){
                    return ElevatedButton(
                      onPressed: () {
                        context.read<CartBloc>().add(CartProductAdd(product));
                        Navigator.pushNamed(context, '/cart');
                      },
                      child: Text(
                        'ADD TO CART',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      style: ElevatedButton.styleFrom(primary: Colors.white),
                    );
                  },
                )
              ],
            ),
          )),
      body: ListView(
        children: [
          CarouselSlider(
              options: CarouselOptions(
                aspectRatio: 1.5,
                viewportFraction: 0.9,
                enlargeCenterPage: true,
                enlargeStrategy: CenterPageEnlargeStrategy.height,
                initialPage: 2,
                autoPlay: true,
              ),
              items: [HeroCard(product: product)]),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  color: Colors.grey,
                  alignment: Alignment.bottomCenter,
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 10,
                  height: 50,
                  color: Colors.grey[900],
                  margin: const EdgeInsets.all(5),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${product.name}',
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(color: Colors.white),
                        ),
                        Text(
                          '\$${product.price}',
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ExpansionTile(
              initiallyExpanded: true,
              title: Text('Product Information',
                  style: Theme.of(context).textTheme.headline3),
              children: [
                ListTile(
                    title: Text(
                        'Elephants are the largest existing land animals. Three living species are currently recognised: the African bush elephant, the African forest elephant, and the Asian elephant. They are an informal grouping within the proboscidean family Elephantidae. ',
                        style: Theme.of(context).textTheme.bodyText1))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ExpansionTile(
              initiallyExpanded: false,
              title: Text('Delivery Information',
                  style: Theme.of(context).textTheme.headline3),
              children: [
                ListTile(
                    title: Text(
                        'Elephants are the largest existing land animals. Three living species are currently recognised: the African bush elephant, the African forest elephant, and the Asian elephant. They are an informal grouping within the proboscidean family Elephantidae. ',
                        style: Theme.of(context).textTheme.bodyText1))
              ],
            ),
          )
        ],
      ),
    );
  }
}
