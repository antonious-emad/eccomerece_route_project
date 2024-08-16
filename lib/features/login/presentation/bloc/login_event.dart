part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LogInButtonEvent extends LoginEvent {
  LogInButtonEvent();
}
