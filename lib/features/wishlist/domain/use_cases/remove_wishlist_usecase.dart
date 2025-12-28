import 'package:ecommerce/core/resources/data_state.dart';
import 'package:ecommerce/core/resources/use_case.dart';
import 'package:ecommerce/features/wishlist/domain/repository/wishlist_repository.dart';

class RemoveWishlistUsecase implements UseCase<DataState<void>, num> {
  final WishlistRepository _wishlistRepository;
  RemoveWishlistUsecase(this._wishlistRepository);
  @override
  Future<DataState<bool>> call({required num params}) async {
    return await _wishlistRepository.removeWishlist(productId: params);
  }
}
