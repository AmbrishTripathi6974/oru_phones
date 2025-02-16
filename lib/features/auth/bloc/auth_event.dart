import 'package:equatable/equatable.dart';

// 🔹 Base Auth Event
abstract class AuthEvent extends Equatable {
  const AuthEvent();
  
  @override
  List<Object?> get props => [];
}

// 🔹 Send OTP Event
class SendOtpEvent extends AuthEvent {
  final String phoneNumber;
  final int countryCode;

  const SendOtpEvent(this.phoneNumber, {this.countryCode = 91});

  @override
  List<Object?> get props => [phoneNumber, countryCode];
}

// 🔹 Verify OTP Event
class VerifyOtpEvent extends AuthEvent {
  final String phoneNumber;
  final String otp;
  final int countryCode;

  const VerifyOtpEvent(this.phoneNumber, this.otp, {this.countryCode = 91});

  @override
  List<Object?> get props => [phoneNumber, otp, countryCode];
}

// 🔹 Confirm Name Event
class ConfirmNameEvent extends AuthEvent {
  final String name;

  const ConfirmNameEvent(this.name);

  @override
  List<Object?> get props => [name];
}

// 🔹 Logout Event
class LogoutEvent extends AuthEvent {
  const LogoutEvent();
}

// 🔹 Check Authentication Event (To check session)
class CheckAuthEvent extends AuthEvent {
  const CheckAuthEvent();
}
