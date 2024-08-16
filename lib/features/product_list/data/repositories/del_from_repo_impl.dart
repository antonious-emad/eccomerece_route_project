import 'package:injectable/injectable.dart';

import '../../../../core/cache/shared_prefrence.dart';
import '../../domain/repositories/del_from_repo.dart';
import '../data_sources/remote_ds/product_list_ds.dart';

@Injectable(as: DelFromRepo)
class DelFromRepoImpl implements DelFromRepo {
  ProductRemoteDS remoteDS;

  DelFromRepoImpl(this.remoteDS);

  @override
  Future<void> delFromWishList(String? productId) async {
    String? token = await getToken();
    remoteDS.delFromWishList(productId ?? "", token ?? "");
  }

  Future<String?> getToken() async {
    return CacheData.getData("token");
  }
}
