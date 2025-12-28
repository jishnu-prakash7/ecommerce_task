import 'package:ecommerce/core/resources/data_state.dart';
import 'package:ecommerce/core/resources/use_case.dart';
import 'package:ecommerce/features/products_list/data/models/products_list_model.dart';
import 'package:ecommerce/features/products_list/domain/entities/products_list_entity.dart';
import 'package:ecommerce/features/wishlist/domain/repository/wishlist_repository.dart';

class AddwishlistUsecase
    implements UseCase<DataState<void>, ProductsListEntity> {
  final WishlistRepository _wishlistRepository;
  AddwishlistUsecase(this._wishlistRepository);
  @override
  Future<DataState<bool>> call({required ProductsListEntity params}) async {
    return await _wishlistRepository.addWishlist(
      product: ProductsListModel.fromEntity(params),
    );
  }
}
