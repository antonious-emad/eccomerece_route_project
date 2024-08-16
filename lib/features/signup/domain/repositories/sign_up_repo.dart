import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../data/models/request_data.dart';
import '../entities/UserEntity.dart';

abstract class SignUpRepo {
  Future<Either<Failures, UserEntity>> signUp(RequestData requestData);
}
