part of 'categories_bloc.dart';

abstract class CategoriesEvent extends Equatable {
  const CategoriesEvent();
}

class CategoriesLoadingEvent extends CategoriesEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CategoriesLoadingErrorEvent extends CategoriesEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CategoriesLoadedEvent extends CategoriesEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
