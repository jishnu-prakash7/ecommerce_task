import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/core/dependencies/dependencies.dart';
import 'package:ecommerce/core/utils/size_config.dart';
import 'package:ecommerce/features/cart/data/data_sources/remote/cart_local_data_source.dart';
import 'package:ecommerce/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:ecommerce/features/products_list/domain/entities/products_list_entity.dart';
import 'package:ecommerce/features/wishlist/presentation/bloc/wishlist_bloc.dart';
import 'package:ecommerce/shared/common_widgets/custom_dialog.dart';
import 'package:ecommerce/shared/common_widgets/custom_snackbar.dart';
import 'package:ecommerce/shared/common_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductsListEntity product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  bool isInCart = false;
  bool isInWishlist = false;
  int quantity = 0;

  @override
  void initState() {
    sl<WishlistBloc>().add(IsInWishlistEvent(productId: widget.product.id));
    isInCart = CartLocalDataSource().isInCart(widget.product.id)["IsInCart"];
    quantity = CartLocalDataSource().getQuantity(widget.product.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        leading: InkWell(
          splashFactory: NoSplash.splashFactory,
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back_ios),
        ),
        title: CustomText(
          fontSize: sizeHelper.getTextSize(15),
          text: widget.product.title,
          fontWeight: FontWeight.w500,
          maxLines: 2,
          overflow: TextOverflow.fade,
        ),
      ),

      body: BlocConsumer<CartBloc, CartState>(
        bloc: sl<CartBloc>(),
        listener: (context, state) {
          if (state is AddCartFailedState) {
            ScaffoldMessenger.of(context).clearSnackBars();
            customSnackbar(context, state.error);
          } else if (state is UpdateCartFailedState) {
            ScaffoldMessenger.of(context).clearSnackBars();
            customSnackbar(context, state.error);
          } else {
            isInCart = CartLocalDataSource().isInCart(widget.product.id)["IsInCart"];
            quantity = CartLocalDataSource().getQuantity(widget.product.id);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: CachedNetworkImage(
                    imageUrl: widget.product.image,
                    fit: BoxFit.contain,
                    errorWidget: (context, url, error) => Container(
                      color: Colors.grey[200],
                      child: const Icon(Icons.image_not_supported),
                    ),
                  ),
                ),

                SizedBox(height: sizeHelper.getWidgetHeight(16)),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CustomText(
                    fontSize: sizeHelper.getTextSize(18),
                    text: widget.product.title,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: sizeHelper.getWidgetHeight(8)),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CustomText(
                    fontSize: sizeHelper.getTextSize(18),
                    text: "\$${widget.product.price}",
                    fontWeight: FontWeight.w600,
                    textColor: Colors.green,
                  ),
                ),

                SizedBox(height: sizeHelper.getWidgetHeight(12)),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      const Icon(Icons.star, color: Colors.orange, size: 18),
                      SizedBox(width: sizeHelper.getWidgetWidth(4)),
                      CustomText(
                        fontSize: sizeHelper.getTextSize(14),
                        text:
                            "${widget.product.rating.rate} (${widget.product.rating.count})",
                      ),
                    ],
                  ),
                ),

                SizedBox(height: sizeHelper.getWidgetHeight(16)),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CustomText(
                    fontWeight: FontWeight.normal,
                    fontSize: sizeHelper.getTextSize(15),
                    text: widget.product.description,
                    textColor: Colors.black87,
                  ),
                ),

                SizedBox(height: sizeHelper.getWidgetHeight(80)),
              ],
            ),
          );
        },
      ),

      bottomNavigationBar: BlocBuilder<CartBloc, CartState>(
        bloc: sl<CartBloc>(),
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                isInCart
                    ? Container(
                        width: sizeHelper.kWidth / 2.2,
                        height: sizeHelper.getWidgetHeight(45),

                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            if (isInCart)
                              InkWell(
                                onTap: () async {
                                  if (quantity - 1 == 0) {
                                    customDialog(
                                      context,
                                      heading: "Remove item from cart",
                                      subHeading:
                                          "Do you want to remove this item from your cart?",
                                      onCancelTap: () => Navigator.pop(context),
                                      onConfirmTap: () {
                                        sl<CartBloc>().add(
                                          UpdateCartEvent(
                                            productId: widget.product.id,
                                            newQuantity: quantity - 1,
                                          ),
                                        );
                                        Navigator.pop(context);
                                      },
                                    );
                                  } else {
                                    sl<CartBloc>().add(
                                      UpdateCartEvent(
                                        productId: widget.product.id,
                                        newQuantity: quantity - 1,
                                      ),
                                    );
                                  }
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
                              SizedBox(
                                width: 20,
                                child: CustomText(
                                  align: TextAlign.center,
                                  fontSize: sizeHelper.getTextSize(20),

                                  text: "$quantity",
                                  fontWeight: FontWeight.w500,
                                ),
                              ),

                            InkWell(
                              onTap: () async {
                                if (isInCart) {
                                  sl<CartBloc>().add(
                                    UpdateCartEvent(
                                      productId: widget.product.id,
                                      newQuantity: quantity + 1,
                                    ),
                                  );
                                } else {
                                  sl<CartBloc>().add(
                                    AddCartEvent(product: widget.product),
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
                            ),
                          ],
                        ),
                      )
                    : SizedBox(
                        width: sizeHelper.kWidth / 2.2,
                        height: sizeHelper.getWidgetHeight(45),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            backgroundColor: Colors.blue,
                          ),
                          onPressed: () {
                            sl<CartBloc>().add(
                              AddCartEvent(product: widget.product),
                            );
                          },
                          child: CustomText(
                            fontSize: sizeHelper.getTextSize(15),
                            text: "Add to Cart",
                            textColor: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                BlocConsumer<WishlistBloc, WishlistState>(
                  bloc: sl<WishlistBloc>(),
                  listener: (context, state) {
                    if (state is AddWishlistSuccessState) {
                      ScaffoldMessenger.of(context).clearSnackBars();
                      customSnackbar(context, "Product added to wishlist");
                      sl<WishlistBloc>().add(
                        IsInWishlistEvent(productId: widget.product.id),
                      );
                    } else if (state is IsInWishWishlistSuccessState) {
                      isInWishlist = state.isInWishlist;
                    } else if (state is RemoveWishlistSuccessState) {
                      isInWishlist = false;
                    }
                  },
                  builder: (context, state) {
                    return SizedBox(
                      width: sizeHelper.kWidth / 2.2,
                      height: sizeHelper.getWidgetHeight(45),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          side: const BorderSide(),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),

                          padding: const EdgeInsets.symmetric(vertical: 14),
                          backgroundColor: Colors.white,
                        ),
                        onPressed: () {
                          if (isInWishlist) {
                            customDialog(
                              context,
                              heading: "Remove item from wishlist",
                              subHeading:
                                  "Do you want to remove this item from your wishlist?",
                              onCancelTap: () => Navigator.pop(context),
                              onConfirmTap: () {
                                sl<WishlistBloc>().add(
                                  RemoveWishlistEvent(
                                    productId: widget.product.id,
                                  ),
                                );
                                Navigator.pop(context);
                              },
                            );
                          } else {
                            sl<WishlistBloc>().add(
                              AddWishlistEvent(product: widget.product),
                            );
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.shopping_bag_outlined,
                              color: Colors.black,
                              size: sizeHelper.getTextSize(20),
                            ),
                            SizedBox(width: sizeHelper.getWidgetWidth(5)),
                            CustomText(
                              fontSize: sizeHelper.getTextSize(14),
                              text: isInWishlist
                                  ? "Remove from Wishlist"
                                  : "Add to Wishlist",
                              textColor: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
