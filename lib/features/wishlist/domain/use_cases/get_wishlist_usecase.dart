import 'package:ecommerce/core/resources/data_state.dart';
import 'package:ecommerce/core/resources/use_case.dart';
import 'package:ecommerce/features/wishlist/domain/entities/wishlist_item_entity.dart';
import 'package:ecommerce/features/wishlist/domain/repository/wishlist_repository.dart';

class GetWishlistUsecase
    implements UseCase<DataState<List<WishlistItemEntity>>, void> {
  final WishlistRepository _wishlistRepository;
  GetWishlistUsecase(this._wishlistRepository);
  @override
  Future<DataState<List<WishlistItemEntity>>> call({required void params}) async {
    return await _wishlistRepository.getWishlist();
  }
}
 