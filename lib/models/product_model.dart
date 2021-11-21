import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String? name;
  final String? category;
  final String? imageUrl;
  final double? price;
  final bool? isRecommended;
  final bool? isPopular;

  const Product(
      {this.name,
      this.category,
      this.imageUrl,
      this.price,
      this.isRecommended,
      this.isPopular});

  @override
  // TODO: implement props
  List<Object?> get props =>
      [name, category, imageUrl, price, isRecommended, isPopular];


  static Product fromSnapshot(DocumentSnapshot snapshot){
    Product product = Product(
      name: snapshot['name'],
      category: snapshot['category'],
      imageUrl: snapshot['imageUrl'],
      price: snapshot['price'],
      isRecommended: snapshot['isRecommended'],
      isPopular: snapshot['isPopular']
    );
    return product;
  }

}
