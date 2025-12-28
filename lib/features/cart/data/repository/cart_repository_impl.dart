import 'package:ecommerce/core/resources/data_state.dart';
import 'package:ecommerce/features/cart/data/data_sources/remote/cart_local_data_source.dart';
import 'package:ecommerce/features/cart/domain/entities/cart_item_entity.dart';
import 'package:ecommerce/features/cart/domain/repository/cart_repository.dart';
import 'package:ecommerce/features/products_list/data/models/products_list_model.dart';
import 'package:flutter/foundation.dart';

class CartRepositoryImpl implements CartRepository {
  final CartLocalDataSource _cartLocalDataSource;

  CartRepositoryImpl(this._cartLocalDataSource);

  @override
  Future<DataState<bool>> addCart({required ProductsListModel product}) async {
    try {
      final res = await _cartLocalDataSource.addCart(product: product);
      return DataSuccess(res);
    } on FlutterError catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<bool>> updateCart({
    required num productId,
    required int newQuantity,
  }) async {
    try {
      final res = await _cartLocalDataSource.updateCartQuantity(
        productId: productId,
        newQuantity: newQuantity,
      );
      return DataSuccess(res);
    } on FlutterError catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<Map<String, dynamic>>> isInCart({required num productId}) async {
    try {
      final res = _cartLocalDataSource.isInCart(productId);
      return DataSuccess(res);
    } on FlutterError catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<int>> getQuantity({required num productId}) async {
    try {
      final res = _cartLocalDataSource.getQuantity(productId);
      return DataSuccess(res);
    } on FlutterError catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<List<CartItemEntity>>> getCartList() async {
    try {
      final res = _cartLocalDataSource.getCartList();
      return DataSuccess(res);
    } on FlutterError catch (e) {
      return DataFailed(e);
    }
  }
}
