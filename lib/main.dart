import 'package:emp_app/Login/data/repository/login_repository.dart';
import 'package:emp_app/Shared/Layout/views/layout_screen.dart';
import 'package:emp_app/bloc/auth/bloc.dart';
import 'package:emp_app/bloc/auth/events.dart';
import 'package:emp_app/bloc/auth/states.dart';
import 'package:emp_app/emp_bloc_observer.dart';
import 'package:emp_app/helpers/db/db_helpers.dart';
import 'package:emp_app/Login/login.dart';
import 'package:emp_app/services/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = EmpBlocObserver();
  await HiveDB().init();
  runApp(
    RepositoryProvider.value(
      value: LoginRespository,
      child: MultiBlocProvider(providers: [
        BlocProvider<AuthBloc>(create: (context) {
          final authService = AuthRequest();
          return AuthBloc(authService)..add(AppLoaded());
        })
      ], child: MyApp()),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Employee App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.robotoTextTheme(Theme.of(context).textTheme),
        primarySwatch: Colors.blue,
      ),
      home: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthAuthenticated) {
            return LayoutScreen();
          }
          return Login();
        },
      ),
    );
  }
}
