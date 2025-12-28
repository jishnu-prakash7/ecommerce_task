import 'package:dio/dio.dart';
import 'package:ecommerce/features/cart/data/data_sources/remote/cart_local_data_source.dart';
import 'package:ecommerce/features/cart/data/repository/cart_repository_impl.dart';
import 'package:ecommerce/features/cart/domain/repository/cart_repository.dart';
import 'package:ecommerce/features/cart/domain/use_cases/add_cart_usecase.dart';
import 'package:ecommerce/features/cart/domain/use_cases/get_cart_list_usecase.dart';
import 'package:ecommerce/features/cart/domain/use_cases/get_quantity_usecase.dart';
import 'package:ecommerce/features/cart/domain/use_cases/isincart_usecase.dart';
import 'package:ecommerce/features/cart/domain/use_cases/updatecart_usecase.dart';
import 'package:ecommerce/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:ecommerce/features/products_list/data/data_sources/remote/products_list_remote_data_source.dart';
import 'package:ecommerce/features/products_list/data/repository/products_list_repository_impl.dart';
import 'package:ecommerce/features/products_list/domain/repository/products_list_repository.dart';
import 'package:ecommerce/features/products_list/domain/use_cases/fetch_products_list_use_case.dart';
import 'package:ecommerce/features/products_list/presentation/bloc/products_list_bloc.dart';
import 'package:ecommerce/features/wishlist/data/data_sources/remote/wishlist_local_data_source.dart';
import 'package:ecommerce/features/wishlist/data/repository/wishlist_repository_impl.dart';
import 'package:ecommerce/features/wishlist/domain/repository/wishlist_repository.dart';
import 'package:ecommerce/features/wishlist/domain/use_cases/add_wishlist_usecase.dart';
import 'package:ecommerce/features/wishlist/domain/use_cases/get_wishlist_usecase.dart';
import 'package:ecommerce/features/wishlist/domain/use_cases/isin_wishlist_usecase.dart';
import 'package:ecommerce/features/wishlist/domain/use_cases/remove_wishlist_usecase.dart';
import 'package:ecommerce/features/wishlist/presentation/bloc/wishlist_bloc.dart';
import 'package:get_it/get_it.dart';

part 'inject_blocs.dart';
part 'inject_data_sources.dart';
part 'inject_repositories.dart';
part 'inject_use_cases.dart';

final GetIt sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerLazySingleton<Dio>(() => Dio(BaseOptions(
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 30),
      contentType: 'application/json')));

  // Data Sources
  injectDataSources();

  // Repositories
  injectRepositories();

  // Use Cases
  injectUseCases();

  // BLoCs
  injectBlocs();

}
