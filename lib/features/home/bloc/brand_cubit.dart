import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../brand/model/brand_model.dart';

class BrandsCubit extends Cubit<List<Brand>> {
  BrandsCubit() : super([]);

  final Dio _dio = Dio();

  Future<void> fetchBrands() async {
    try {
      final response = await _dio.get('http://40.90.224.241:5000/makeWithImages');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['dataObject'];
        final brands = data.map((json) => Brand.fromJson(json)).toList();
        emit(brands);
      }
    } catch (e) {
      print("Error fetching brands: $e");
    }
  }
}
