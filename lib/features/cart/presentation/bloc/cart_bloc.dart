import 'dart:async';
import 'package:ecommerce/core/dependencies/dependencies.dart';
import 'package:ecommerce/features/cart/domain/entities/cart_item_entity.dart';
import 'package:ecommerce/features/cart/domain/use_cases/add_cart_usecase.dart';
import 'package:ecommerce/features/cart/domain/use_cases/get_cart_list_usecase.dart';
import 'package:ecommerce/features/cart/domain/use_cases/get_quantity_usecase.dart';
import 'package:ecommerce/features/cart/domain/use_cases/isincart_usecase.dart';
import 'package:ecommerce/features/cart/domain/use_cases/updatecart_usecase.dart';
import 'package:ecommerce/features/products_list/domain/entities/products_list_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  List<CartItemEntity> cartList = [];

  double get totalPrice =>
      cartList.fold(0.0, (t, i) => t + i.price * i.quantity);

  CartBloc() : super(CartInitial()) {
    on<CartEvent>((event, emit) {});
    on<AddCartEvent>(addCartEvent);
    on<UpdateCartEvent>(updateCartEvent);
    on<IsInCartEvent>(isInCartEvent);
    on<GetQuantityEvent>(getQuantityEvent);
    on<GetCartListEvent>(getCartListEvent);
  }

  FutureOr addCartEvent(AddCartEvent event, Emitter<CartState> emit) async {
    emit(AddCartLoadingState());

    final res = await sl<AddcartUsecase>().call(params: event.product);

    if (res.error != null) {
      emit(AddCartFailedState(error: res.error!.message));
    } else {
      emit(AddCartSuccessState());
    }
  }

  FutureOr updateCartEvent(
    UpdateCartEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(UpdateCartLoadingState());

    final res = await sl<UpdatecartUsecase>().call(
      params: UpdateQuantity(
        productId: event.productId,
        newQuantity: event.newQuantity,
      ),
    );

    if (res.error != null) {
      emit(UpdateCartFailedState(error: res.error!.message));
    } else {
      final cartRes = await sl<GetCartListUsecase>().call(params: null);

      if (cartRes.error != null) {
        emit(GetCartListFailedState(error: cartRes.error!.message));
      } else {
        cartList = cartRes.data ?? [];

        emit(UpdateCartSuccessState(quantity: event.newQuantity));
      }
    }
  }

  FutureOr isInCartEvent(IsInCartEvent event, Emitter<CartState> emit) async {
    emit(IsInCartLoadingState());

    final res = await sl<IsInCartUsecase>().call(params: event.productId);

    if (res.error != null) {
      emit(IsInCartFailedState(error: res.error!.message));
    } else {
      emit(
        IsInCartSuccessState(
          isInCart: res.data?['IsInCart'] ?? false,
          quantity: res.data?["Quantity"] ?? 0,
        ),
      );
    }
  }

  FutureOr getQuantityEvent(
    GetQuantityEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(GetQuantityLoadingState());

    final res = await sl<GetQuantityUsecase>().call(params: event.productId);

    if (res.error != null) {
      emit(GetQuantityFailedState(error: res.error!.message));
    } else {
      emit(GetQuantitySuccessState(quantity: res.data!));
    }
  }

  FutureOr getCartListEvent(
    GetCartListEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(GetCartListLoadingState());

    final res = await sl<GetCartListUsecase>().call(params: null);

    if (res.error != null) {
      emit(GetCartListFailedState(error: res.error!.message));
    } else {
      cartList = res.data ?? [];
      emit(GetCartListSuccessState());
    }
  }
}
