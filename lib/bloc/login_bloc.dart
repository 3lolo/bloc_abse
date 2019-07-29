import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  @override
  LoginState get initialState => InitialLoginState();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is SignInEvent) {
      yield _actionSigIn(event);
    }
  }

  LoginState _actionSigIn(SignInEvent event) {
    if (event.login == "gg" && event.password == "gg") {
      return new SignInSuccessState();
    } else {
      return new LoginErrorState("No such user ");
    }
  }

  void onSignInEvent(String username, String password) {
    dispatch(SignInEvent(
      username,
      password,
    ));
  }
}
