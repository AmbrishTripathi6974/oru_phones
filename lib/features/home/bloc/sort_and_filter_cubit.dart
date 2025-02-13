import 'package:flutter_bloc/flutter_bloc.dart';

enum SortOption { none, valueForMoney, ascending, descending, latest, distance }

class SortFilterCubit extends Cubit<Map<String, dynamic>> {
  SortFilterCubit()
      : super({
          'sort': SortOption.none,
          'filters': <String, List<String>>{}, // Stores multiple filters
        });

  // Updates the sorting option
  void updateSort(SortOption option) {
    emit({...state, 'sort': option});
  }

  // Updates filters dynamically
  void updateFilters(Map<String, List<String>> selectedFilters) {
    emit({...state, 'filters': selectedFilters});
  }

  // Clears all selected filters
  void clearFilters() {
    emit({...state, 'filters': {}});
  }
}
