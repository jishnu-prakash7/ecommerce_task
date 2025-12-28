part of 'dependencies.dart';

void injectDataSources() {
  // Products List
  sl.registerLazySingleton<ProductsListRemoteDataSource>(
    () => ProductsListRemoteDataSource(sl()),
  );

  // Cart
  sl.registerLazySingleton<CartLocalDataSource>(() => CartLocalDataSource());

  // Wishlist
  sl.registerLazySingleton<WishlistLocalDataSource>(
    () => WishlistLocalDataSource(),
  );
}
