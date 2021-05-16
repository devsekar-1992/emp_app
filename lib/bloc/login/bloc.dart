import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:emp_app/bloc/auth/events.dart';
import 'package:emp_app/exceptions/auth_exceptions.dart';
import 'package:emp_app/helpers/db/db_helpers.dart';
import 'events.dart';
import 'states.dart';
import '../auth/bloc.dart';
import '../../services/auth/auth.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthBloc _authBloc;
  final AuthRequest _authRequest;

  LoginBloc(AuthBloc authBloc, AuthRequest authRequest)
      : assert(authBloc != null),
        assert(authRequest != null),
        _authBloc = authBloc,
        _authRequest = authRequest,
        super(LoginInitial());
  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is Login) {
      yield* _mapLoginToState(event);
    }
  }

  Stream<LoginState> _mapLoginToState(Login event) async* {
    yield LoginLoading();
    try {
      final user = await _authRequest
          .login({'userName': event.email, 'password': event.password});
      log(user.toString());
      if (user != null) {
        _authBloc.add(UserLoggedIn(userModel: user));
        HiveDB().putIntoBox('user_model', 'um', jsonEncode(user));
        yield LoginSuccess();
        yield LoginInitial();
      } else {
        yield LoginFailure(error: 'Sorry something went wrong');
      }
    } on AuthenticationException catch (e) {
      log(e.toString());
      yield LoginFailure(error: e.message);
    }
  }
}
