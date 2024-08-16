import 'package:dartz/dartz.dart';

import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/CartModel.dart';
import '../repositories/home_repositories.dart';

@injectable
class AddToCartUseCase {
  HomeTabRepo homeTabRepo;

  AddToCartUseCase(this.homeTabRepo);
  Future<Either<Failures, CartModel>> call(String productId) =>
      homeTabRepo.addToCart(productId);
}
