import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// EVENTS
abstract class LoginEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SendOTPEvent extends LoginEvent {
  final String phoneNumber;

  SendOTPEvent(this.phoneNumber);

  @override
  List<Object?> get props => [phoneNumber];
}

class ToggleCheckboxEvent extends LoginEvent {
  final bool isChecked;

  ToggleCheckboxEvent(this.isChecked);

  @override
  List<Object?> get props => [isChecked];
}


// STATES
abstract class LoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final String phoneNumber;

  LoginSuccess(this.phoneNumber);

  @override
  List<Object?> get props => [phoneNumber];
}

class LoginFailure extends LoginState {
  final String error;

  LoginFailure(this.error);

  String get errorMessage => error; // ✅ Added getter

  @override
  List<Object?> get props => [error];
}
class CheckboxToggled extends LoginState {
  final bool isChecked;

  CheckboxToggled(this.isChecked);

  @override
  List<Object?> get props => [isChecked];
}

// BLOC CLASS
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final Dio dio = Dio();
  bool isChecked = false;

  LoginBloc() : super(LoginInitial()) {
    on<SendOTPEvent>(_sendOTP);
    on<ToggleCheckboxEvent>(_toggleCheckbox);
  }

  Future<void> _sendOTP(SendOTPEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoading());

    final String phoneNumber = event.phoneNumber.trim();
    if (phoneNumber.length != 10) {
      emit(LoginFailure("Enter a valid 10-digit phone number"));
      return;
    }

    final data = {
      "countryCode": 91,
      "mobileNumber": int.parse(phoneNumber),
    };

    try {
      final response = await dio.post(
        "http://40.90.224.241:5000/login/otpCreate",
        data: data,
      );

      if (response.statusCode == 200) {
        emit(LoginSuccess(phoneNumber));
      } else {
        emit(LoginFailure("Failed to send OTP. Try again."));
      }
    } catch (e) {
      emit(LoginFailure("Something went wrong. Check your connection."));
    }
  }

  void _toggleCheckbox(ToggleCheckboxEvent event, Emitter<LoginState> emit) {
    isChecked = event.isChecked;
    emit(CheckboxToggled(isChecked));
  }
}
