part of 'cart_bloc.dart';

sealed class CartState {}

final class CartInitial extends CartState {}

final class AddCartLoadingState extends CartState {}

final class AddCartSuccessState extends CartState {}

final class AddCartFailedState extends CartState {
  final String error;

  AddCartFailedState({required this.error});
}

final class UpdateCartLoadingState extends CartState {}

final class UpdateCartSuccessState extends CartState {
  final int quantity;

  UpdateCartSuccessState({required this.quantity});
}

final class UpdateCartFailedState extends CartState {
  final String error;

  UpdateCartFailedState({required this.error});
}

final class IsInCartLoadingState extends CartState {}

final class IsInCartSuccessState extends CartState {
  final bool isInCart;
  final int quantity;

  IsInCartSuccessState({required this.isInCart,required this.quantity});
}

final class IsInCartFailedState extends CartState {
  final String error;

  IsInCartFailedState({required this.error});
}

final class GetQuantityLoadingState extends CartState {}

final class GetQuantitySuccessState extends CartState {
  final int quantity;

  GetQuantitySuccessState({required this.quantity});
}

final class GetQuantityFailedState extends CartState {
  final String error;

  GetQuantityFailedState({required this.error});
}

final class GetCartListLoadingState extends CartState {}

final class GetCartListSuccessState extends CartState {}

final class GetCartListFailedState extends CartState {
  final String error;

  GetCartListFailedState({required this.error});
}
