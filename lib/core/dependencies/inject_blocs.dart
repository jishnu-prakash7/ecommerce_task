part of 'dependencies.dart';

injectBlocs() {
  //Products List Bloc
  sl.registerSingleton(ProductsListBloc());

  //Cart Bloc
  sl.registerSingleton(CartBloc());

  //Wishlist Bloc
  sl.registerSingleton(WishlistBloc());
 }
