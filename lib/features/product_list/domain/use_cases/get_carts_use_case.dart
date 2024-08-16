import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../../../home/data/models/CartModel.dart';
import '../repositories/cart_repo.dart';

@injectable
class GetCartsUseCase {
  CartRepo cartRepo;

  GetCartsUseCase(this.cartRepo);

  Future<Either<Failures, CartModel>> call() => cartRepo.getCarts();
}
