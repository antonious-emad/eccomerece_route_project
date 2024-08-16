import 'package:dartz/dartz.dart';

import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../entities/CategoryEntity.dart';
import '../repositories/home_repositories.dart';

@injectable
class GetBrandsUseCase {
  HomeTabRepo homeTabRepo;

  GetBrandsUseCase(this.homeTabRepo);

  Future<Either<Failures, CategoryEntity>> call() => homeTabRepo.getBrands();
}
