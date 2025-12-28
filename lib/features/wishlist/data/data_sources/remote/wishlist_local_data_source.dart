import 'package:ecommerce/core/constants/custom_exceptions.dart';
import 'package:ecommerce/features/products_list/data/models/products_list_model.dart';
import 'package:ecommerce/features/wishlist/data/models/wishlist_item_model.dart';
import 'package:ecommerce/features/wishlist/domain/entities/wishlist_item_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';

class WishlistLocalDataSource {
  final wishlistBox = Hive.box<WishlistItemEntity>('wishlist_box');
  Future<bool> addWishlist({required ProductsListModel product}) async {
    try {
      if (!wishlistBox.containsKey(product.id)) {
        await wishlistBox.put(
          product.id,
          WishlistItemModel(
            id: product.id,
            title: product.title,
            price: product.price,
            image: product.image,
          ),
        );
      }
      return true;
    } catch (e) {
      throw CustomException("Something went wrong $e");
    }
  }

  Future<bool> removeWishlist(num productId) async {
    try {
      if (!wishlistBox.containsKey(productId)) {
        return false;
      } else {
        wishlistBox.delete(productId);
      }
      return true;
    } catch (e) {
      throw CustomException("Something went wrong $e");
    }
  }

  List<WishlistItemModel> getWishList() {
    try {
      final wishList = wishlistBox.values;

      return wishList
          .map((item) => WishlistItemModel.fromEntity(item))
          .toList();
    } catch (e) {
      throw CustomException("Something went wrong $e");
    }
  }

  bool isInWishlist(num productId) {
    try {
      return wishlistBox.containsKey(productId);
    } catch (e) {
      throw CustomException("something went wrong $e");
    }
  }
}
