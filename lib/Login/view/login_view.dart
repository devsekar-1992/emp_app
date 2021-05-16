import 'dart:developer';

import 'package:emp_app/bloc/auth/bloc.dart';
import 'package:emp_app/bloc/auth/events.dart';
import 'package:emp_app/bloc/auth/states.dart';
import 'package:emp_app/Login/widgets/login_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: SafeArea(
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            log(state.toString());
            final authBloc = BlocProvider.of<AuthBloc>(context);
            if (state is AuthNotAuthenticated) {
              return LoginBody();
            }
            if (state is AuthFailure) {
              return Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(state.message),
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    child: Text('Retry'),
                    onPressed: () {
                      authBloc.add(AppLoaded());
                    },
                  )
                ],
              ));
            }
            return Center(
              child: CircularProgressIndicator(
                strokeWidth: 8,
              ),
            );
          },
        ),
      ),
    );
  }
}
