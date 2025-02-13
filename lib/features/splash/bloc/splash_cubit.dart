import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';

class SplashCubit extends Cubit<double> {
  SplashCubit() : super(1.0); // Start with full opacity

  void startSplash() {
    Future.delayed(const Duration(seconds: 2), () {
      emit(0.0); // Start fading out

      Future.delayed(const Duration(milliseconds: 800), () {
        // Navigate using a callback (avoiding -1.0 opacity)
        emit(0.01); // Keep opacity valid, while triggering navigation
      });
    });
  }
}
