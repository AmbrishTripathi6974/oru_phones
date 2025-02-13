class Brand {
  final String name;
  final String imagePath;

  Brand({required this.name, required this.imagePath});

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      name: json['make'],
      imagePath: json['imagePath'],
    );
  }
}
