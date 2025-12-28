import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ecommerce/core/constants/api_end_points.dart';
import 'package:ecommerce/core/constants/custom_exceptions.dart';
import 'package:ecommerce/features/products_list/data/models/products_list_model.dart';

class ProductsListRemoteDataSource {
  final Dio dio;

  ProductsListRemoteDataSource(this.dio);
  //fetch products list
  Future<List<ProductsListModel>> fetchProductsList() async {
    try {
      final url = ApiEndPoints.baseUrl + ApiEndPoints.fetchProductsList;

      log("fetch products list url $url");

      final response = await dio.get(url);
      log('fetch products list response: $response');
      if (response.statusCode == 200 || response.statusCode == 201) {
        return (response.data as List).map((json) {
          return ProductsListModel.fromJson(json);
        }).toList();
      } else {
        throw CustomException("Something went wrong");
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.connectionError) {
        throw CustomException("Connection Error!");
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw CustomException("Receive timeout!");
      } else if (e.type == DioExceptionType.sendTimeout) {
        throw CustomException("Send timeout!");
      } else if (e.type == DioExceptionType.badCertificate) {
        throw CustomException("${e.message}!");
      } else if (e.type == DioExceptionType.badResponse) {
        throw CustomException("${e.message}!");
      } else {
        if (e.response == null || e.response!.statusCode == null) {
          throw CustomException();
        } else if (e.response!.statusCode! >= 400 &&
            e.response!.statusCode! < 500) {
          if (e.response!.statusCode == null) {
            throw CustomException("oops An Unexpected Error Occured");
          } else {
            throw CustomException(
              e.response!.data["message"] ?? "oops An Unexpected Error Occured",
            );
          }
        } else {
          throw CustomException("oops An Unexpected Error Occured");
        }
      }
    }
  }
}
