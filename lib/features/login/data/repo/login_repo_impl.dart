import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../../../signup/data/models/UserModel.dart';
import '../../domain/domain_repo/login_repo.dart';
import '../data_source/local/local_ds.dart';
import '../data_source/remote/remote_ds.dart';

@Injectable(as: LogInRepo)
class LogInRepoImpl implements LogInRepo {
  LogInRemoteDataSource logInRemoteDataSource;
  LogInLocalDS localDS;

  LogInRepoImpl(this.logInRemoteDataSource, this.localDS);

  @override
  Future<Either<Failures, UserModel>> logIn(
      String email, String password) async {
    try {
      var result = await logInRemoteDataSource.login(email, password);
      if (result.isRight()) {
        result.fold((l) => null, (r) {
          cacheToken(r.token ?? "");
          cacheUserName(r.user?.name ?? "");
          cacheUserEmail(r.user?.email ?? "");
        });
      }
      return result;
    } catch (e) {
      throw (RemoteFailures("something went wrong"));
    }
  }

  void cacheToken(String token) async {
    await localDS.cacheToken(token);
  }

  void cacheUserName(String name) async {
    await localDS.cacheUserName(name);
  }

  void cacheUserEmail(String email) async {
    await localDS.cacheUserEmail(email);
  }
}
