import 'package:ecommerce/core/dependencies/dependencies.dart';
import 'package:ecommerce/core/utils/size_config.dart';
import 'package:ecommerce/core/utils/size_helper.dart';
import 'package:ecommerce/features/cart/domain/entities/cart_item_entity.dart';
import 'package:ecommerce/features/splash/splash_screen.dart';
import 'package:ecommerce/features/wishlist/domain/entities/wishlist_item_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();

  await Hive.initFlutter();
  Hive.registerAdapter(CartItemEntityAdapter());
  await Hive.openBox<CartItemEntity>("cart_box");

  Hive.registerAdapter(WishlistItemEntityAdapter());
  await Hive.openBox<WishlistItemEntity>("wishlist_box");

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clickcart',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      builder: (BuildContext context, Widget? child) {
        final data = MediaQuery.of(
          context,
        ).copyWith(textScaler: const TextScaler.linear(1.0));
        sizeHelper = SizeHelper(
          kHeight: data.size.height,
          kWidth: data.size.width,
          kTextScaler: data.textScaler,
        );
        return MediaQuery(data: data, child: child!);
      },
      home: SplashScreen(),
    );
  }
}
