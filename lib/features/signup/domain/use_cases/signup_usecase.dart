import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/request_data.dart';
import '../entities/UserEntity.dart';
import '../repositories/sign_up_repo.dart';

class SignUpUseCase {
  SignUpRepo signUpRepo;

  SignUpUseCase(this.signUpRepo);

  Future<Either<Failures, UserEntity>> call(RequestData requestData) =>
      signUpRepo.signUp(requestData);
}
