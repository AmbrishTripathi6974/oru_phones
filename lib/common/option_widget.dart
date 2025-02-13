import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OptionWidget extends StatelessWidget {
  final String imagePath;
  final String label;
  final VoidCallback onTap;

  const OptionWidget({
    super.key,
    required this.imagePath,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Image.asset(
            imagePath,
            width: 84, // **Ensures uniform size**
            height: 84,
            fit: BoxFit.contain, // Keeps proportions intact
          ),
          const SizedBox(height: 4), // Keeps text closer to image
          SizedBox(
            width: 90, // Prevents text from overflowing
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                height: 1.35, // Equivalent to 16.2px line height
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
