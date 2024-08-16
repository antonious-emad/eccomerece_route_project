import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/CartModel.dart';
import '../../data/models/WishListModel.dart';
import '../entities/CategoryEntity.dart';


abstract class HomeTabRepo {
  Future<Either<Failures, CategoryEntity>> getCategories();
  Future<Either<Failures, CategoryEntity>> getBrands();
  Future<Either<Failures, CartModel>> addToCart(String productId);
    Future<Either<Failures, CartModel>> updateProductQuantityToCart(String productId,int count);

  Future<Either<Failures, WishListModel>> getWishList();
}
