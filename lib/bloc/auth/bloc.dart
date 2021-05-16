import 'dart:developer';

import 'package:bloc/bloc.dart';

import 'events.dart';
import 'states.dart';

import '../../services/auth/auth.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRequest _authRequest;

  AuthBloc(AuthRequest authRequest)
      : _authRequest = authRequest,
        super(AuthInitial());
  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AppLoaded) {
      yield* _mapAppLoadedToState(event);
    }
    if (event is UserLoggedIn) {
      yield* _mapUserLoggedInToState(event);
    }
    if (event is UserLoggedOut) {
      yield* _mapUserLoggedOutToState(event);
    }
  }

  Stream<AuthState> _mapAppLoadedToState(AppLoaded event) async* {
    yield AuthLoading();
    try {
      var currentUser = await _authRequest.isAuthenticated();
      print(currentUser);
      if (currentUser != 'no') {
        yield AuthAuthenticated();
      } else {
        yield AuthNotAuthenticated();
      }
    } catch (e) {
      log(e.toString());
      yield AuthFailure(message: 'An Unknown Error');
    }
  }

  Stream<AuthState> _mapUserLoggedInToState(UserLoggedIn event) async* {
    yield AuthAuthenticated();
  }

  Stream<AuthState> _mapUserLoggedOutToState(UserLoggedOut event) async* {
    await _authRequest.logout();
    yield AuthNotAuthenticated();
  }
}
