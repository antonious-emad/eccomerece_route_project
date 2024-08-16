import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../signup/data/models/UserModel.dart';
import '../domain_repo/login_repo.dart';

@injectable
class LogInUseCase {
  LogInRepo logInRepo;

  LogInUseCase(this.logInRepo);

  Future<Either<Failures, UserModel>> call(String email, String password) =>
      logInRepo.logIn(email, password);
}
