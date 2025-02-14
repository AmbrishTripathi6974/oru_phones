import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../bloc/confirm_name_bloc.dart';

class ConfirmNamePage extends StatelessWidget {
  ConfirmNamePage({super.key});

  final TextEditingController nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider(
        create: (context) => ConfirmNameBloc(),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 60),

                  // Close (Cross) Button
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: const Icon(Icons.close, size: 28, color: Colors.black),
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/home', // Navigate to home
                          (route) => false, // Remove all previous routes
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 80),

                  // Logo & Welcome Text
                  Center(
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/logo.png',
                          height: 60,
                        ),
                        const SizedBox(height: 40),
                        Text(
                          "Welcome",
                          style: GoogleFonts.poppins(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
                          ),
                        ),
                        Text(
                          "Sign Up to continue",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 80),

                  // Name Input Field
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Please Tell Us Your Name *",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: nameController,
                          decoration: InputDecoration(
                            hintText: "Name",
                            hintStyle: GoogleFonts.poppins(),
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Name is required";
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 80),

                  // Confirm Name Button
                  BlocConsumer<ConfirmNameBloc, ConfirmNameState>(
                    listener: (context, state) {
                      if (state is ConfirmNameSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Name Confirmed: ${state.name}"),
                          ),
                        );

                        // **Navigate to Home & Remove All Previous Screens**
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/home', // Home Screen
                          (route) => false, // Removes all previous routes
                        );
                      } else if (state is ConfirmNameFailure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              state.error,
                              style: GoogleFonts.poppins(color: Colors.red),
                            ),
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 40.0),
                        child: SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: (state is ConfirmNameLoading)
                                ? null
                                : () {
                                    if (_formKey.currentState!.validate()) {
                                      final name = nameController.text.trim();
                                      context.read<ConfirmNameBloc>().add(SubmitNameEvent(name));
                                    }
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: state is ConfirmNameLoading
                                ? const CircularProgressIndicator(color: Colors.white)
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Confirm Name",
                                        style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      const Icon(Icons.arrow_forward, size: 20, color: Colors.white),
                                    ],
                                  ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
