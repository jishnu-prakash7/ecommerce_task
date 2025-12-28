part of 'wishlist_bloc.dart';

sealed class WishlistEvent {}

final class AddWishlistEvent extends WishlistEvent {
  final ProductsListEntity product;

  AddWishlistEvent({required this.product});
}

final class IsInWishlistEvent extends WishlistEvent {
  final num productId;

  IsInWishlistEvent({required this.productId});
}
final class RemoveWishlistEvent extends WishlistEvent {
  final num productId;

  RemoveWishlistEvent({required this.productId});
}

final class GetWishlistEvent extends WishlistEvent {}
