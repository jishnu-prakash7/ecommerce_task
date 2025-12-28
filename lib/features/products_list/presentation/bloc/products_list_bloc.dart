import 'dart:async';

import 'package:ecommerce/core/dependencies/dependencies.dart';
import 'package:ecommerce/features/products_list/domain/entities/products_list_entity.dart';
import 'package:ecommerce/features/products_list/domain/use_cases/fetch_products_list_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'products_list_event.dart';
part 'products_list_state.dart';

class ProductsListBloc extends Bloc<ProductsListEvent, ProductsListState> {
  List<ProductsListEntity> productsList = [];
  List<ProductsListEntity> filteredProducts = [];
  ProductsListBloc() : super(ProductsListInitial()) {
    on<ProductsListEvent>((event, emit) {});
    on<FetchProductsListEvent>(fetchProductsListEvent);
  }

  FutureOr<void> fetchProductsListEvent(
    FetchProductsListEvent event,
    Emitter<ProductsListState> emit,
  ) async {
    try {
      emit(FetchProductsListLoadingState());
      final result = await sl<FetchProductsListUseCase>().call();
      if (result.error != null) {
        emit(FetchProductsListFailedState(error: result.error!.message));
      } else {
        filteredProducts = productsList = result.data!;
        emit(FetchProductsListSuccessState());
      }
    } catch (e) {
      emit(FetchProductsListFailedState(error: e.toString()));
    }
  }
}
