import 'package:bloc_bases/bloc/login_bloc.dart';
import 'package:bloc_bases/widget/InputButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgetPasswordPage extends StatefulWidget {
  @override
  _ForgetPasswordPageState createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restore pasword'),
      ),
      body: BlocProvider(
          builder: (context) => LoginBloc(), child: _ForgetPasswordWidgete()),
    );
  }
}

_validateEmail(String email) {
  if (email == null || email.isEmpty) {
    return "Email can't be empty";
  } else {
    return null;
  }
}

class _ForgetPasswordWidgete extends StatelessWidget {
  final _usernameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24.0, right: 80),
      child: Center(
        child: Form(
          key: _formKey,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Email', hintText: "Enter email"),
                  validator: (input) => _validateEmail(input),
                  controller: _usernameController,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: InputButton(
                    onPressed: () => {},
                  ),
                ),
              ]),
        ),
      ),
    );
  }

  _onResetPasswordPressed(BuildContext context) {
    Navigator.pop(context);
  }
}
