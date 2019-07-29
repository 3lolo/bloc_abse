import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class LoginEvent extends Equatable {
  LoginEvent([List props = const []]) : super(props);
}

class SignInEvent extends LoginEvent {
  final String login;
  final String password;

  SignInEvent(this.login, this.password);
}
