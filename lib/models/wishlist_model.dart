import 'package:equatable/equatable.dart';
import 'models.dart';

class Wishlist extends Equatable {
  final List<Product> product;

  const Wishlist({this.product = const <Product>[]});

  Map productQuantity(products){
    var quantity = {};
    products.forEach((product){
      if(quantity.containsKey(product)){
        quantity[product] = 1;
      } else{
        quantity[product] = 1;
      }
    });
    return quantity;
  }

  @override
  List<Object?> get props => [product];

}