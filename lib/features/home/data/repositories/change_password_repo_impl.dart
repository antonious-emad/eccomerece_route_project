import 'package:dartz/dartz.dart';



import 'package:injectable/injectable.dart';

import '../../../../core/cache/shared_prefrence.dart';
import '../../../../core/error/failures.dart';
import '../../domain/repositories/change_password_repo.dart';
import '../data_sources/remote/remote_ds.dart';
import '../models/ChangePasswordMessageModel.dart';

@Injectable(as: ChangePasswordRepo)
class ChangePasswordRepoImpl implements ChangePasswordRepo {
  HomeTabRemoteDS remoteDS;
  ChangePasswordRepoImpl(this.remoteDS);

  @override
  Future<Either<Failures, ChangePasswordMessageModel>> changePassword(
      String currentPassword, String password, String rePassword) async {
    String? token = await getToken();
    return remoteDS.changePassword(
        currentPassword, password, rePassword, token);
  }

  Future<String?> getToken() async {
    return CacheData.getData("token");
  }
}
