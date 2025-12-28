import 'package:ecommerce/core/resources/data_state.dart';
import 'package:ecommerce/core/resources/use_case.dart';
import 'package:ecommerce/features/cart/domain/repository/cart_repository.dart';

class IsInCartUsecase implements UseCase<DataState<void>, num> {
  final CartRepository _cartRepository;
  IsInCartUsecase(this._cartRepository);
  @override
  Future<DataState<Map<String, dynamic>>> call({required num params}) async {
    return await _cartRepository.isInCart(productId: params);
  }
}
