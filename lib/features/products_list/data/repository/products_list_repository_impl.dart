import 'package:ecommerce/core/resources/data_state.dart';
import 'package:ecommerce/features/products_list/data/data_sources/remote/products_list_remote_data_source.dart';
import 'package:ecommerce/features/products_list/domain/entities/products_list_entity.dart';
import 'package:ecommerce/features/products_list/domain/repository/products_list_repository.dart';
import 'package:flutter/foundation.dart';

class ProductsListRepositoryImpl implements ProductsListRepository {
  final ProductsListRemoteDataSource _productsListRemoteDataSource;

  ProductsListRepositoryImpl(this._productsListRemoteDataSource);

  @override
  Future<DataState<List<ProductsListEntity>>> fetchProductsList() async {
    try {
      final res = await _productsListRemoteDataSource.fetchProductsList();

      return DataSuccess(res);
    } on FlutterError catch (e) {
      return DataFailed(e);
    } 
  }
}
