part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoadProduct extends ProductEvent {

}
class UpdateProduct extends ProductEvent {
  final List<Product> product;
  const UpdateProduct(this.product);
  @override
  // TODO: implement props
  List<Object?> get props => [product];
}