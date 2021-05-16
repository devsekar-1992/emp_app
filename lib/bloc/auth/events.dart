import 'package:emp_app/Login/models/user_model.dart';
import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

//Fired just after app is launched
class AppLoaded extends AuthEvent {}

// Fired when a user has successfully logged in
class UserLoggedIn extends AuthEvent {
  final UserModel userModel;

  UserLoggedIn({required this.userModel});

  @override
  List<Object> get props => [userModel];
}

class UserLoggedOut extends AuthEvent {}
