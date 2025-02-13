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
  bool isChecked = false;

  LoginBloc() : super(LoginInitial()) {
    on<SendOTPEvent>((event, emit) async {
      emit(LoginLoading());

      await Future.delayed(const Duration(seconds: 2)); // Simulating API Call

      if (event.phoneNumber.length == 10) {
        emit(LoginSuccess(event.phoneNumber));
      } else {
        emit(LoginFailure("Invalid phone number"));
      }
    });

    on<ToggleCheckboxEvent>((event, emit) {
      isChecked = event.isChecked;
      emit(CheckboxToggled(isChecked));
    });
  }
}
