import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtpTimerCubit extends Cubit<int> {
  Timer? _timer;

  OtpTimerCubit() : super(30) {
    startTimer();
  }

  void startTimer() {
    emit(30);
    _timer?.cancel(); // Cancel any previous timer before starting a new one

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state > 0) {
        emit(state - 1);
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel(); // Stop the timer when the cubit is disposed
    return super.close();
  }
}
