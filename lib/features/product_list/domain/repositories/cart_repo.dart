import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../home/data/models/CartModel.dart';

abstract class CartRepo {
  Future<Either<Failures, CartModel>> getCarts();
  Future<Either<Failures, CartModel>> updateCart(String productId,int count);
}
