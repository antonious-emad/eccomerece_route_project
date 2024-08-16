import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../signup/data/models/UserModel.dart';

abstract class LogInRepo {
  Future<Either<Failures, UserModel>> logIn(String email, String password);
}
