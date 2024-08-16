
import 'package:injectable/injectable.dart';

import '../../../../../core/cache/shared_prefrence.dart';
import 'local_ds.dart';

@Injectable(as: LogInLocalDS)
class LogInLocalDSImpl implements LogInLocalDS {
  @override
  Future<bool> cacheToken(String token) {
    try {
      return CacheData.saveData("token", token);
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<bool> cacheUserName(String userName) {
    try {
      return CacheData.saveData("userName", userName);
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<bool> cacheUserEmail(String userEmail) {
    try {
      return CacheData.saveData("userEmail", userEmail);
    } catch (e) {
      throw Exception();
    }
  }
}
