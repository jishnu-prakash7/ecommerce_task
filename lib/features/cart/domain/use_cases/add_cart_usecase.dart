import 'package:ecommerce/core/resources/data_state.dart';
import 'package:ecommerce/core/resources/use_case.dart';
import 'package:ecommerce/features/cart/domain/repository/cart_repository.dart';
import 'package:ecommerce/features/products_list/data/models/products_list_model.dart';
import 'package:ecommerce/features/products_list/domain/entities/products_list_entity.dart';

class AddcartUsecase implements UseCase<DataState<bool>, ProductsListEntity> {
  final CartRepository _cartRepository;
  AddcartUsecase(this._cartRepository);
  @override
  Future<DataState<bool>> call({required ProductsListEntity params}) async {
    return await _cartRepository.addCart(
      product: ProductsListModel.fromEntity(params),
    );
  }
}
    