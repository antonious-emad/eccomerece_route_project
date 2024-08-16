import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:eccemorce_route_project/features/home/data/data_sources/remote/remote_ds.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/api/api_manager.dart';
import '../../../../../core/api/end_points.dart';
import '../../../../../core/error/failures.dart';
import '../../../../signup/data/models/ErrorModel.dart';
import '../../models/CartModel.dart';
import '../../models/CategoryBrandsModel.dart';
import '../../models/ChangePasswordMessageModel.dart';
import '../../models/WishListModel.dart';

@Injectable(as: HomeTabRemoteDS)
class HomeTabRemoteDSImpl implements HomeTabRemoteDS {
  ApiManager apiManager;
  HomeTabRemoteDSImpl(this.apiManager);

  @override
  Future<Either<Failures, CategoryModel>> getCategories() async {
    try {
      Response response = await apiManager.getData(
          endPoint: EndPoints.getCategories, data: null);

      CategoryModel categoryModel = CategoryModel.fromJson(response.data);
      return Right(categoryModel);
    } on DioException catch (e) {
      return Left(RemoteFailures(e.toString()));
    }
  }

  @override
  Future<Either<Failures, CategoryModel>> getBrands() async {
    try {
      Response response =
          await apiManager.getData(endPoint: EndPoints.getBrands, data: null);

      CategoryModel brandsModel = CategoryModel.fromJson(response.data);
      return Right(brandsModel);
    } on DioException catch (e) {
      return Left(RemoteFailures(e.toString()));
    }
  }

  @override
  Future<Either<Failures, CartModel>> addToCart(
      String productId, String token) async {
    try {
      Response response = await apiManager.postData(
          endPoint: EndPoints.addToCart,
          body: {"productId": productId},
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

  Future<Either<Failures, CartModel>> updateProductQuantityToCart(
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



  @override
  Future<Either<Failures, WishListModel>> getWishList(String token) async {
    try {
      Response response = await apiManager.getData(
          endPoint: EndPoints.getWishList, data: null, token: token);

      WishListModel wishListModel = WishListModel.fromJson(response.data);
      return Right(wishListModel);
    } on DioException catch (e) {
      return Left(RemoteFailures(e.toString()));
    }
  }

  @override
  Future<Either<Failures, ChangePasswordMessageModel>> changePassword(
      String currentPassword,
      String password,
      String rePassword,
      String? token) async {
    try {
      Response response = await apiManager
          .putData(endPoint: EndPoints.changePassword, token: token, body: {
        "currentPassword": currentPassword,
        "password": password,
        "rePassword": rePassword
      });
      ChangePasswordMessageModel messageModel =
          ChangePasswordMessageModel.fromJson(response.data);
      return Right(messageModel);
    } on DioException catch (e) {
      Map<String, dynamic> response = jsonDecode(e.response.toString());
      ErrorModel errorModel = ErrorModel.fromJson(response);
      if (errorModel.message == "fail") {
        return Left(RemoteFailures(errorModel.errors?.msg ?? "Error"));
      } else {
        return Left(RemoteFailures(errorModel.message ?? "Error"));
      }
    }
  }
}
