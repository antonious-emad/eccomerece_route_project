import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../product_list/presentation/bloc/product_list_bloc.dart';
import '../../../signup/domain/entities/UserEntity.dart';
import '../../domain/use_case/login_use_case.dart';
part 'login_event.dart';
part 'login_state.dart';

@injectable
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  static LoginBloc get(context) => BlocProvider.of(context);
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  LogInUseCase logInUseCase;
  LoginBloc(this.logInUseCase) : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      if (event is LogInButtonEvent) {
        emit(state.copyWith(screenStatus: ScreenStatus.loading));

        var result = await logInUseCase.call(
            emailController.text, passwordController.text);
        result.fold((l) {
          emit(state.copyWith(screenStatus: ScreenStatus.failures, failures: l));
        }, (r) {
          emit(state.copyWith(
              screenStatus: ScreenStatus.successfully, userEntity: r));
        });
      }
    });
  }
}
