
  import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/core/dependencies/dependencies.dart';
import 'package:ecommerce/core/utils/size_config.dart';
import 'package:ecommerce/features/wishlist/domain/entities/wishlist_item_entity.dart';
import 'package:ecommerce/features/wishlist/presentation/bloc/wishlist_bloc.dart';
import 'package:ecommerce/shared/common_widgets/custom_dialog.dart';
import 'package:ecommerce/shared/common_widgets/custom_text.dart';
import 'package:flutter/material.dart';

Container wishlistCard(WishlistItemEntity item, BuildContext context) {
    return Container(
              padding: EdgeInsets.all(sizeHelper.getWidgetWidth(10)),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
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
                  CachedNetworkImage(
                    imageUrl: item.image,
                    width: sizeHelper.getWidgetWidth(100),
                    height: sizeHelper.getWidgetHeight(100),
                    fit: BoxFit.contain,
                  ),
                  SizedBox(width: sizeHelper.getWidgetWidth(10)),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: item.title,
                          fontSize: sizeHelper.getTextSize(14),
                          fontWeight: FontWeight.bold,
                          maxLines: 2,
                          overflow: TextOverflow.fade,
                        ),
                        SizedBox(height: sizeHelper.getWidgetHeight(5)),
                        CustomText(
                          text: "\$${item.price}",
                          fontSize: sizeHelper.getTextSize(14),
                          textColor: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                    onPressed: () {
                      customDialog(
                        context,
                        heading: "Remove from wishlist",
                        subHeading:
                            "Do you want to remove this item from your wishlist?",
                        onCancelTap: () => Navigator.pop(context),
                        onConfirmTap: () {
                          sl<WishlistBloc>().add(
                            RemoveWishlistEvent(productId: item.id),
                          );
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                ],
              ),
            );
  }