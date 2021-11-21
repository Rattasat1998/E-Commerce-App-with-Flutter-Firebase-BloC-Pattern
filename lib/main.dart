import 'package:ecom/bloc1/cart/cart_bloc.dart';
import 'package:ecom/bloc1/category/category_bloc.dart';
import 'package:ecom/bloc1/checkout/checkout_bloc.dart';
import 'package:ecom/config/app_router.dart';
import 'package:ecom/config/theme.dart';
import 'package:ecom/repositories/category/category_repository.dart';
import 'package:ecom/repositories/checkout/checkout_repository.dart';
import 'package:ecom/repositories/product/product_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc1/product/product_bloc.dart';
import 'bloc1/wishlist/wishlist_bloc.dart';
import 'screens/screens.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => WishlistBloc()..add(StartWishlist())),
        BlocProvider(create: (_) => CartBloc()..add(CartStarted())),
        BlocProvider(create: (_) => CategoryBloc(categoryRepository: CategoryRepository())..add(LoadCategories())),
        BlocProvider(create: (_) => ProductBloc(productRepository: ProductRepository())..add(LoadProduct())),
        BlocProvider(create: (context) => CheckoutBloc(cartBloc: BlocProvider.of<CartBloc>(context)
          ,checkoutRepository: CheckoutRepository(), )),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: theme(),
        onGenerateRoute: AppRouter.onGenerateRoute,
        initialRoute: HomeScreen.routeName,
      ),
    );
  }
}



