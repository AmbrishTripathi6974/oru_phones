import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import '../bloc/brand_cubit.dart';
import 'model/brand_model.dart';

class BrandsWidget extends StatelessWidget {
  final List<String> localBrands = [
    'apple.png',
    'mi.png',
    'samsung.png',
    'vivo.png',
    'realme.png',
    'motorola.png',
    'oppo.png',
  ];

  BrandsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BrandsCubit()..fetchBrands(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Horizontal brand list
          SizedBox(
            height: 90, // Adjusted for padding
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: localBrands.length + 1,
                itemBuilder: (context, index) {
                  if (index == localBrands.length) {
                    return _viewAllButton(context);
                  }
                  return _brandItem('assets/images/brand_logo/${localBrands[index]}');
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _brandItem(String imagePath) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Container(
        width: 80,
        height: 80,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFFF2F2F2),
          // boxShadow: [
          //   BoxShadow(color: Colors.grey.shade300, blurRadius: 4, spreadRadius: 1),
          // ],
        ),
        child: ClipOval(
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Image.asset(
              imagePath,
              width: 64,
              height: 64,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }

  Widget _viewAllButton(BuildContext context) {
    return GestureDetector(
      onTap: () => _showBrandBottomSheet(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Container(
          width: 80,
          height: 80,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFFF2F2F2),
            // boxShadow: [
            //   BoxShadow(color: Colors.grey.shade300, blurRadius: 4, spreadRadius: 1),
            // ],
          ),
          child: Text(
            "View All",
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, fontFamily: GoogleFonts.poppins().fontFamily),
          ),
        ),
      ),
    );
  }

  void _showBrandBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return BlocProvider.value(
          value: BlocProvider.of<BrandsCubit>(context),
          child: _BrandBottomSheetContent(),
        );
      },
    );
  }
}

class _BrandBottomSheetContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BrandsCubit, List<Brand>>(
      builder: (context, brands) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Text(
                  "Select the Brand",
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                height: 200,
                child: GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: brands.length,
                  itemBuilder: (context, index) {
                    return _brandGridItem(brands[index]);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _brandGridItem(Brand brand) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey.shade100,
            boxShadow: [
              BoxShadow(color: Colors.grey.shade300, blurRadius: 2, spreadRadius: 1),
            ],
          ),
          child: ClipOval(
            child: CachedNetworkImage(
              imageUrl: brand.imagePath,
              width: 30,
              height: 30,
              fit: BoxFit.contain,
              placeholder: (context, url) => const Padding(
                padding: EdgeInsets.all(8),
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.broken_image, size: 20),
            ),
          ),
        ),
      ],
    );
  }
}
