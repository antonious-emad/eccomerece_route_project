import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/ChangePasswordMessageModel.dart';

abstract class ChangePasswordRepo {
  Future<Either<Failures, ChangePasswordMessageModel>> changePassword(
      String currentPassword, String password, String rePassword);
}
