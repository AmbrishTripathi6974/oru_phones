import 'package:flutter/material.dart';

class AdCard extends StatelessWidget {
  final String imagePath;

  const AdCard({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200, // ✅ Set a fixed height for ads
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
