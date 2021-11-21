part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();
}

class CartStarted extends CartEvent{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class CartProductAdd extends CartEvent{
  final Product product;
  const CartProductAdd(this.product);
  @override
  // TODO: implement props
  List<Object?> get props => [product];
}
class CartProductRemove extends CartEvent{
  final Product product;
  const CartProductRemove(this.product);
  @override
  // TODO: implement props
  List<Object?> get props => [product];
}
