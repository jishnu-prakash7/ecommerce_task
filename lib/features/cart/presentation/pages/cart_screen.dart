import 'package:ecommerce/core/dependencies/dependencies.dart';
import 'package:ecommerce/core/utils/size_config.dart';
import 'package:ecommerce/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:ecommerce/features/cart/presentation/widgets/cart_card.dart';
import 'package:ecommerce/shared/common_widgets/custom_appbar.dart';
import 'package:ecommerce/shared/common_widgets/custom_dialog.dart';
import 'package:ecommerce/shared/common_widgets/custom_snackbar.dart';
import 'package:ecommerce/shared/common_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => CartScreenState();
}

class CartScreenState extends State<CartScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: customAppbar(context, title: "Cart"),
      body: BlocConsumer<CartBloc, CartState>(
        bloc: sl<CartBloc>(),
        listenWhen: (previous, current) =>
            current is UpdateCartSuccessState ||
            current is UpdateCartFailedState,
        listener: (context, state) {
          if (state is UpdateCartSuccessState) {
            if (state.quantity == 0) {
              sl<CartBloc>().add(GetCartListEvent());
            }
          } else if (state is UpdateCartFailedState) {
            ScaffoldMessenger.of(context).clearSnackBars();
            customSnackbar(context, state.error);
          }
        },
        buildWhen: (previous, current) =>
            current is GetCartListSuccessState ||
            current is GetCartListLoadingState ||
            current is GetCartListFailedState ||
            current is UpdateCartSuccessState,
        builder: (context, state) {
          if (state is GetCartListLoadingState) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is GetCartListFailedState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    fontSize: sizeHelper.getTextSize(15),
                    text: state.error,
                    textColor: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: sizeHelper.getWidgetHeight(10)),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                    ),
                    onPressed: () {
                      sl<CartBloc>().add(GetCartListEvent());
                    },
                    child: CustomText(
                      fontSize: sizeHelper.getTextSize(16),
                      text: "Retry",
                      textColor: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          }

          final products = sl<CartBloc>().cartList;

          if (products.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.grey,
                  size: sizeHelper.getTextSize(50),
                ),

                SizedBox(height: sizeHelper.getWidgetHeight(10)),

                Center(
                  child: CustomText(
                    fontSize: sizeHelper.getTextSize(15),
                    text: "Your cart is empty",
                    textColor: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            );
          }

          return ListView.separated(
            itemCount: products.length,
            shrinkWrap: true,
            separatorBuilder: (context, index) =>
                SizedBox(height: sizeHelper.getWidgetHeight(10)),
            padding: EdgeInsets.all(sizeHelper.getWidgetWidth(15)),
            itemBuilder: (context, index) {
              final product = products[index];
              int quantity = product.quantity;

              return cartCard(
                product: product,
                quantity: quantity,
                removeTap: () async {
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
                            productId: product.id,
                            newQuantity: quantity - 1,
                          ),
                        );
                        Navigator.pop(context);
                      },
                    );
                  } else {
                    sl<CartBloc>().add(
                      UpdateCartEvent(
                        productId: product.id,
                        newQuantity: quantity - 1,
                      ),
                    );
                  }
                },
                addTap: () async {
                  sl<CartBloc>().add(
                    UpdateCartEvent(
                      productId: product.id,
                      newQuantity: quantity + 1,
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      bottomNavigationBar: BlocBuilder<CartBloc, CartState>(
        bloc: sl<CartBloc>(),
        builder: (context, state) {
          return sl<CartBloc>().totalPrice == 0
              ? SizedBox()
              : Padding(
                  padding: EdgeInsets.all(sizeHelper.getWidgetWidth(15)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: "Total",
                        fontSize: sizeHelper.getTextSize(16),
                        fontWeight: FontWeight.bold,
                      ),
                      CustomText(
                        text:
                            "\$${sl<CartBloc>().totalPrice.toStringAsFixed(2)}",
                        fontSize: sizeHelper.getTextSize(18),
                        fontWeight: FontWeight.bold,
                        textColor: Colors.green,
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
