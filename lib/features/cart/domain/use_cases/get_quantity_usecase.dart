import 'package:ecommerce/core/resources/data_state.dart';
import 'package:ecommerce/core/resources/use_case.dart';
import 'package:ecommerce/features/cart/domain/repository/cart_repository.dart';

class GetQuantityUsecase implements UseCase<DataState<void>, num> {
  final CartRepository _cartRepository;
  GetQuantityUsecase(this._cartRepository);
  @override
  Future<DataState<int>> call({required num params}) async {
    return await _cartRepository.getQuantity(productId: params);
  }
}
