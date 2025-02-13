import 'package:dio/dio.dart';
import 'filter_model.dart';

class FilterRepository {
  final Dio _dio = Dio();

  Future<FilterModel> fetchFilters() async {
    try {
      final response = await _dio.get('http://40.90.224.241:5000/showSearchFilters');

      if (response.statusCode == 200 && response.data != null) {
        return FilterModel.fromJson(response.data);
      } else {
        throw Exception("Failed to fetch filters");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}
