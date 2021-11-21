import 'package:ecom/models/models.dart';
import 'package:equatable/equatable.dart';

class Checkout extends Equatable {
  final String? fullName;
  final String? email;
  final String? address;
  final String? city;
  final String? country;
  final String? zipCode;
  final List<Product>? products;
  final String? subtotal;
  final String? deliveryFree;
  final String? total;

  const Checkout(
      {this.fullName,
      this.email,
      this.address,
      this.city,
      this.country,
      this.zipCode,
      this.products,
      this.subtotal,
      this.deliveryFree,
      this.total});

  @override
  // TODO: implement props
  List<Object?> get props => [fullName,email,address,city,country,zipCode,products,subtotal,deliveryFree,total];

  Map<String, Object> toDocument(){
    Map customerAddress = {};
    customerAddress['address'] = address;
    customerAddress['city'] = city;
    customerAddress['country'] = country;
    customerAddress['zipCode'] = zipCode;
    return {
      'customerAddress' : customerAddress,
      'customerName' : fullName!,
      'customerEmail' : email!,
      'products' : products!.map((e) => e.name).toList(),
      'subtotal' : subtotal!,
      'deliveryFree' : deliveryFree!,
      'total' : total!
    };
  }

}