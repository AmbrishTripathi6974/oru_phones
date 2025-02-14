import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../common/text_strings.dart';
import '../../bloc/login_bloc.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController phoneController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // **Logo & Title**
                    Center(
                      child: Column(
                        children: [
                          Image.asset('assets/logo.png', height: 62),
                          const SizedBox(height: 60),
                          Text(
                            AppStrings.welcome,
                            style: GoogleFonts.poppins(
                              fontSize: 28,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF5E3BEE), // Purple color
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            AppStrings.signInToContinue,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 100),

                    // **Phone Number Input**
                    Text(
                      AppStrings.enterPhoneNumber,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Text(
                            "+91",
                            style: GoogleFonts.poppins(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        prefixIconConstraints:
                            const BoxConstraints(minWidth: 50),
                        hintText: AppStrings.mobileNumberHint,
                        hintStyle: GoogleFonts.poppins(),
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),

                    // **Checkbox & Terms Link**
                    BlocBuilder<LoginBloc, LoginState>(
                      builder: (context, state) {
                        bool isChecked =
                            state is CheckboxToggled ? state.isChecked : false;
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Transform.scale(
                              scale: 1.2, // Slightly larger checkbox
                              child: Checkbox(
                                value: isChecked,
                                onChanged: (value) {
                                  context
                                      .read<LoginBloc>()
                                      .add(ToggleCheckboxEvent(value!));
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  // Open Terms & Conditions
                                },
                                child: Text(
                                  AppStrings.acceptTerms,
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color:
                                        const Color(0xFF5E3BEE), // Link color
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),

                    // **Next Button**
                    BlocConsumer<LoginBloc, LoginState>(
                      listener: (context, state) {
                        if (state is LoginSuccess) {
                          Navigator.pushNamed(context, '/otp',
                              arguments: state.phoneNumber);
                        } else if (state is LoginFailure) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                              state.errorMessage, // Now correctly fetching the error message
                              style: GoogleFonts.poppins(color: Colors.red),
                            ),
                          ));
                        }
                      },
                      builder: (context, state) {
                        return SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: (state is LoginLoading)
                                ? null
                                : () {
                                    final phoneNumber =
                                        phoneController.text.trim();
                                    if (phoneNumber.length == 10) {
                                      context
                                          .read<LoginBloc>()
                                          .add(SendOTPEvent(phoneNumber));
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            "Enter a valid 10-digit phone number",
                                            style: GoogleFonts.poppins(
                                                color: Colors.red),
                                          ),
                                        ),
                                      );
                                    }
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color(0xFF5E3BEE), // Purple button
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: state is LoginLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white)
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        AppStrings.next,
                                        style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      const Icon(
                                        Icons.arrow_forward,
                                        size: 20,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            // **Close Button (Top Right)**
            Positioned(
              top: 40,
              right: 20,
              child: IconButton(
                icon: const Icon(Icons.close, size: 28),
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/home', (route) => false);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
