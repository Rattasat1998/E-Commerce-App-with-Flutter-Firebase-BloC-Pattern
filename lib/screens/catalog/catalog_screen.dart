import 'package:ecom/bloc1/category/category_bloc.dart';
import 'package:ecom/bloc1/product/product_bloc.dart';
import 'package:ecom/models/category_model.dart';
import 'package:ecom/models/models.dart';
import 'package:ecom/models/models.dart';
import 'package:ecom/models/product_model.dart';
import 'package:ecom/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CatalogScreen extends StatelessWidget {
  static const String routeName = '/catalog';

  final Category category;

  const CatalogScreen({Key? key, required this.category}) : super(key: key);

  static Route route({required Category category}) {
    return PageRouteBuilder(
        settings: const RouteSettings(name: routeName),
        pageBuilder: (_, __, ___) => CatalogScreen(category: category));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: category.name),
      bottomNavigationBar: const CustomNavBar(screen: routeName,),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }
          if (state is ProductLoaded) {
            final List<Product> categoryProduct = state.products
                .where((product) => product.category == category.name)
                .toList();
            return GridView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 1.15),
                itemCount: categoryProduct.length,
                itemBuilder: (BuildContext context, int index) {
                  print(categoryProduct[index]);
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: ProductCard(
                        product: categoryProduct[index],
                        widthFactor: 2,
                      ),
                    ),
                  );
                });
          } else {
            return const Text('Something Wrong');
          }
        },
      ),
    );
  }
}
