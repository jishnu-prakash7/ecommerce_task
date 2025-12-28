part of 'wishlist_bloc.dart';

sealed class WishlistState {}

final class WishlistInitial extends WishlistState {}

final class AddWishlistLoadingState extends WishlistState {}

final class AddWishlistSuccessState extends WishlistState {}

final class AddWishlistFailedState extends WishlistState {
  final String error;

  AddWishlistFailedState({required this.error});
}

final class RemoveWishlistLoadingState extends WishlistState {}

final class RemoveWishlistSuccessState extends WishlistState {}

final class RemoveWishlistFailedState extends WishlistState {
  final String error;

  RemoveWishlistFailedState({required this.error});
}

final class GetWishlistLoadingState extends WishlistState {}

final class GetWishlistSuccessState extends WishlistState {}

final class GetWishlistFailedState extends WishlistState {
  final String error;

  GetWishlistFailedState({required this.error});
}

final class IsInWishlistLoadingState extends WishlistState {}

final class IsInWishWishlistSuccessState extends WishlistState {
  final bool isInWishlist;

  IsInWishWishlistSuccessState({required this.isInWishlist});
}

final class IsInWishWishlistFailedState extends WishlistState {
  final String error;

  IsInWishWishlistFailedState({required this.error});
}
