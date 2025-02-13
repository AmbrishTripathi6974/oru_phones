import 'package:flutter_bloc/flutter_bloc.dart';

class Product {
  final String name;
  final String storage;
  final String condition;
  final String location;
  final String datePosted;
  final int currentPrice;
  final int originalPrice;
  final String discount;

  Product({
    required this.name,
    required this.storage,
    required this.condition,
    required this.location,
    required this.datePosted,
    required this.currentPrice,
    required this.originalPrice,
    required this.discount,
  });
}

class ProductCubit extends Cubit<List<dynamic>> {
  final List<String> ads = [
    'assets/images/ads/compare.png',
    'assets/images/ads/sell.png',
  ];

  ProductCubit()
      : super([
          Product(
            name: 'Apple iPhone 13 Pro',
            storage: '12/256 GB',
            condition: 'Like New',
            location: 'Nijampur, Luc...',
            datePosted: 'July 25th',
            currentPrice: 415,
            originalPrice: 815,
            discount: '45%',
          ),
          Product(
            name: 'Apple iPhone 13 Pro',
            storage: '12/256 GB',
            condition: 'Like New',
            location: 'Nijampur, Luc...',
            datePosted: 'July 25th',
            currentPrice: 415,
            originalPrice: 815,
            discount: '45%',
          ),
          Product(
            name: 'Apple iPhone 13 Pro',
            storage: '12/256 GB',
            condition: 'Like New',
            location: 'Nijampur, Luc...',
            datePosted: 'July 25th',
            currentPrice: 415,
            originalPrice: 815,
            discount: '45%',
          ),
          Product(
            name: 'Apple iPhone 13 Pro',
            storage: '12/256 GB',
            condition: 'Like New',
            location: 'Nijampur, Luc...',
            datePosted: 'July 25th',
            currentPrice: 415,
            originalPrice: 815,
            discount: '45%',
          ),
          Product(
            name: 'Samsung Galaxy S22 Ultra',
            storage: '12/512 GB',
            condition: 'Brand New',
            location: 'Delhi, India',
            datePosted: 'Aug 10th',
            currentPrice: 700,
            originalPrice: 1200,
            discount: '41%',
          ),
          Product(
            name: 'Samsung Galaxy S22 Ultra',
            storage: '12/512 GB',
            condition: 'Brand New',
            location: 'Delhi, India',
            datePosted: 'Aug 10th',
            currentPrice: 700,
            originalPrice: 1200,
            discount: '41%',
          ),
          Product(
            name: 'Samsung Galaxy S22 Ultra',
            storage: '12/512 GB',
            condition: 'Brand New',
            location: 'Delhi, India',
            datePosted: 'Aug 10th',
            currentPrice: 700,
            originalPrice: 1200,
            discount: '41%',
          ),
          Product(
            name: 'Google Pixel 7',
            storage: '8/128 GB',
            condition: 'Like New',
            location: 'Mumbai, India',
            datePosted: 'Sep 5th',
            currentPrice: 550,
            originalPrice: 900,
            discount: '39%',
          ),
          Product(
            name: 'Google Pixel 7',
            storage: '8/128 GB',
            condition: 'Like New',
            location: 'Mumbai, India',
            datePosted: 'Sep 5th',
            currentPrice: 550,
            originalPrice: 900,
            discount: '39%',
          ),
          Product(
            name: 'Google Pixel 7',
            storage: '8/128 GB',
            condition: 'Like New',
            location: 'Mumbai, India',
            datePosted: 'Sep 5th',
            currentPrice: 550,
            originalPrice: 900,
            discount: '39%',
          ),
          Product(
            name: 'Google Pixel 7',
            storage: '8/128 GB',
            condition: 'Like New',
            location: 'Mumbai, India',
            datePosted: 'Sep 5th',
            currentPrice: 550,
            originalPrice: 900,
            discount: '39%',
          ),
          Product(
            name: 'Google Pixel 7',
            storage: '8/128 GB',
            condition: 'Like New',
            location: 'Mumbai, India',
            datePosted: 'Sep 5th',
            currentPrice: 550,
            originalPrice: 900,
            discount: '39%',
          ),
          Product(
            name: 'Google Pixel 7',
            storage: '8/128 GB',
            condition: 'Like New',
            location: 'Mumbai, India',
            datePosted: 'Sep 5th',
            currentPrice: 550,
            originalPrice: 900,
            discount: '39%',
          ),
          Product(
            name: 'Google Pixel 7',
            storage: '8/128 GB',
            condition: 'Like New',
            location: 'Mumbai, India',
            datePosted: 'Sep 5th',
            currentPrice: 550,
            originalPrice: 900,
            discount: '39%',
          ),
          // Add more products...
        ]) {
    _addAdsToList();
  }

  void _addAdsToList() {
    List<dynamic> modifiedList = [];
    int adIndex = 0;

    for (int i = 0; i < state.length; i++) {
      modifiedList.add(state[i]);

      // Add an ad after every 7th product
      if ((i + 1) % 7 == 0) {
        modifiedList.add(ads[adIndex % ads.length]);
        adIndex++;
      }
    }
    emit(modifiedList);
  }

  void sortAscending() {
    final sortedList = List<Product>.from(state.whereType<Product>())
      ..sort((a, b) => a.currentPrice.compareTo(b.currentPrice));
    emit(_insertAds(sortedList));
  }

  void sortDescending() {
    final sortedList = List<Product>.from(state.whereType<Product>())
      ..sort((a, b) => b.currentPrice.compareTo(a.currentPrice));
    emit(_insertAds(sortedList));
  }

  void filterByCondition(String condition) {
    final filteredList = state.whereType<Product>().where((product) => product.condition == condition).toList();
    emit(_insertAds(filteredList));
  }

  List<dynamic> _insertAds(List<Product> products) {
    List<dynamic> modifiedList = [];
    int adIndex = 0;

    for (int i = 0; i < products.length; i++) {
      modifiedList.add(products[i]);

      if ((i + 1) % 7 == 0) {
        modifiedList.add(ads[adIndex % ads.length]);
        adIndex++;
      }
    }
    return modifiedList;
  }
}
