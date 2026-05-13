class VendorQrData {
  final String vendorId;
  final String vendorName;
  final String reviewUrl;

  const VendorQrData({
    required this.vendorId,
    required this.vendorName,
    required this.reviewUrl,
  });

  factory VendorQrData.mock() {
    const vendorId = 'vendor_karim_001';
    const vendorName = "Karim's Jhalmuri";
    const reviewBaseUrl = 'https://hygia.app/review';

    return const VendorQrData(
      vendorId: vendorId,
      vendorName: vendorName,
      reviewUrl: '$reviewBaseUrl?vendorId=$vendorId',
    );
  }
}
