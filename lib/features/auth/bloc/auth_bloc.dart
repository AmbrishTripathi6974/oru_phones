import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../services/dio_service.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final DioService _dioService = DioService();

  AuthBloc() : super(AuthInitial()) {
    // 🔹 Check Authentication on App Start
    on<CheckAuthEvent>((event, emit) async {
      emit(AuthLoading());
      bool isLoggedIn = await _dioService.checkUserSession();

      if (isLoggedIn) {
        final userData = await _dioService.loadUserData();
        emit(AuthenticatedState(
          userName: userData['userName']!,
          joiningDate: userData['createdDate']!,
        ));
      } else {
        emit(UnauthenticatedState());
      }
    });

    // 🔹 Send OTP Event
    on<SendOtpEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        log("🔹 Sending OTP: countryCode=${event.countryCode}, phone=${event.phoneNumber}");

        final response = await _dioService.dio.post(
          '/login/otpCreate',
          data: {
            "countryCode": event.countryCode,
            "mobileNumber": int.parse(event.phoneNumber),
          },
        );

        log("✅ OTP Response: ${response.data}");

        if (response.data['status'] == "SUCCESS") {
          emit(OtpSentState());
        } else {
          emit(AuthFailure(response.data['reason'] ?? "Failed to send OTP"));
        }
      } catch (e) {
        log("❌ OTP Error: $e");
        emit(AuthFailure("Failed to send OTP. Please try again."));
      }
    });

    // 🔹 Verify OTP Event
    on<VerifyOtpEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        log("🔹 Verifying OTP: countryCode=${event.countryCode}, phone=${event.phoneNumber}, otp=${event.otp}");

        final response = await _dioService.dio.post(
          '/login/otpValidate',
          data: {
            "countryCode": event.countryCode,
            "mobileNumber": int.parse(event.phoneNumber),
            "otp": int.parse(event.otp),
          },
        );

        log("✅ OTP Verification Response: ${response.data}");

        if (response.data['status'] == "SUCCESS") {
          final user = response.data['user'];
          String userName = user?['userName'] ?? "";
          String joiningDate = user?['createdDate'] ?? "";

          bool isNewUser = userName.trim().isEmpty;
          log("✅ User Verified. isNewUser: $isNewUser, joiningDate: $joiningDate");

          // 🔹 Save user data in cookies
          await _dioService.saveUserData(user);

          if (isNewUser) {
            emit(OtpVerifiedState(isNewUser: isNewUser));
          } else {
            emit(AuthenticatedState(userName: userName, joiningDate: joiningDate));
          }
        } else {
          emit(AuthFailure(response.data['reason'] ?? "Invalid OTP"));
        }
      } catch (e) {
        log("❌ OTP Verification Error: $e");
        emit(AuthFailure("Failed to verify OTP. Please try again."));
      }
    });

    // 🔹 Confirm Name Event
    on<ConfirmNameEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        log("🔹 Confirming Name: ${event.name}");

        final response = await _dioService.dio.post(
          '/update',
          data: {"name": event.name},
        );

        log("✅ Confirm Name Response: ${response.data}");

        if (response.data['status'] == "SUCCESS") {
          final userResponse = await _dioService.dio.get('/isLoggedIn');

          if (userResponse.data['isLoggedIn'] == true) {
            final user = userResponse.data['user'];
            String joiningDate = user?['createdDate'] ?? "";

            // 🔹 Save updated user data
            await _dioService.saveUserData(user);

            emit(AuthenticatedState(userName: event.name, joiningDate: joiningDate));
          } else {
            emit(AuthFailure("Failed to retrieve user details."));
          }
        } else {
          emit(AuthFailure(response.data['reason'] ?? "Failed to confirm name"));
        }
      } catch (e) {
        log("❌ Confirm Name Error: $e");
        emit(AuthFailure("Failed to update name. Please try again."));
      }
    });

    // 🔹 Logout Event
    on<LogoutEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        log("🔹 Logging out user");

        final response = await _dioService.dio.post('/logout');

        log("✅ Logout Response: ${response.data}");

        if (response.data['status'] == "SUCCESS") {
          await _dioService.clearSessionData(); // Clears only session cookies
          emit(UnauthenticatedState());
        } else {
          emit(AuthFailure("Failed to logout. Please try again."));
        }
      } catch (e) {
        log("❌ Logout Error: $e");
        emit(AuthFailure("Logout failed. Please try again."));
      }
    });
  }
}
