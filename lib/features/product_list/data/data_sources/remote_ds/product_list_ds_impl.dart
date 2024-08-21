import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:eccemorce_route_project/features/product_list/data/data_sources/remote_ds/product_list_ds.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/api/api_manager.dart';
import '../../../../../core/api/end_points.dart';
import '../../../../../core/error/failures.dart';
import '../../../../home/data/models/CartModel.dart';
import '../../../../signup/data/models/ErrorModel.dart';
import '../../models/ProductModel.dart';

@Injectable(as: ProductRemoteDS)
class ProductRemoteDSImpl implements ProductRemoteDS {
  ApiManager apiManager;
  ProductRemoteDSImpl(this.apiManager);

  @override
  Future<Either<Failures, ProductModel>> getProducts() async {
    try {
      Response response =
          await apiManager.getData(endPoint: EndPoints.productList, data: null);
      ProductModel productModel = ProductModel.fromJson(response.data);
      // print(productModel.results ?? "no results");

      return Right(productModel);
    } catch (e) {
      // print(e.toString());
      return Left(RemoteFailures(e.toString()));
    }
  }

  @override
  Future<Either<Failures, CartModel>> getCarts(String token) async {
    try {
      Response response = await apiManager.getData(
          endPoint: EndPoints.getCart, data: null, token: token);
      CartModel cartModel = CartModel.fromJson(response.data);
      print(cartModel.data?? "no results");

      return Right(cartModel);
    } catch (e) {
      print(e.toString());

      return Left(RemoteFailures(e.toString()));
    }
  }

  @override
  Future<void> addToWishList(String token, String productId) async {
    try {
      apiManager.postData(
          endPoint: EndPoints.addToWishList,
          token: token,
          body: {"productId": productId});
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Future<void> delFromWishList(String productId, String token) async {
    try {
      apiManager.delData(
        endPoint: EndPoints.deleteFromWishList,
        token: token,
        productId: productId,
        body: null,
      );
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Future<Either<Failures, CartModel>> updateCart(
      String productId,int count ,String token) async {
    try {
      Response response = await apiManager.putData(
          endPoint: "${EndPoints.updateProductQuantityToCart}/$productId",
          body: {"count": count},
          token: token);

      CartModel cartModel = CartModel.fromJson(response.data);
      return Right(cartModel);
    } on DioException catch (e) {
      Map<String, dynamic> response = jsonDecode(e.response.toString());
      ErrorModel errorModel = ErrorModel.fromJson(response);
      print(errorModel.message ?? "");
      return Left(RemoteFailures(errorModel.message.toString()));
    }
  }





}
