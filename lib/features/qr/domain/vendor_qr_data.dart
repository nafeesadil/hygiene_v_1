class VendorQrData {
  static const String reviewBaseUrl = 'https://hygia-9f3bd.web.app/review.html';

  final String vendorId;
  final String vendorName;
  final String reviewUrl;

  const VendorQrData({
    required this.vendorId,
    required this.vendorName,
    required this.reviewUrl,
  });

  factory VendorQrData.fromVendorProfile({
    required String vendorId,
    required String vendorName,
    required String savedReviewUrl,
  }) {
    final cleanSavedUrl = savedReviewUrl.trim();

    final reviewUrl = cleanSavedUrl.contains('hygia-9f3bd.web.app/review.html')
        ? cleanSavedUrl
        : buildReviewUrl(vendorId);

    return VendorQrData(
      vendorId: vendorId,
      vendorName: vendorName,
      reviewUrl: reviewUrl,
    );
  }

  static String buildReviewUrl(String vendorId) {
    return '$reviewBaseUrl?vendorId=$vendorId';
  }
}
