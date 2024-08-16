import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/ProductModel.dart';
import '../repositories/product_list_repo.dart';

@injectable
class ProductListUseCase {
  ProductListRepo productListRepo;

  ProductListUseCase(this.productListRepo);
  Future<Either<Failures, ProductModel>> call() =>
      productListRepo.getProductList();
}
