import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:invox/Models/CategoryModel.dart';
import 'package:invox/Repositories/CategoryRepository.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesBloc() : super(CategoriesInitialState()) {
    CategoryRepository categoryRepo = CategoryRepository();
    List<TransactionCategoryModel> allCategories = [];

    on<CategoriesEvent>((event, emit) async {
      if (event is CategoriesLoadingEvent) {
        //Load-Data
        try {
          allCategories = categoryRepo.getCategories();
          emit(CategoriesLoadedState(allCategories));
        } catch (err) {
          emit(CategoriesLoadingErrorState());
        }
      } else if (event is CategoriesLoadedEvent) {
        emit(CategoriesLoadedState(allCategories));
      } else {
        emit(CategoriesLoadingErrorState());
      }
    });
  }
}
