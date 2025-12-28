import 'package:ecommerce/core/resources/data_state.dart';
import 'package:ecommerce/core/resources/use_case.dart';
import 'package:ecommerce/features/cart/domain/repository/cart_repository.dart';

class UpdateQuantity {
  final num productId;
  final int newQuantity;

  UpdateQuantity({required this.productId, required this.newQuantity});
}

class UpdatecartUsecase implements UseCase<DataState<void>, UpdateQuantity> {
  final CartRepository _cartRepository;
  UpdatecartUsecase(this._cartRepository);
  @override
  Future<DataState<bool>> call({required UpdateQuantity params}) async {
    return await _cartRepository.updateCart(
      productId: params.productId,
      newQuantity: params.newQuantity,
    );
  }
}
