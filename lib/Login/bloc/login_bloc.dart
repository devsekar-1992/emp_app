import 'dart:convert';

import 'package:emp_app/Login/data/repository/login_repository.dart';
import 'package:emp_app/Login/bloc/login_event.dart';
import 'package:emp_app/bloc/auth/bloc.dart';
import 'package:emp_app/bloc/auth/events.dart';
import 'package:emp_app/bloc/login/states.dart';
import 'package:emp_app/exceptions/auth_exceptions.dart';
import 'package:emp_app/helpers/db/db_helpers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_event.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRespository loginRespository;
  final AuthBloc authBloc;

  LoginBloc({required this.loginRespository, required this.authBloc})
      : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    yield LoginInitial();
    try {
      if (event is SignIn) {
        yield* _mapLoginToState(event);
      }
    } catch (_) {}
  }

  Stream<LoginState> _mapLoginToState(SignIn event) async* {
    final response;
    yield LoginLoading();
    try {
      response = await loginRespository
          .signUp({'userName': event.email, 'password': event.password});
      print(response);
      if (response != null) {
        authBloc.add(UserLoggedIn(userModel: response));
        HiveDB().putIntoBox('user_model', 'um', jsonEncode(response));
        HiveDB().putIntoBox('user_info', 'token', response['token']);
        yield LoginSuccess();
        yield LoginInitial();
      } else {
        yield LoginFailure(error: 'Sorry something went wrong');
      }
    } on AuthenticationException catch (e) {
      yield LoginFailure(error: e.message);
    }
  }
}
