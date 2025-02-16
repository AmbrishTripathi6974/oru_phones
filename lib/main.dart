import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/app_route.dart';
import 'features/auth/bloc/auth_bloc.dart';
import 'features/home/product/bloc/favourite_bloc.dart';
import 'features/side_menu_bar/bloc/sidebar_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()), // ✅ Provide AuthBloc
        BlocProvider(
          create: (context) => SidebarBloc(context.read<AuthBloc>()), // ✅ Proper Bloc reference
        ),
        BlocProvider(create: (context) => FavoritesBloc()), // ✅ Provide FavoritesBloc
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
  }
}
