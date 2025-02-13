import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/product_data.dart';
import 'ads_card_widget.dart';
import 'product_widget.dart';

class ProductList extends StatelessWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: BlocProvider(
        create: (context) => ProductCubit(),
        child: BlocBuilder<ProductCubit, List<dynamic>>(
          builder: (context, products) {
            return Column(
              children: [
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 0.55,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final item = products[index];

                    if (item is Product) {
                      return ProductCard(product: item);
                    } else if (item is String) {
                      return AdCard(imagePath: item);
                    }
                    return const SizedBox.shrink();
                  },
                ),

                const SizedBox(height: 10),
              ],
            );
          },
        ),
      ),
    );
  }
}
