import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecom/bloc1/category/category_bloc.dart';
import 'package:ecom/bloc1/product/product_bloc.dart';
import 'package:ecom/models/category_model.dart';
import 'package:ecom/models/models.dart';
import 'package:ecom/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/';

  const HomeScreen({Key? key}) : super(key: key);

  static Route route() {
    return PageRouteBuilder(
        settings: RouteSettings(name: routeName),
        pageBuilder: (_, __, ___) => HomeScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Hanbai no sekai'),
      bottomNavigationBar: const CustomNavBar(screen: routeName),
      body: Column(
        children: [
          BlocBuilder<CategoryBloc, CategoryState>(
            builder: (context, state) {
              if (state is CategoryLoading) {
                return const Center(
                  child: CupertinoActivityIndicator(),
                );
              }
              if (state is CategoryLoaded) {
                return CarouselSlider(
                  options: CarouselOptions(
                    aspectRatio: 1.7,
                    viewportFraction: 0.9,
                    enlargeCenterPage: true,
                    enlargeStrategy: CenterPageEnlargeStrategy.height,
                    initialPage: 2,
                    autoPlay: true,
                  ),
                  items: state.categories
                      .map((category) => HeroCard(category: category))
                      .toList(),
                );
              } else {
                return const Text('Something Wrong');
              }
            },
          ),
          const SectionTitle(title: 'RECOMMENDED'),
          // Product Card
          BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state){
              if(state is ProductLoading){
                return const Center(
                  child: CupertinoActivityIndicator(),
                );
              }if(state is ProductLoaded){
                return ProductCarousel(
                    products: state.products
                        .where((product) => product.isRecommended!)
                        .toList());
              } else {
                return const Text('Something Wrong');
              }
            },
          ),

          const SectionTitle(title: 'MOST POPULAR'),
          // Product Card
          BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state){
              if(state is ProductLoading){
                return const Center(
                  child: CupertinoActivityIndicator(),
                );
              }if(state is ProductLoaded){
                return ProductCarousel(
                    products: state.products
                        .where((product) => product.isPopular!)
                        .toList());
              } else {
                return const Text('Something Wrong');
              }
            },
          ),
        ],
      ),
    );
  }
}
