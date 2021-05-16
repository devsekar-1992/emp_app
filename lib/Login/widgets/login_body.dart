import 'package:emp_app/Login/data/repository/login_repository.dart';
import 'package:emp_app/bloc/auth/bloc.dart';
import 'package:emp_app/Login/bloc/login_bloc.dart';
import 'package:emp_app/Login/widgets/login_form.dart';
import 'package:emp_app/services/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginRespository = LoginRespository(authRequest: AuthRequest());
    final authBloc = BlocProvider.of<AuthBloc>(context);
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: BlocProvider<LoginBloc>(
        create: (context) =>
            LoginBloc(loginRespository: loginRespository, authBloc: authBloc),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                'Welcome.',
                style: TextStyle(color: Colors.white, fontSize: 60),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                'Lets be valorous',
                style: TextStyle(color: Colors.white, fontSize: 60),
              ),
            ),
            Container(child: LoginForm())
          ],
        ),
      ),
    );
  }
}
