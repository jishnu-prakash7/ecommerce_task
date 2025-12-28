import 'package:ecommerce/core/resources/data_state.dart';
import 'package:ecommerce/core/resources/use_case.dart';
import 'package:ecommerce/features/products_list/domain/entities/products_list_entity.dart';
import 'package:ecommerce/features/products_list/domain/repository/products_list_repository.dart';

class FetchProductsListUseCase
    implements UseCase<DataState<List<ProductsListEntity>>, void> {
  final ProductsListRepository _productsListRepository;

  FetchProductsListUseCase(this._productsListRepository);

  @override
  Future<DataState<List<ProductsListEntity>>> call({void params}) async {
    return await _productsListRepository.fetchProductsList();
  }
}
