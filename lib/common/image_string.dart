import 'package:flutter_bloc/flutter_bloc.dart';

class ImageCubit extends Cubit<List<Map<String, String>>> {
  ImageCubit() : super([]);

  /// Load image paths with corresponding labels
  void loadImages() {
    emit([
      {"image": "assets/images/categories/buy_used_phones.png", "text": "Buy Used Phones"},
      {"image": "assets/images/categories/sell_used_phones.png", "text": "Sell Used Phones"},
      {"image": "assets/images/categories/compare_prices.png", "text": "Compare Prices"},
      {"image": "assets/images/categories/my_profile.png", "text": "My Profile"},
      {"image": "assets/images/categories/my_listings.png", "text": "My Listings"},
      {"image": "assets/images/categories/open_store.png", "text": "Open Store"},
      {"image": "assets/images/categories/services.png", "text": "Services"},
      {"image": "assets/images/categories/device_health_check.png", "text": "Device Health Check"},
      {"image": "assets/images/categories/battery_health_check.png", "text": "Battery Health Check"},
      {"image": "assets/images/categories/imei_verification.png", "text": "IMEI Verification"},
      {"image": "assets/images/categories/device_details.png", "text": "Device Details"},
      {"image": "assets/images/categories/data_wipe.png", "text": "Data Wipe"},
      {"image": "assets/images/categories/under_warranty_phones.png", "text": "Under Warranty Phones"},
      {"image": "assets/images/categories/premium_phones.png", "text": "Premium Phones"},
      {"image": "assets/images/categories/like_new_phones.png", "text": "Like New Phones"},
      {"image": "assets/images/categories/refurbished_phones.png", "text": "Refurbished Phones"},
      {"image": "assets/images/categories/verified_phones.png", "text": "Verified Phones"},
      {"image": "assets/images/categories/my_negotiations.png", "text": "My Negotiations"},
      {"image": "assets/images/categories/my_favorites.png", "text": "My Favorites"},
    ]);
  }
}
