part of 'dependencies.dart';

void injectUseCases() {
  // Products List
  sl.registerLazySingleton<FetchProductsListUseCase>(
    () => FetchProductsListUseCase(sl()),
  );

  // Add Cart
  sl.registerLazySingleton<AddcartUsecase>(() => AddcartUsecase(sl()));

  // Update Cart
  sl.registerLazySingleton<UpdatecartUsecase>(() => UpdatecartUsecase(sl()));

  // Is in Cart
  sl.registerLazySingleton<IsInCartUsecase>(() => IsInCartUsecase(sl()));

  // Get Quantity
  sl.registerLazySingleton<GetQuantityUsecase>(() => GetQuantityUsecase(sl()));

  // Get Cart List
  sl.registerLazySingleton<GetCartListUsecase>(() => GetCartListUsecase(sl()));

  // Add Wishlist
  sl.registerLazySingleton<AddwishlistUsecase>(() => AddwishlistUsecase(sl()));

  // Get Wishlist
  sl.registerLazySingleton<GetWishlistUsecase>(() => GetWishlistUsecase(sl()));

  // Is in Wishlist
  sl.registerLazySingleton<IsinWishlistUsecase>(
    () => IsinWishlistUsecase(sl()),
  );
  // Remove Wishlist
  sl.registerLazySingleton<RemoveWishlistUsecase>(
    () => RemoveWishlistUsecase(sl()),
  ); 
}
