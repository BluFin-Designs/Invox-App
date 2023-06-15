part of 'categories_bloc.dart';

abstract class CategoriesState extends Equatable {
  const CategoriesState();
}

class CategoriesInitialState extends CategoriesState {
  @override
  List<Object> get props => [];
}

class CategoriesLoadingState extends CategoriesState {
  @override
  List<Object> get props => [];
}

class CategoriesLoadedState extends CategoriesState {
  List<TransactionCategoryModel> allCategories;

  CategoriesLoadedState(this.allCategories);

  @override
  List<Object> get props => [];
}

class CategoriesLoadingErrorState extends CategoriesState {
  @override
  List<Object> get props => [];
}
