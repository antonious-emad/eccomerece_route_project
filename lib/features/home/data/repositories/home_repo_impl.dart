import 'package:dartz/dartz.dart';

import 'package:injectable/injectable.dart';

import '../../../../core/cache/shared_prefrence.dart';
import '../../../../core/error/failures.dart';
import '../../domain/repositories/home_repositories.dart';
import '../data_sources/remote/remote_ds.dart';
import '../models/CartModel.dart';
import '../models/CategoryBrandsModel.dart';
import '../models/WishListModel.dart';

@Injectable(as: HomeTabRepo)
class HomeTabRepoImpl implements HomeTabRepo {
  HomeTabRemoteDS homeTabRemoteDS;
  HomeTabRepoImpl(this.homeTabRemoteDS);

  @override
  Future<Either<Failures, CategoryModel>> getCategories() =>
      homeTabRemoteDS.getCategories();

  @override
  Future<Either<Failures, CategoryModel>> getBrands() =>
      homeTabRemoteDS.getBrands();

  @override
  Future<Either<Failures, CartModel>> addToCart(String productId) async {
    String? token = await getToken();
    return homeTabRemoteDS.addToCart(productId, token ?? "");
  }



  @override
  Future<Either<Failures, WishListModel>> getWishList() async {
    String? token = await getToken();
    return homeTabRemoteDS.getWishList(token ?? "");
  }

  Future<String?> getToken() async {
    return CacheData.getData("token");
  }

  @override
  Future<Either<Failures, CartModel>> updateProductQuantityToCart(String productId,int count) async {
    String? token = await getToken();
    return homeTabRemoteDS.updateProductQuantityToCart(productId,count ,token ?? "");
  }
}
