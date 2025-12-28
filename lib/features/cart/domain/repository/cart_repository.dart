import 'package:ecommerce/core/resources/data_state.dart';
import 'package:ecommerce/features/cart/domain/entities/cart_item_entity.dart';
import 'package:ecommerce/features/products_list/data/models/products_list_model.dart';

abstract class CartRepository {
  Future<DataState<bool>> addCart({required ProductsListModel product});
  Future<DataState<bool>> updateCart({
    required num productId,
    required int newQuantity,
  });
  Future<DataState<Map<String, dynamic>>> isInCart({required num productId});
  Future<DataState<int>> getQuantity({required num productId});
  Future<DataState<List<CartItemEntity>>> getCartList();
}
 