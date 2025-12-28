import 'package:ecommerce/core/resources/data_state.dart';
import 'package:ecommerce/features/products_list/data/models/products_list_model.dart';
import 'package:ecommerce/features/wishlist/data/data_sources/remote/wishlist_local_data_source.dart';
import 'package:ecommerce/features/wishlist/domain/entities/wishlist_item_entity.dart';
import 'package:ecommerce/features/wishlist/domain/repository/wishlist_repository.dart';
import 'package:flutter/foundation.dart';

class WishlistRepositoryImpl implements WishlistRepository {
  final WishlistLocalDataSource _wishlistLocalDataSource;

  WishlistRepositoryImpl(this._wishlistLocalDataSource);

  @override
  Future<DataState<bool>> addWishlist({
    required ProductsListModel product,
  }) async {
    try {
      final res = await _wishlistLocalDataSource.addWishlist(product: product);
      return DataSuccess(res);
    } on FlutterError catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<bool>> isInWishlist({required num productId}) async {
    try {
      final res = _wishlistLocalDataSource.isInWishlist(productId);
      return DataSuccess(res);
    } on FlutterError catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<List<WishlistItemEntity>>> getWishlist() async {
    try {
      final res = _wishlistLocalDataSource.getWishList();
      return DataSuccess(res);
    } on FlutterError catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<bool>> removeWishlist({required num productId}) async {
    try {
      final res = await _wishlistLocalDataSource.removeWishlist(productId);
      return DataSuccess(res);
    } on FlutterError catch (e) {
      return DataFailed(e);
    }
  }
}
 