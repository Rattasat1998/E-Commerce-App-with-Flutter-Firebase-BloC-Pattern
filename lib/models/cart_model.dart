import 'package:equatable/equatable.dart';

import 'product_model.dart';

class Cart extends Equatable {

  final List<Product> products;

  const Cart({this.products = const <Product> []});

  double get subtotal =>
      products.fold(0, (total, current) => total + current.price!);

  double deliveryFree(subtotal) {
    if (subtotal >= 30.0) {
      return 0.0;
    } else {
      return 10.0;
    }
  }

  String freeDelivery(subtotal){
    if(subtotal >= 30.0){
      return 'You have Free Delivery';
    } else {
      double missing = 30.0 - subtotal;
      return 'Add \$${missing.toStringAsFixed(2)} for Free Delivery';
    }
  }

  Map productQuantity(products){
    var quantity = {};
    products.forEach((product){
      if(!quantity.containsKey(product)){
        quantity[product] = 1;
      } else {
        quantity[product] += 1;
      }
    });
    return quantity;
  }

  double total(subtotal, deliveryFree){
    return subtotal + deliveryFree(subtotal);
  }
  String get subtotalString => subtotal.toStringAsFixed(2);

  String get totalString => total(subtotal, deliveryFree).toStringAsFixed(2);

  String get deliveryFreeString => deliveryFree(subtotal).toStringAsFixed(2);

  String get freeDeliveryString => freeDelivery(subtotal);

  @override
  List<Object?> get props => [products];
}
