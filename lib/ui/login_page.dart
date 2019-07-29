import 'package:bloc_bases/bloc/login_bloc.dart';
import 'package:bloc_bases/bloc/login_state.dart';
import 'package:bloc_bases/widget/InputButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'forget_password_page.dart';
import 'home_page.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: BlocProvider(builder: (context) => LoginBloc(), child: LoginView()),
    );
  }
}

class LoginView extends StatefulWidget {
  @override
  State<LoginView> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    final _loginBloc = BlocProvider.of<LoginBloc>(context);

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        // if (state is LoginErrorState) {
        //   Scaffold.of(context).showSnackBar(
        //     SnackBar(
        //       content: Text('${state.error}'),
        //       backgroundColor: Colors.red,
        //     ),
        //   );
        // } else if (state is SignInSuccessState) {
        _actionNavToHomeScreen(context);
        // }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        bloc: _loginBloc,
        builder: (
          BuildContext context,
          LoginState state,
        ) {
          return _LoginWidget(_loginBloc);
        },
      ),
    );
  }

  _actionNavToHomeScreen(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomePage()));
  }
}

class _LoginWidget extends StatelessWidget {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final LoginBloc loginBloc;

  _LoginWidget(this.loginBloc);

  void _onLoginButtonPressed() {
    if (_formKey.currentState.validate()) {
      loginBloc.onSignInEvent(
        _usernameController.text,
        _passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
              child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "Hello, there!",
                    style: TextStyle(fontSize: 34),
                  )),
              flex: 1),
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Text(
              "Signin to continue\nusing our app",
              style: TextStyle(fontSize: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 46.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Email', hintText: "Enter email"),
                    validator: (input) => _validateEmail(input),
                    controller: _usernameController,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Password', hintText: "Enter password"),
                    validator: (input) => _validatePassword(input),
                    controller: _passwordController,
                    obscureText: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: InputButton(
                        isWithArrow: true,
                        drawablePaddingLeft: 100.0,
                        onPressed: () => _onLoginButtonPressed()),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: GestureDetector(
                child: Text("Forgot password?"),
                onTap: () => _actionNavToForgetPasswordScreen(context)),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 56.0),
            child: GestureDetector(
                child: Text("Don't have an account?"), onTap: () => {}),
          ),
          Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: InkWell(
                  child: Text("Signup"),
                  onTap: () => {},
                ),
              ),
              flex: 1),
        ],
      ),
    );
  }

  _actionNavToForgetPasswordScreen(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ForgetPasswordPage()));
  }

  _validateEmail(String email) {
    if (email == null || email.isEmpty) {
      return "Email can't be empty";
    } else {
      return null;
    }
  }

  _validatePassword(String input) {
    if (input == null || input.isEmpty) {
      return "Password can't be empty";
    } else {
      return null;
    }
  }
}
