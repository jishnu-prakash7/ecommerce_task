part of 'products_list_bloc.dart';


sealed class ProductsListState {}

final class ProductsListInitial extends ProductsListState {}

final class FetchProductsListLoadingState extends ProductsListState {}

final class FetchProductsListSuccessState extends ProductsListState {}

final class FetchProductsListFailedState extends ProductsListState {
  final String error;

  FetchProductsListFailedState({required this.error});
}
