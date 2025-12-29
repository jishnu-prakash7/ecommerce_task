import 'package:ecommerce/core/utils/size_config.dart';
import 'package:ecommerce/home.dart';
import 'package:ecommerce/shared/common_widgets/custom_text.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      route();
    });
    super.initState();
  }

  route() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomText(
          fontSize: sizeHelper.getTextSize(23),
          text: "Clickcart",
          fontWeight: FontWeight.w900,
          textColor: Colors.black,
        ),
      ),
    );
  }
}
