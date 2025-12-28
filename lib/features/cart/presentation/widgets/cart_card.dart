import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/core/utils/size_config.dart';
import 'package:ecommerce/features/cart/domain/entities/cart_item_entity.dart';
import 'package:ecommerce/shared/common_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget cartCard({
  required CartItemEntity product,
  required int quantity,
  required VoidCallback removeTap,
  required VoidCallback addTap,
}) {
  return Container(
    height: sizeHelper.getWidgetHeight(120),
    width: sizeHelper.kWidth,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
     boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.2),
        blurRadius: 10,
        spreadRadius: 1,
        offset: Offset(1, 2), 
      ),
    ],

    ),
    child: Row(
      children: [
        Container(
          margin: EdgeInsets.all(sizeHelper.getWidgetHeight(10)),
          width: sizeHelper.getWidgetHeight(100),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: CachedNetworkImage(
            imageUrl: product.image,
            placeholder: (context, url) => Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            errorWidget: (context, url, error) => Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Icon(Icons.image_not_supported, color: Colors.grey),
              ),
            ),
          ),
        ),

        Padding(
          padding: EdgeInsets.symmetric(
            vertical: sizeHelper.getWidgetHeight(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: sizeHelper.kWidth / 2.5,
                child: CustomText(
                  fontSize: sizeHelper.getTextSize(14),
                  text: product.title,
                  fontWeight: FontWeight.bold,
                  maxLines: 2,
                  overflow: TextOverflow.fade,
                ),
              ),

              SizedBox(height: sizeHelper.getWidgetHeight(10)),

              Expanded(
                      child: CustomText(
                        fontSize: sizeHelper.getTextSize(15),
                        text: "\$${product.price}",
                        fontWeight: FontWeight.w500,
                        textColor: Colors.green,
                        maxLines: 2,
                        overflow: TextOverflow.fade,
                      ),
                    ),

              Row(
                children: [
                  InkWell(
                    onTap: removeTap,
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Icon(Icons.remove, size: 18),
                    ),
                  ),
                  SizedBox(width: sizeHelper.getWidgetWidth(8)),
                  SizedBox(
                    width: 20,
                    child: CustomText(
                      align: TextAlign.center,
                      fontSize: sizeHelper.getTextSize(15),
                      text: "$quantity",
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  SizedBox(width: sizeHelper.getWidgetWidth(8)),
                  InkWell(
                    onTap: addTap,
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(children: [Icon(Icons.add, size: 18)]),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
