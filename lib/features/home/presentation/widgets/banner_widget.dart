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
        child: _BannerView(imagePaths: imagePaths),
      ),
    );
  }
}

class _BannerView extends StatelessWidget {
  final List<String> imagePaths;
  final PageController pageController = PageController();

  _BannerView({required this.imagePaths});

  @override
  Widget build(BuildContext context) {
    return BlocListener<BannerCubit, int>(
      listener: (context, currentIndex) {
        pageController.animateToPage(
          currentIndex,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Banner Image with PageView
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              height: 180,
              width: double.infinity,
              child: PageView.builder(
                controller: pageController,
                itemCount: imagePaths.length,
                onPageChanged: (index) {
                  context.read<BannerCubit>().manualScroll(index);
                },
                itemBuilder: (context, index) {
                  return Image.asset(
                    imagePaths[index],
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
          ),

          const SizedBox(height: 8),

          // Dots Indicator
          BlocBuilder<BannerCubit, int>(
            builder: (context, currentIndex) {
              return Row(
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
                            ? Colors.grey
                            : Colors.transparent,
                        border: Border.all(
                          color: const Color(0xFFABABAB),
                          width: 1,
                        ),
                      ),
                    ),
                  );
                }),
              );
            },
          ),
        ],
      ),
    );
  }
}
