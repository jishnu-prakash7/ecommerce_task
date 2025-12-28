import 'package:ecommerce/core/resources/data_state.dart';
import 'package:ecommerce/features/products_list/domain/entities/products_list_entity.dart';

abstract class ProductsListRepository {
  Future<DataState<List<ProductsListEntity>>> fetchProductsList();
}
