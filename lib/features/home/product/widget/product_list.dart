import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/product_cubit.dart';
import '../data/product_model.dart';
import 'product_widget.dart';
import 'ads_card_widget.dart';

class ProductList extends StatelessWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: BlocProvider(
        create: (context) {
          final cubit = ProductCubit();
          cubit.fetchProducts(); // ✅ Fetch products on initialization
          return cubit;
        },
        child: BlocBuilder<ProductCubit, List<dynamic>?>(
          builder: (context, items) {
            if (items == null) {
              return const Center(child: CircularProgressIndicator()); // ✅ Show loading
            }

            if (items.isEmpty) {
              return const Center(child: Text("No products available."));
            }

            return GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // ✅ Two columns
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 0.55,
              ),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];

                if (item is Product) {
                  return ProductCard(product: item); // ✅ Show Product Card
                } else if (item is String) {
                  return AdCard(imagePath: item); // ✅ Show Ad Card
                }

                return const SizedBox.shrink();
              },
            );
          },
        ),
      ),
    );
  }
}
