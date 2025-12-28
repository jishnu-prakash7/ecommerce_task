import 'package:ecommerce/core/dependencies/dependencies.dart';
import 'package:ecommerce/core/utils/size_config.dart';
import 'package:ecommerce/features/cart/data/data_sources/remote/cart_local_data_source.dart';
import 'package:ecommerce/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:ecommerce/features/products_list/domain/entities/products_list_entity.dart';
import 'package:ecommerce/features/products_list/presentation/pages/product_detail_screen.dart';
import 'package:ecommerce/features/products_list/presentation/widgets/cached_product_image.dart';
import 'package:ecommerce/shared/common_widgets/custom_snackbar.dart';
import 'package:ecommerce/shared/common_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget buildProductCard({required ProductsListEntity product}) {
  bool isInCart = CartLocalDataSource().isInCart(product.id)['IsInCart'];
  int quantity = CartLocalDataSource().getQuantity(product.id);
  return BlocConsumer<CartBloc, CartState>(
    bloc: sl<CartBloc>(),
    listener: (context, state) {
      if (state is AddCartFailedState) {
         ScaffoldMessenger.of(context).clearSnackBars();
        customSnackbar(context, state.error);
      } else if (state is UpdateCartFailedState) {
         ScaffoldMessenger.of(context).clearSnackBars();
        customSnackbar(context, state.error);
      } else {
        isInCart = CartLocalDataSource().isInCart(product.id)["IsInCart"];
        quantity = CartLocalDataSource().getQuantity(product.id);
      }
    },
    builder: (context, state) {
      return InkWell(
        splashColor: Colors.transparent,
        hoverColor: Colors.transparent,
        focusColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailsScreen(product: product),
            ),
          );
        },
        child: Card(
          color: Colors.white,
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(sizeHelper.getWidgetWidth(13)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: CachedProductImage(
                  imageUrl: product.image,
                  width: double.infinity,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(sizeHelper.getWidgetWidth(8)),
                child: CustomText(
                  fontSize: sizeHelper.getTextSize(15),
                  text: product.title,
                  fontWeight: FontWeight.bold,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textColor: Colors.black,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(sizeHelper.getWidgetWidth(8)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
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
                        if (isInCart)
                          InkWell(
                            onTap: () async {
                              // if (quantity - 1 <= 0) {
                              //   await cartController.removeFromCart(product.id);
                              // } else {
                              //   await cartController.updateQuantity(
                              //       product.id, quantity - 1);
                              // }
                              sl<CartBloc>().add(
                                UpdateCartEvent(
                                  productId: product.id,
                                  newQuantity: quantity - 1,
                                ),
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Icon(Icons.remove, size: 18),
                            ),
                          ),
                        if (isInCart)
                          SizedBox(width: sizeHelper.getWidgetWidth(8)),
                        if (isInCart)
                          SizedBox(
                            width: 20,
                            child: CustomText(
                              align: TextAlign.center,
                              fontSize: sizeHelper.getTextSize(15),
                              text: "$quantity",
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        if (isInCart)
                          SizedBox(width: sizeHelper.getWidgetWidth(8)),
                        isInCart
                            ? InkWell(
                                onTap: () async {
                                  if (isInCart) {
                                    sl<CartBloc>().add(
                                      UpdateCartEvent(
                                        productId: product.id,
                                        newQuantity: quantity + 1,
                                      ),
                                    );
                                  } else {
                                    sl<CartBloc>().add(
                                      AddCartEvent(product: product),
                                    );
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Row(
                                    children: [Icon(Icons.add, size: 18)],
                                  ),
                                ),
                              )
                            : InkWell(
                                splashColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                splashFactory: NoSplash.splashFactory,
                                onTap: () => sl<CartBloc>().add(
                                  AddCartEvent(product: product),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CustomText(
                                      fontSize: sizeHelper.getTextSize(12),
                                      text: "Add to Cart",
                                      textColor: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
