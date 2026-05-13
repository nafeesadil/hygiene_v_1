enum AppUserRole { vendor, customer }

class AppUser {
  final String uid;
  final AppUserRole role;
  final String fullName;
  final String? email;
  final String phoneNumber;
  final String preferredLanguage;
  final bool isActive;

  const AppUser({
    required this.uid,
    required this.role,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.preferredLanguage,
    required this.isActive,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'role': role.name,
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'preferredLanguage': preferredLanguage,
      'isActive': isActive,
      'updatedAt': DateTime.now().millisecondsSinceEpoch,
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      uid: map['uid'] as String,
      role: (map['role'] as String) == 'customer'
          ? AppUserRole.customer
          : AppUserRole.vendor,
      fullName: map['fullName'] as String? ?? '',
      email: map['email'] as String?,
      phoneNumber: map['phoneNumber'] as String? ?? '',
      preferredLanguage: map['preferredLanguage'] as String? ?? 'en',
      isActive: map['isActive'] as bool? ?? true,
    );
  }
}
