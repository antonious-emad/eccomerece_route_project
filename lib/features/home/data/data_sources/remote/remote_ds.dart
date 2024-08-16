import 'package:dartz/dartz.dart';


import '../../../../../core/error/failures.dart';
import '../../models/CartModel.dart';
import '../../models/CategoryBrandsModel.dart';
import '../../models/ChangePasswordMessageModel.dart';
import '../../models/WishListModel.dart';

abstract class HomeTabRemoteDS {
  Future<Either<Failures, CategoryModel>> getCategories();
  Future<Either<Failures, CategoryModel>> getBrands();
  Future<Either<Failures, CartModel>> addToCart(String productId, String token);

  Future<Either<Failures, WishListModel>> getWishList(String token);
  Future<Either<Failures, ChangePasswordMessageModel>> changePassword(
      String currentPassword,
      String password,
      String rePassword,
      String? token);

  Future<Either<Failures, CartModel>> updateProductQuantityToCart(String productId, int count, String s);
}
