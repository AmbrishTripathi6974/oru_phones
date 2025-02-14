import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../bloc/auth_bloc.dart';
import '../../bloc/auth_event.dart';
import '../../bloc/auth_state.dart';
import '../../bloc/otp_cubit.dart';
import '../../bloc/otp_timer_cubit.dart';
import 'otp_input_fields.dart';

class OtpScreen extends StatelessWidget {
  final String phoneNumber;

  const OtpScreen({super.key, required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => OtpTimerCubit()..startTimer()),
        BlocProvider(create: (_) => OtpInputCubit()),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const SizedBox(height: 50),

              // Close Button (No Back Arrow)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close, size: 24),
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/login',
                        (route) => false,
                      );
                    },
                  ),
                ],
              ),

              const SizedBox(height: 80),

              // Logo
              Image.asset('assets/logo.png', height: 60),

              const SizedBox(height: 30),

              // Title
              Text(
                "Verify Mobile No.",
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 10),

              // Description
              Text(
                "Please enter the 4-digit verification code sent to your mobile number $phoneNumber via SMS",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
              ),

              const SizedBox(height: 80),

              // OTP Input Fields
              const OtpInputFields(),

              const SizedBox(height: 20),

              // Resend OTP Timer
              BlocBuilder<OtpTimerCubit, int>(
                builder: (context, secondsRemaining) {
                  return TextButton(
                    onPressed: secondsRemaining == 0
                        ? () {
                            context.read<AuthBloc>().add(SendOtpEvent(phoneNumber));
                            context.read<OtpTimerCubit>().startTimer();
                          }
                        : null,
                    child: Text(
                      secondsRemaining == 0
                          ? "Resend OTP"
                          : "Resend OTP in 0:${secondsRemaining.toString().padLeft(2, '0')} Sec",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: secondsRemaining == 0 ? Colors.blue : Colors.grey,
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 80),

              // Verify OTP Button
              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is OtpVerifiedState || state is AuthenticatedState) {
                    Future.microtask(() {
                      if (state is OtpVerifiedState && state.isNewUser) {
                        Navigator.pushReplacementNamed(context, '/confirmName');
                      } else {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/home',
                          (route) => false,
                        );
                      }
                    });
                  } else if (state is AuthFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          state.message,
                          style: const TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  return SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: state is AuthLoading
                          ? null
                          : () {
                              String otpCode = context.read<OtpInputCubit>().state.join();
                              if (otpCode.length == 4) {
                                context.read<AuthBloc>().add(
                                      VerifyOtpEvent(
                                        phoneNumber,
                                        otpCode,
                                        countryCode: 91,
                                      ),
                                    );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Please enter a 4-digit OTP"),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: state is AuthLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text(
                              "Verify OTP",
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
