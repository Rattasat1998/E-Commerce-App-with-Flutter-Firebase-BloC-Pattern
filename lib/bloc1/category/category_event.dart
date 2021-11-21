part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoadCategories extends CategoryEvent {

}
class UpdateCategories extends CategoryEvent {
  final List<Category> categories;
  const UpdateCategories(this.categories);
  @override
  // TODO: implement props
  List<Object?> get props => [categories];
}