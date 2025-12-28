import 'package:ecommerce/core/constants/custom_exceptions.dart';
import 'package:ecommerce/features/cart/data/models/cart_item_model.dart';
import 'package:ecommerce/features/cart/domain/entities/cart_item_entity.dart';
import 'package:ecommerce/features/products_list/data/models/products_list_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CartLocalDataSource {
  final cartBox = Hive.box<CartItemEntity>('cart_box');
  Future<bool> addCart({required ProductsListModel product}) async {
    try {
      if (!cartBox.containsKey(product.id)) {
        await cartBox.put(
          product.id,
          CartItemModel(
            id: product.id,
            title: product.title,
            price: product.price,
            image: product.image,
            quantity: 1,
          ),
        );
      }
      return true;
    } catch (e) {
      throw CustomException("Something went wrong $e");
    }
  }

  Future<bool> updateCartQuantity({
    required num productId,
    required int newQuantity,
  }) async {
    try {
      if (!cartBox.containsKey(productId)) {
        return false;
      }

      if (newQuantity <= 0) {
        await cartBox.delete(productId);
      } else {
        final item = cartBox.get(productId)!;

        final updatedItem = CartItemModel(
          id: item.id,
          title: item.title,
          price: item.price,
          image: item.image,
          quantity: newQuantity,
        );

        await cartBox.put(productId, updatedItem);
      }

      return true;
    } catch (e) {
      throw CustomException("Something went wrong $e");
    }
  }

  List<CartItemModel> getCartList() {
    try {
      final cartList = cartBox.values;

      return cartList.map((item) => CartItemModel.fromEntity(item)).toList();
    } catch (e) {
      throw CustomException("Something went wrong $e");
    }
  }

  Map<String, dynamic> isInCart(num productId) {
    try {
      final isInCart = cartBox.containsKey(productId);
      final quantity = cartBox.get(productId)?.quantity ?? 0;

      Map<String, dynamic> data = {"IsInCart": isInCart, "Quantity": quantity};
      return data;
    } catch (e) {
      throw CustomException("something went wrong $e");
    }
  }

  int getQuantity(num productId) {
    try {
      return cartBox.get(productId)?.quantity ?? 0;
    } catch (e) {
      throw CustomException("something went wrong $e");
    }
  }
}
