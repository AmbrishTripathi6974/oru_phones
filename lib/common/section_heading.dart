import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SectionHeadingWidget extends StatelessWidget {
  final String text;
  final String? location;

  const SectionHeadingWidget({super.key, required this.text, this.location});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24), // Spacing around heading
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF525252),
            ),
          ),
          if (location != null) ...[
            const SizedBox(width: 8), // Space between text and location
            Text(
              location!,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF3F3E8F),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
