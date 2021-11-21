import 'package:ecom/models/models.dart';

abstract class BaseProductRepository{
  Stream<List<Product>> getAllProduct();
}