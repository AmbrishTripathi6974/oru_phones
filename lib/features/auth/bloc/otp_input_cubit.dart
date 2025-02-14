import 'package:flutter_bloc/flutter_bloc.dart';

class OtpInputCubit extends Cubit<List<String>> {
  OtpInputCubit() : super(List.filled(4, ""));

  void updateOtp(int index, String value) {
    final otpValues = List<String>.from(state);
    otpValues[index] = value;
    emit(otpValues);
  }
}
