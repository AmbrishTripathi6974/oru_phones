import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/product_model.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final Dio _dio = Dio();

  ProductBloc() : super(ProductInitial()) {
    on<FetchProducts>(_fetchProducts);
  }

  Future<void> _fetchProducts(FetchProducts event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      final response = await _dio.get('http://40.90.224.241:5000/filter');

      if (response.statusCode == 200 && response.data["data"] != null) {
        final List<dynamic> data = response.data["data"]["data"] ?? [];

        if (data.isEmpty) {
          emit(ProductEmpty());
          return;
        }

        List<Product> products = data.map((e) => Product.fromJson(e)).toList();
        emit(ProductLoaded(products));
      } else {
        emit(ProductError('Failed to load products'));
      }
    } catch (e) {
      emit(ProductError('Error: ${e.toString()}'));
    }
  }
}
