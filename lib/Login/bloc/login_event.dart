import 'package:emp_app/bloc/login/events.dart';
import "package:equatable/equatable.dart";

abstract class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SignIn extends LoginEvent {
  final String email;
  final String password;

  SignIn({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}
