import 'package:bloc_bases/bloc/login_bloc.dart';
import 'package:bloc_bases/bloc/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatefulWidget {
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _loginBloc = BlocProvider.of<LoginBloc>(context);

    void _onLoginButtonPressed() {
      _loginBloc.onSignInEvent(
        _usernameController.text,
        _passwordController.text,
      );
    }

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginErrorState) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('${state.error}'),
              backgroundColor: Colors.red,
            ),
          );
        } else if (state is SignInSuccessState) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('Hi gg'),
              backgroundColor: Colors.amber,
            ),
          );
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        bloc: _loginBloc,
        builder: (
          BuildContext context,
          LoginState state,
        ) {
          return Form(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'username'),
                  controller: _usernameController,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'password'),
                  controller: _passwordController,
                  obscureText: true,
                ),
                RaisedButton(
                  onPressed: (){_onLoginButtonPressed();},
                  child: Text('Login'),
                )
                // RaisedButton(
                //   onPressed:
                //       state is! LoginLoading ? _onLoginButtonPressed : null,
                //   child: Text('Login'),
                // ),
                // Container(
                //   child: state is LoginLoading
                //       ? CircularProgressIndicator()
                //       : null,
                // ),
              ],
            ),
          );
        },
      ),
    );
  }
}
