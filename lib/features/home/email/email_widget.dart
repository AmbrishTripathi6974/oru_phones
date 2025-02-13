import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../bloc/email_cubit.dart';

class EmailSubscriptionWidget extends StatelessWidget {
  const EmailSubscriptionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EmailCubit(),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
        decoration: const BoxDecoration(
          color: Color(0xFFF4B700), // Yellow background
          // borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 🔹 Heading (Unchanged)
            Text(
              "Get Notified About Our \nLatest Offers and Price Drops",
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // 🔹 Email Input Field (Modified)
            BlocBuilder<EmailCubit, String>(
              builder: (context, email) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50), // Fully rounded container
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        // Email Input Field
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Enter your email here",
                              hintStyle: GoogleFonts.poppins(
                                fontSize: 14,
                                color: const Color(0xFFA8A8A8),
                              ),
                              border: InputBorder.none, // No border
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 16),
                            ),
                            style: GoogleFonts.poppins(fontSize: 14),
                            onChanged: (value) =>
                                context.read<EmailCubit>().updateEmail(value),
                          ),
                        ),
                  
                        // Send Button (Inside Input Box)
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF363636),
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 30),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(43), // Rounded button
                            ),
                          ),
                          onPressed: () {
                            context.read<EmailCubit>().sendEmail();
                          },
                          child: Text(
                            "Send",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
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
    );
  }
}
