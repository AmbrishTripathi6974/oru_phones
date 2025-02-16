import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import '../data/product_model.dart';

class ProductCubit extends Cubit<List<dynamic>?> {
  ProductCubit() : super(null); // ✅ `null` for initial loading

  final Dio _dio = Dio();

  /// ✅ Predefined Ad Banners (Cyclic Rotation)
  final List<String> adBanners = [
    "assets/images/ads/compare.png",
    "assets/images/ads/sell.png",
  ];

  /// ✅ Fetch Products from API (POST Request)
  void fetchProducts() async {
    try {
      emit(null); // ✅ Show loading state
      print("📢 Fetching products...");

      final response = await _dio.post(
        'http://40.90.224.241:5000/filter',
        data: {"filter": {}}, // ✅ Correct JSON Body
        options: Options(headers: {"Content-Type": "application/json"}),
      );

      print("📢 API Raw Response: ${response.data}");

      if (response.statusCode == 200 && response.data != null) {
        final dynamic rawData = response.data['data'];

        if (rawData == null || rawData['data'] == null) {
          print("⚠️ No valid product list found in API response.");
          emit([]);
          return;
        }

        final List<dynamic> data = rawData['data'];
        if (data.isEmpty) {
          print("⚠️ No products found in API.");
          emit([]);
          return;
        }

        /// ✅ Convert API data to `Product` model safely
        List<Product> products = [];
        for (var item in data) {
          try {
            // ✅ Validate if item contains 'status' key
            if (item is Map<String, dynamic> && item.containsKey('status')) {
              String? status = item['status']?.toString().toLowerCase();
              
              if (status == "active") {
                products.add(Product.fromJson(item));
              }
            }
          } catch (e) {
            print("❌ Error parsing product: $e\n❗ Skipping this item.");
          }
        }

        print("✅ Fetched ${products.length} active products.");

        if (products.isEmpty) {
          print("⚠️ No active products found.");
          emit([]);
          return;
        }

        /// ✅ Insert Ad Banners into the Product List
        List<dynamic> finalItems = _insertAds(products);
        print("✅ Total items (including ads): ${finalItems.length}");

        emit(finalItems); // ✅ Update state with products & ads
      } else {
        print("❌ API Error: Status Code ${response.statusCode}");
        emit([]);
      }
    } catch (e) {
      print("❌ Error fetching products: $e");
      emit([]);
    }
  }

  /// ✅ Function to Insert Ad Banners after every 7th Product (Cyclic Ads)
  List<dynamic> _insertAds(List<Product> products) {
    List<dynamic> modifiedList = [];
    int adIndex = 0;

    for (int i = 0; i < products.length; i++) {
      modifiedList.add(products[i]);

      if ((i + 1) % 7 == 0 && adBanners.isNotEmpty) {
        modifiedList.add(adBanners[adIndex]); // ✅ Insert ad
        adIndex = (adIndex + 1) % adBanners.length; // ✅ Cycle through ads
      }
    }

    print("📢 Final Product List with Ads: ${modifiedList.length} items");
    return modifiedList;
  }
}
