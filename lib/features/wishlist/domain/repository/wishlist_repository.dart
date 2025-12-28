import 'package:ecommerce/core/resources/data_state.dart';
import 'package:ecommerce/features/products_list/data/models/products_list_model.dart';
import 'package:ecommerce/features/wishlist/domain/entities/wishlist_item_entity.dart';

abstract class WishlistRepository {
  Future<DataState<bool>> addWishlist({required ProductsListModel product});

  Future<DataState<bool>> isInWishlist({required num productId});

  Future<DataState<List<WishlistItemEntity>>> getWishlist();

  Future<DataState<bool>> removeWishlist({required num productId});
}
