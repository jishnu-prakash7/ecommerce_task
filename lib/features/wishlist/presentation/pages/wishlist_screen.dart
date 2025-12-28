import 'package:ecommerce/core/dependencies/dependencies.dart';
import 'package:ecommerce/core/utils/size_config.dart';
import 'package:ecommerce/features/wishlist/presentation/bloc/wishlist_bloc.dart';
import 'package:ecommerce/features/wishlist/presentation/widgets/wishlist_card.dart';
import 'package:ecommerce/shared/common_widgets/custom_appbar.dart';
import 'package:ecommerce/shared/common_widgets/custom_snackbar.dart';
import 'package:ecommerce/shared/common_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: customAppbar(context, title: "Wishlist"),
      body: BlocConsumer<WishlistBloc, WishlistState>(
        listenWhen: (previous, current) =>
            current is RemoveWishlistSuccessState ||
            current is RemoveWishlistFailedState,
        listener: (context, state) {
          if (state is RemoveWishlistSuccessState) {
            sl<WishlistBloc>().add(GetWishlistEvent());
          } else if (state is RemoveWishlistFailedState) {
            ScaffoldMessenger.of(context).clearSnackBars();
            customSnackbar(context, state.error);
          }
        },
        bloc: sl<WishlistBloc>(),
        buildWhen: (previous, current) =>
            current is GetWishlistLoadingState ||
            current is GetWishlistFailedState ||
            current is GetWishlistSuccessState,
        builder: (context, state) {
          if (state is GetWishlistLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is GetWishlistFailedState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: state.error,
                    fontSize: sizeHelper.getTextSize(15),
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: sizeHelper.getWidgetHeight(10)),
                  ElevatedButton(
                    onPressed: () {
                      sl<WishlistBloc>().add(GetWishlistEvent());
                    },
                    child: const Text("Retry"),
                  ),
                ],
              ),
            );
          }

          final wishlist = sl<WishlistBloc>().wishlist;

          if (wishlist.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_border,
                    size: sizeHelper.getTextSize(50),
                    color: Colors.grey,
                  ),
                  SizedBox(height: sizeHelper.getWidgetHeight(10)),
                  CustomText(
                    text: "Your wishlist is empty",
                    fontSize: sizeHelper.getTextSize(15),
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            );
          }

          return ListView.separated(
            padding: EdgeInsets.all(sizeHelper.getWidgetWidth(15)),
            itemCount: wishlist.length,
            separatorBuilder: (context, index) =>
                SizedBox(height: sizeHelper.getWidgetHeight(10)),
            itemBuilder: (context, index) {
              final item = wishlist[index];

              return wishlistCard(item, context);
            },
          );
        },
      ),
    );
  }
}
