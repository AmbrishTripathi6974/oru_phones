import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../common/image_string.dart';
import '../../../../common/option_widget.dart';

class OptionsGrid extends StatelessWidget {
  const OptionsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: BlocProvider(
        create: (context) => ImageCubit()..loadImages(),
        child: BlocBuilder<ImageCubit, List<Map<String, String>>>(
          builder: (context, categories) {
            return SizedBox(
              height: 120, // Increased to fit larger icons
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return OptionWidget(
                    imagePath: categories[index]["image"]!,
                    label: categories[index]["text"]!,
                    onTap: () {}, // Empty action for now
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
