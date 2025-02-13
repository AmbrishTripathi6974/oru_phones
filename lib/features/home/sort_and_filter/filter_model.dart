class FilterModel {
  final List<String> brand;
  final List<String> ram;
  final List<String> storage;
  final List<String> conditions;
  final List<String> warranty;

  FilterModel({
    required this.brand,
    required this.ram,
    required this.storage,
    required this.conditions,
    required this.warranty,
  });

  factory FilterModel.fromJson(Map<String, dynamic> json) {
    return FilterModel(
      brand: List<String>.from(json["Brand"] ?? []),
      ram: List<String>.from(json["Ram"] ?? []),
      storage: List<String>.from(json["Storage"] ?? []),
      conditions: List<String>.from(json["Conditions"] ?? []),
      warranty: List<String>.from(json["Warranty"] ?? []),
    );
  }
}
