import 'package:emp_app/Login/models/user_model.dart';
import 'package:emp_app/services/auth/auth.dart';

class LoginRespository {
  late final AuthRequest authRequest;

  LoginRespository({required this.authRequest});

  /// Sign in to application
  Future<UserModel> signUp(authData) async => await authRequest.login(authData);
}
