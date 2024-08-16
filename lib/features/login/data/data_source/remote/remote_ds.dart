import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../../../signup/data/models/UserModel.dart';

abstract class LogInRemoteDataSource {
  Future<Either<Failures, UserModel>> login(String email, String password);
}
