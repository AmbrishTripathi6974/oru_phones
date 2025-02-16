class Product {
  final String id;
  final String deviceCondition;
  final String listedBy;
  final String deviceStorage;
  final String listingState;
  final String listingLocation;
  final String listingLocality;
  final String listingPrice;
  final String make;
  final String marketingName;
  final bool openForNegotiation;
  final double discountPercentage;
  final bool verified;
  final String listingId;
  final String status;
  final String verifiedDate;
  final String listingDate;
  final String deviceRam;
  final String warranty;
  final String imagePath;
  final String createdAt;
  final String updatedAt;
  final int originalPrice;
  final int discountedPrice;
  final String defaultImage;
  
  Product({
    required this.id,
    required this.deviceCondition,
    required this.listedBy,
    required this.deviceStorage,
    required this.listingState,
    required this.listingLocation,
    required this.listingLocality,
    required this.listingPrice,
    required this.make,
    required this.marketingName,
    required this.openForNegotiation,
    required this.discountPercentage,
    required this.verified,
    required this.listingId,
    required this.status,
    required this.verifiedDate,
    required this.listingDate,
    required this.deviceRam,
    required this.warranty,
    required this.imagePath,
    required this.createdAt,
    required this.updatedAt,
    required this.originalPrice,
    required this.discountedPrice,
    required this.defaultImage,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json["_id"],
      deviceCondition: json["deviceCondition"],
      listedBy: json["listedBy"],
      deviceStorage: json["deviceStorage"],
      listingState: json["listingState"],
      listingLocation: json["listingLocation"],
      listingLocality: json["listingLocality"],
      listingPrice: json["listingPrice"],
      make: json["make"],
      marketingName: json["marketingName"],
      openForNegotiation: json["openForNegotiation"],
      discountPercentage: json["discountPercentage"].toDouble(),
      verified: json["verified"],
      listingId: json["listingId"],
      status: json["status"],
      verifiedDate: json["verifiedDate"],
      listingDate: json["listingDate"],
      deviceRam: json["deviceRam"],
      warranty: json["warranty"],
      imagePath: json["imagePath"],
      createdAt: json["createdAt"],
      updatedAt: json["updatedAt"],
      originalPrice: json["originalPrice"],
      discountedPrice: json["discountedPrice"],
      defaultImage: json["defaultImage"]["fullImage"],
    );
  }
}
