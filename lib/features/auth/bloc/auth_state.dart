abstract class AuthState {}

// 🔹 Initial State
class AuthInitial extends AuthState {}

// 🔹 Loading State
class AuthLoading extends AuthState {}

// 🔹 OTP Sent State
class OtpSentState extends AuthState {}

// 🔹 OTP Verified State
class OtpVerifiedState extends AuthState {
  final bool isNewUser;
  OtpVerifiedState({required this.isNewUser});

  List<Object?> get props => [isNewUser];
}

// 🔹 Authenticated State (User is logged in)
class AuthenticatedState extends AuthState {
  final String userName;
  final String joiningDate;

  AuthenticatedState({required this.userName, required this.joiningDate});

  List<Object?> get props => [userName, joiningDate];
}

// 🔹 Unauthenticated State (User is logged out)
class UnauthenticatedState extends AuthState {}

// 🔹 Failure State
class AuthFailure extends AuthState {
  final String message;
  AuthFailure(this.message);
}
