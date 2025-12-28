import 'package:ecommerce/core/utils/size_config.dart';
import 'package:ecommerce/shared/common_widgets/custom_text.dart';
import 'package:flutter/material.dart';

AppBar customAppbar(BuildContext context, {required String title}) {
  return AppBar(
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.white,
    automaticallyImplyLeading: false,
    // leading: InkWell(
    //   splashFactory: NoSplash.splashFactory,
    //   onTap: () => Navigator.pop(context),
    //   child: const Icon(Icons.arrow_back_ios),
    // ),
    title: CustomText(
      text: title,
      fontSize: sizeHelper.getTextSize(17),
      fontWeight: FontWeight.bold,
    ),
  );
}
 