import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/banner_cubit.dart';

class CustomBannerWidget extends StatelessWidget {
  final List<String> imagePaths = [
    'assets/images/banners/banner 1.png',
    'assets/images/banners/banner 2.png',
    'assets/images/banners/banner 3.png',
    'assets/images/banners/banner 4.png',
    'assets/images/banners/banner 5.png',
  ];

  CustomBannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: BlocProvider(
        create: (context) => BannerCubit(imagePaths.length),
        child: BlocBuilder<BannerCubit, int>(
          builder: (context, currentIndex) {
            return Column(
              mainAxisSize: MainAxisSize.min, // Ensure minimal height
              children: [
                // Banner Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: SizedBox(
                    height: 180,
                    width: double.infinity,
                    child: Image.asset(
                      imagePaths[currentIndex],
                      fit: BoxFit.cover,
                      key: ValueKey(currentIndex),
                      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                        return frame == null
                            ? const Center(child: CircularProgressIndicator())
                            : child;
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 8), // Space between image and dots

                // Dots Indicator (Now positioned BELOW the image)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(imagePaths.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        context.read<BannerCubit>().manualScroll(index);
                      },
                      child: Container(
                        width: 8,
                        height: 8,
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: currentIndex == index
                              ? Colors.grey // Selected dot (solid grey)
                              : Colors.transparent, // Unselected dots are transparent
                          border: Border.all(
                            color: const Color(0xFFABABAB), // Greyish border
                            width: 1,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
