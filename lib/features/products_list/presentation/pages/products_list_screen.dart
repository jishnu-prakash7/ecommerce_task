import 'package:ecommerce/core/dependencies/dependencies.dart';
import 'package:ecommerce/core/utils/size_config.dart';
import 'package:ecommerce/features/products_list/domain/entities/products_list_entity.dart';
import 'package:ecommerce/features/products_list/presentation/bloc/products_list_bloc.dart';
import 'package:ecommerce/features/products_list/presentation/widgets/loader.dart';
import 'package:ecommerce/features/products_list/presentation/widgets/product_card.dart';
import 'package:ecommerce/shared/common_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}
 
class _ProductListScreenState extends State<ProductListScreen> {
  final TextEditingController _searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> loadData() async {
    sl<ProductsListBloc>().add(FetchProductsListEvent());
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        sl<ProductsListBloc>().filteredProducts =
            sl<ProductsListBloc>().productsList;
      } else {
        sl<ProductsListBloc>().filteredProducts = sl<ProductsListBloc>()
            .productsList
            .where((product) {
              return product.title.toLowerCase().contains(query) ||
                  product.description.toLowerCase().contains(query);
            })
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        title: CustomText(
          fontSize: sizeHelper.getTextSize(16),
          text: "Clickcart",
          textColor: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: loadData,
        color: Colors.black,
        backgroundColor: Colors.white,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(sizeHelper.getWidgetHeight(15)),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search products...',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: sizeHelper.getTextSize(15),
                  ),
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: Icon(Icons.clear, color: Colors.grey),
                          onPressed: () {
                            _searchController.clear();
                          },
                        )
                      : null,
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: sizeHelper.getWidgetWidth(20),
                    vertical: sizeHelper.getWidgetWidth(15),
                  ),
                ),
              ),
            ),
            BlocConsumer<ProductsListBloc, ProductsListState>(
              bloc: sl<ProductsListBloc>(),
              listener: (context, state) {},
              builder: (context, state) {
                return state is FetchProductsListLoadingState
                    ? Expanded(child: shimmerGrid())
                    : state is FetchProductsListSuccessState
                    ? sl<ProductsListBloc>().filteredProducts.isEmpty
                          ? Expanded(
                              child: Center(
                                child: CustomText(
                                  fontSize: sizeHelper.getTextSize(15),
                                  text: "No products found!",
                                  textColor: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          : Expanded(
                              child: GridView.builder(
                                padding: EdgeInsets.symmetric(
                                  horizontal: sizeHelper.getWidgetHeight(12),
                                ),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: sizeHelper
                                          .getWidgetHeight(12),
                                      crossAxisSpacing: sizeHelper
                                          .getWidgetWidth(12),
                                      childAspectRatio: 0.8,
                                    ),
                                itemCount: sl<ProductsListBloc>()
                                    .filteredProducts
                                    .length,
                                itemBuilder: (context, index) {
                                  ProductsListEntity product =
                                      sl<ProductsListBloc>()
                                          .filteredProducts[index];
                                  return buildProductCard(product: product);
                                },
                              ),
                            )
                    : state is FetchProductsListFailedState
                    ? Expanded(
                        child: Center(
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
                                onPressed: loadData,
                                child: CustomText(
                                  fontSize: sizeHelper.getTextSize(16),
                                  text: "Retry",
                                  textColor: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
