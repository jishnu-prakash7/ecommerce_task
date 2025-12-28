part of 'cart_bloc.dart';

sealed class CartEvent {}

final class AddCartEvent extends CartEvent {
  final ProductsListEntity product;

  AddCartEvent({required this.product});
}

final class UpdateCartEvent extends CartEvent {
  final num productId;
  final int newQuantity;

  UpdateCartEvent({required this.productId, required this.newQuantity});
}

final class IsInCartEvent extends CartEvent {
  final num productId;

  IsInCartEvent({required this.productId});
}

final class GetQuantityEvent extends CartEvent {
  final num productId;

  GetQuantityEvent({required this.productId});
}

final class GetCartListEvent extends CartEvent {}
