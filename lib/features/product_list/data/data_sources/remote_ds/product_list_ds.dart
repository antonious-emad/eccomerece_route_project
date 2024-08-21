import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../../../home/data/models/CartModel.dart';
import '../../models/ProductModel.dart';

abstract class ProductRemoteDS {
  Future<Either<Failures, ProductModel>> getProducts();
  Future<Either<Failures, CartModel>> getCarts(String token);
  void addToWishList(String token, String productId);
  void delFromWishList(String productId, String token);
  Future<Either<Failures, CartModel>> updateCart(String productId, int count, String s);
}
