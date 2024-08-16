import 'package:dartz/dartz.dart';

import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/WishListModel.dart';
import '../repositories/home_repositories.dart';

@injectable
class GetWishListItemsUseCase {
  HomeTabRepo homeTabRepo;
  GetWishListItemsUseCase(this.homeTabRepo);

  Future<Either<Failures, WishListModel>> call() => homeTabRepo.getWishList();
}
