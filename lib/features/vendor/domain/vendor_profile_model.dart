class VendorProfileModel {
  final String vendorId;
  final String ownerUid;
  final String vendorName;
  final String shopName;
  final String foodCategory;
  final String description;
  final String phoneNumber;
  final String locationText;
  final String city;
  final String country;
  final String preferredLanguage;
  final String? profileImageUrl;
  final String reviewUrl;

  const VendorProfileModel({
    required this.vendorId,
    required this.ownerUid,
    required this.vendorName,
    required this.shopName,
    required this.foodCategory,
    required this.description,
    required this.phoneNumber,
    required this.locationText,
    required this.city,
    required this.country,
    required this.preferredLanguage,
    required this.profileImageUrl,
    required this.reviewUrl,
  });

  Map<String, dynamic> toFirestoreMap() {
    return {
      'vendorId': vendorId,
      'ownerUid': ownerUid,
      'vendorName': vendorName,
      'shopName': shopName,
      'foodCategory': foodCategory,
      'description': description,
      'phoneNumber': phoneNumber,
      'locationText': locationText,
      'city': city,
      'country': country,
      'preferredLanguage': preferredLanguage,
      'profileImageUrl': profileImageUrl,
      'reviewUrl': reviewUrl,
      'isVerified': false,
      'isPublic': true,
      'updatedAt': DateTime.now().millisecondsSinceEpoch,
    };
  }

  factory VendorProfileModel.fromFirestoreMap(Map<String, dynamic> map) {
    return VendorProfileModel(
      vendorId: map['vendorId'] as String,
      ownerUid: map['ownerUid'] as String,
      vendorName: map['vendorName'] as String? ?? '',
      shopName: map['shopName'] as String? ?? '',
      foodCategory: map['foodCategory'] as String? ?? '',
      description: map['description'] as String? ?? '',
      phoneNumber: map['phoneNumber'] as String? ?? '',
      locationText: map['locationText'] as String? ?? '',
      city: map['city'] as String? ?? '',
      country: map['country'] as String? ?? 'Bangladesh',
      preferredLanguage: map['preferredLanguage'] as String? ?? 'en',
      profileImageUrl: map['profileImageUrl'] as String?,
      reviewUrl: map['reviewUrl'] as String? ?? '',
    );
  }
}
