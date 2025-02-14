import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Dio _dio = Dio();

  AuthBloc() : super(AuthInitial()) {
    // 🔹 Send OTP Event
    on<SendOtpEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        log("🔹 Sending OTP: countryCode=${event.countryCode}, phone=${event.phoneNumber}");

        final response = await _dio.post(
          'http://40.90.224.241:5000/login/otpCreate',
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
      } on DioException catch (e) {
        log("❌ OTP Error: ${e.message}");
        emit(AuthFailure("Failed to send OTP. Please try again."));
      } catch (e) {
        log("❌ Unexpected OTP Error: $e");
        emit(AuthFailure("Something went wrong while sending OTP"));
      }
    });

    // 🔹 Verify OTP Event
    on<VerifyOtpEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        log("🔹 Verifying OTP: countryCode=${event.countryCode}, phone=${event.phoneNumber}, otp=${event.otp}");

        final response = await _dio.post(
          'http://40.90.224.241:5000/login/otpValidate',
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

          // Emit the correct state
          if (isNewUser) {
            emit(OtpVerifiedState(isNewUser: isNewUser));
          } else {
            emit(AuthenticatedState(
                userName: userName, joiningDate: joiningDate));
          }
        } else {
          emit(AuthFailure(response.data['reason'] ?? "Invalid OTP"));
        }
      } on DioException catch (e) {
        log("❌ OTP Verification Error: ${e.message}");
        emit(AuthFailure("Failed to verify OTP. Please try again."));
      } catch (e) {
        log("❌ Unexpected OTP Verification Error: $e");
        emit(AuthFailure("Something went wrong while verifying OTP"));
      }
    });

    // 🔹 Confirm Name Event
    on<ConfirmNameEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        log("🔹 Confirming Name: ${event.name}");

        final response = await _dio.post(
          'http://40.90.224.241:5000/update',
          data: {"name": event.name},
        );

        log("✅ Confirm Name Response: ${response.data}");

        if (response.data['status'] == "SUCCESS") {
          // Fetch the user details to get the joining date
          final userResponse =
              await _dio.get('http://40.90.224.241:5000/isLoggedIn');

          if (userResponse.data['isLoggedIn'] == true) {
            final user = userResponse.data['user'];
            String joiningDate = user?['createdDate'] ?? "";

            emit(AuthenticatedState(
                userName: event.name, joiningDate: joiningDate));
          } else {
            emit(AuthFailure("Failed to retrieve user details."));
          }
        } else {
          emit(
              AuthFailure(response.data['reason'] ?? "Failed to confirm name"));
        }
      } on DioException catch (e) {
        log("❌ Confirm Name Error: ${e.message}");
        emit(AuthFailure("Failed to update name. Please try again."));
      } catch (e) {
        log("❌ Unexpected Confirm Name Error: $e");
        emit(AuthFailure("Something went wrong while confirming name"));
      }
    });

    // 🔹 Logout Event
    on<LogoutEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        log("🔹 Logging out user");

        final response = await _dio.post('http://40.90.224.241:5000/logout');

        log("✅ Logout Response: ${response.data}");

        if (response.data['status'] == "SUCCESS") {
          emit(UnauthenticatedState());
        } else {
          emit(AuthFailure("Failed to logout. Please try again."));
        }
      } on DioException catch (e) {
        log("❌ Logout Error: ${e.message}");
        emit(AuthFailure("Logout failed. Please try again."));
      } catch (e) {
        log("❌ Unexpected Logout Error: $e");
        emit(AuthFailure("Something went wrong while logging out"));
      }
    });
  }
}
