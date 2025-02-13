import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oru_phones/features/auth/bloc/confirm_name_bloc.dart';
import 'package:oru_phones/features/auth/presentation/screens/confirm_name_screen.dart';
import 'package:oru_phones/features/splash/presentation/splash_screen.dart';

import '../features/auth/bloc/login_bloc.dart';
import '../features/auth/presentation/screens/login_screen.dart';
import '../features/home/presentation/screens/home_screen.dart';
class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/login':
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => LoginBloc(),
            child: LoginPage(),
          ),
        );
      case '/confirmName':
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => ConfirmNameBloc(),
            child: ConfirmNamePage(),
          ),
        );
      case '/home':
        return MaterialPageRoute(
          builder: (context) => const HomePage(),
        );
      case '/':
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        appBar: AppBar(title: const Text("Error")),
        body: const Center(child: Text("Page not found")),
      ),
    );
  }
}
