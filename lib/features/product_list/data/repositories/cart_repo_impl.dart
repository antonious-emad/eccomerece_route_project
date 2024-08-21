import 'package:dartz/dartz.dart';

import 'package:injectable/injectable.dart';

import '../../../../core/cache/shared_prefrence.dart';
import '../../../../core/error/failures.dart';
import '../../../home/data/models/CartModel.dart';
import '../../domain/repositories/cart_repo.dart';
import '../data_sources/remote_ds/product_list_ds.dart';

@Injectable(as: CartRepo)
class CartRepoImpl implements CartRepo {
  ProductRemoteDS remoteDS;

  CartRepoImpl(this.remoteDS);

  @override
  Future<Either<Failures, CartModel>> getCarts() async {
    String? token = await getToken();
    return remoteDS.getCarts(token ?? "");
  }

  Future<String?> getToken() async {
    return CacheData.getData("token");
  }
  @override
  Future<Either<Failures, CartModel>> updateCart(String productId,int count) async {
    String? token = await getToken();
    return remoteDS.updateCart(productId,count ,token ?? "");
  }
}
