import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

import '../sort_and_filter/filter_model.dart';

class FilterState {
  final FilterModel? filters;
  final bool isLoading;
  final String? errorMessage;
  final Map<String, List<String>> selectedFilters;

  FilterState({
    this.filters,
    this.isLoading = false,
    this.errorMessage,
    required this.selectedFilters,
  });

  FilterState copyWith({
    FilterModel? filters,
    bool? isLoading,
    String? errorMessage,
    Map<String, List<String>>? selectedFilters,
  }) {
    return FilterState(
      filters: filters ?? this.filters,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      selectedFilters: selectedFilters ?? this.selectedFilters,
    );
  }
}

class FilterCubit extends Cubit<FilterState> {
  final Dio _dio = Dio();

  FilterCubit()
      : super(FilterState(
          selectedFilters: {},
          isLoading: false,
        ));

  Future<void> fetchFilters() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      final response = await _dio.get('http://40.90.224.241:5000/showSearchFilters');

      if (response.statusCode == 200) {
        final data = response.data['dataObject'];
        final filters = FilterModel.fromJson(data);
        emit(state.copyWith(filters: filters, isLoading: false));
      } else {
        emit(state.copyWith(errorMessage: 'Failed to fetch filters', isLoading: false));
      }
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), isLoading: false));
    }
  }

  void toggleFilter(String category, String value) {
    final updatedFilters = Map<String, List<String>>.from(state.selectedFilters);
    if (updatedFilters.containsKey(category)) {
      if (updatedFilters[category]!.contains(value)) {
        updatedFilters[category]!.remove(value);
        if (updatedFilters[category]!.isEmpty) {
          updatedFilters.remove(category);
        }
      } else {
        updatedFilters[category]!.add(value);
      }
    } else {
      updatedFilters[category] = [value];
    }
    emit(state.copyWith(selectedFilters: updatedFilters));
  }

  void clearFilters() {
    emit(state.copyWith(selectedFilters: {}));
  }
}
