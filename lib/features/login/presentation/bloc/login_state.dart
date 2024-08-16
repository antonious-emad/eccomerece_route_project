part of 'login_bloc.dart';

class LoginState {
  final ScreenStatus? screenStatus;
  final UserEntity? userEntity;
  final Failures? failures;

  LoginState({this.screenStatus, this.userEntity, this.failures});
  LoginState copyWith(
      {ScreenStatus? screenStatus,
      UserEntity? userEntity,
      Failures? failures}) {
    return LoginState(
        screenStatus: screenStatus ?? this.screenStatus,
        userEntity: userEntity ?? this.userEntity,
        failures: failures ?? this.failures);
  }
}

class LoginInitial extends LoginState {
  LoginInitial() : super(screenStatus: ScreenStatus.init);
}
