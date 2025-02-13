import 'package:flutter/material.dart';

import 'appbar_widget.dart';
import 'categories_widget.dart';
import 'search_widget.dart';

class CustomHeader extends StatelessWidget {
  const CustomHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8), // Increased translucency
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ],
      ),
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomAppBar(),
          SizedBox(height: 8),
          CustomSearchBar(),
          SizedBox(height: 12),
          CategoriesList(),
          SizedBox(height: 20), // Increased spacing after categories
        ],
      ),
    );
  }
}
