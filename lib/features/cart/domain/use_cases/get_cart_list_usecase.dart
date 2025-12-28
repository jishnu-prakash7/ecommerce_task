import 'package:ecommerce/core/resources/data_state.dart';
import 'package:ecommerce/core/resources/use_case.dart';
import 'package:ecommerce/features/cart/domain/entities/cart_item_entity.dart';
import 'package:ecommerce/features/cart/domain/repository/cart_repository.dart';

class GetCartListUsecase
    implements UseCase<DataState<List<CartItemEntity>>, void> {
  final CartRepository _cartRepository;
  GetCartListUsecase(this._cartRepository);
  @override
  Future<DataState<List<CartItemEntity>>> call({required void params}) async {
    return await _cartRepository.getCartList();
  }
}
 