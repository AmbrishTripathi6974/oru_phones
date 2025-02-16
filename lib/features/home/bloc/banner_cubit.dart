import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

class BannerCubit extends Cubit<int> {
  final int totalImages;
  Timer? _timer;

  BannerCubit(this.totalImages) : super(0) {
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      int nextIndex = (state + 1) % totalImages;
      emit(nextIndex);
    });
  }

  void manualScroll(int index) {
    emit(index);
    _restartAutoScroll();
  }

  void _restartAutoScroll() {
    _timer?.cancel();
    _timer = Timer(const Duration(seconds: 5), () {
      _startAutoScroll();
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
