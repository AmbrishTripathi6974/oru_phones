import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../bloc/favourite_bloc.dart';
import '../data/product_model.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// ✅ Image with "Verified" Badge
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.network(
                  product.defaultImage,
                  height: screenWidth * 0.4, // Responsive height
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

              /// ✅ ORU Verified Badge (Top Left)
              if (product.verified)
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'ORU Verified',
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

              /// ✅ Favorite Icon (Top Right)
              Positioned(
                top: 8,
                right: 8,
                child: BlocBuilder<FavoritesBloc, FavoriteState>(
                  builder: (context, state) {
                    bool isFavorite = false;
                    if (state is FavoriteInitial) {
                      isFavorite = state.favorites.contains(product);
                    }
                    return GestureDetector(
                      onTap: () {
                        context.read<FavoritesBloc>().add(ToggleFavorite(product));
                      },
                      child: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : Colors.white,
                        size: 24,
                      ),
                    );
                  },
                ),
              ),

              /// ✅ Price Negotiable Banner (with Blur)
              if (product.openForNegotiation)
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        color: const Color(0x4C4C4C4C), // 69% opacity
                        child: Center(
                          child: Text(
                            'PRICE NEGOTIABLE',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),

          /// ✅ Product Details
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// ✅ Product Name
                  Flexible(
                    child: Text(
                      product.marketingName,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        fontSize: screenWidth * 0.035, // Responsive text size
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                  ),

                  const SizedBox(height: 4),

                  /// ✅ Storage & Condition
                  Text(
                    '${product.deviceStorage} • ${product.deviceCondition}',
                    style: GoogleFonts.poppins(
                      fontSize: screenWidth * 0.03,
                      color: const Color(0xFF6D6D6D),
                    ),
                  ),

                  const Spacer(),

                  /// ✅ Pricing Section (Responsive)
                  FittedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          '₹ ${product.discountedPrice}',
                          style: GoogleFonts.poppins(
                            fontSize: screenWidth * 0.04, // Responsive size
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '₹ ${product.originalPrice}',
                          style: GoogleFonts.poppins(
                            fontSize: screenWidth * 0.03,
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '(${product.discountPercentage.toStringAsFixed(2)}% off)',
                          style: GoogleFonts.poppins(
                            fontSize: screenWidth * 0.03,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 6),

                  /// ✅ Location & Date (Responsive)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          '${product.listingLocality}, ${product.listingLocation}, ${product.listingState}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontSize: screenWidth * 0.03,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF7D7D7D),
                          ),
                        ),
                      ),
                      Text(
                        product.listingDate,
                        style: GoogleFonts.poppins(
                          fontSize: screenWidth * 0.03,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF7D7D7D),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
