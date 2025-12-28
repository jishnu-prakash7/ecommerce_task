import 'dart:async';

import 'package:ecommerce/core/dependencies/dependencies.dart';
import 'package:ecommerce/features/products_list/domain/entities/products_list_entity.dart';
import 'package:ecommerce/features/wishlist/domain/entities/wishlist_item_entity.dart';
import 'package:ecommerce/features/wishlist/domain/use_cases/add_wishlist_usecase.dart';
import 'package:ecommerce/features/wishlist/domain/use_cases/get_wishlist_usecase.dart';
import 'package:ecommerce/features/wishlist/domain/use_cases/isin_wishlist_usecase.dart';
import 'package:ecommerce/features/wishlist/domain/use_cases/remove_wishlist_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  List<WishlistItemEntity> wishlist = [];
  WishlistBloc() : super(WishlistInitial()) {
    on<WishlistEvent>((event, emit) {});
    on<IsInWishlistEvent>(isInWishlistEvent);
    on<AddWishlistEvent>(addWishlistEvent);
    on<GetWishlistEvent>(getWishlistEvent);
    on<RemoveWishlistEvent>(removeWishlistEvent);
  }

  FutureOr addWishlistEvent(
    AddWishlistEvent event,
    Emitter<WishlistState> emit,
  ) async {
    emit(AddWishlistLoadingState());
    final res = await sl<AddwishlistUsecase>().call(params: event.product);

    if (res.error != null) {
      emit(AddWishlistFailedState(error: res.error?.message ?? ''));
    } else {
      if (res.data == true) {
        emit(AddWishlistSuccessState());
      } else {
        emit(AddWishlistFailedState(error: res.error?.message ?? ''));
      }
    }
  }

  FutureOr isInWishlistEvent(
    IsInWishlistEvent event,
    Emitter<WishlistState> emit,
  ) async {
    emit(IsInWishlistLoadingState());
    final res = await sl<IsinWishlistUsecase>().call(params: event.productId);

    if (res.error != null) {
      emit(IsInWishWishlistFailedState(error: res.error?.message ?? ''));
    } else {
      emit(IsInWishWishlistSuccessState(isInWishlist: res.data ?? false));
    }
  }

  FutureOr getWishlistEvent(
    GetWishlistEvent event,
    Emitter<WishlistState> emit,
  ) async {
    emit(GetWishlistLoadingState());
    final res = await sl<GetWishlistUsecase>().call(params: null);

    if (res.error != null) {
      emit(GetWishlistFailedState(error: res.error!.message));
    } else {
      wishlist = res.data ?? [];
      emit(GetWishlistSuccessState());
    }
  }

  FutureOr removeWishlistEvent(
    RemoveWishlistEvent event,
    Emitter<WishlistState> emit,
  ) async {
    emit(RemoveWishlistLoadingState());
    final res = await sl<RemoveWishlistUsecase>().call(params: event.productId);

    if (res.error != null) {
      emit(RemoveWishlistFailedState(error: res.error!.message));
    } else {
      emit(RemoveWishlistSuccessState());
    }
  }
}
