import 'package:ecom/models/models.dart';

abstract class BaseCategoryRepository {
  Stream<List<Category>> getAllCategory();
}