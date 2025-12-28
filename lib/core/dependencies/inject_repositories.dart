part of 'dependencies.dart';

void injectRepositories() {
  // Products List
  sl.registerLazySingleton<ProductsListRepository>(
    () => ProductsListRepositoryImpl(sl()),
  );

  // Cart
  sl.registerLazySingleton<CartRepository>(() => CartRepositoryImpl(sl()));

  // Wishlist
  sl.registerLazySingleton<WishlistRepository>(
    () => WishlistRepositoryImpl(sl()),
  );
}
