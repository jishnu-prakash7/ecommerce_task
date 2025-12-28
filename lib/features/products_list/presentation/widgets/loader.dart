import 'package:ecommerce/core/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget shimmerGrid() {
  return GridView.builder(
    padding: EdgeInsets.all(sizeHelper.getWidgetWidth(12)),
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      mainAxisSpacing: sizeHelper.getWidgetWidth(12),
      crossAxisSpacing: sizeHelper.getWidgetWidth(12),
      childAspectRatio: 0.9,
    ),
    itemCount: 6,
    itemBuilder: (context, index) {
      return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: sizeHelper.getWidgetHeight(20),
                margin: EdgeInsets.symmetric(
                  horizontal: sizeHelper.getWidgetWidth(20),
                ),
                color: Colors.white,
              ),
            ],
          ),
        ),
      );
    },
  );
}
