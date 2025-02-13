import '../bloc/sort_and_filter_cubit.dart';

extension SortOptionLabel on SortOption {
  String toLabel() {
    switch (this) {
      case SortOption.valueForMoney:
        return "Value For Money";
      case SortOption.ascending:
        return "Price: Low To High";
      case SortOption.descending:
        return "Price: High To Low";
      case SortOption.latest:
        return "Latest";
      case SortOption.distance:
        return "Distance";
      default:
        return "Sort Option";
    }
  }
}
