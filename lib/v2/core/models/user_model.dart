// Simple User model - no Hive for now
class User {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String? phone;
  final String? profileImage;
  final String? address;
  final bool emailVerified;
  final bool phoneVerified;
  final bool hasPasscode;
  final int registrationStage;
  final String? createdAt;
  final String? updatedAt;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.phone,
    this.profileImage,
    this.address,
    this.emailVerified = false,
    this.phoneVerified = false,
    this.hasPasscode = false,
    this.registrationStage = 1,
    this.createdAt,
    this.updatedAt,
  });

  String get fullName => '$firstName $lastName';
  String get initials => '${firstName[0]}${lastName[0]}'.toUpperCase();

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] ?? json['id'] ?? '',
      firstName: json['firstName'] ?? json['first_name'] ?? '',
      lastName: json['lastName'] ?? json['last_name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'],
      profileImage: json['profileImage'] ?? json['profile_image'],
      address: json['address'],
      emailVerified: json['emailVerified'] ?? json['email_verified'] ?? false,
      phoneVerified: json['phoneVerified'] ?? json['phone_verified'] ?? false,
      hasPasscode: json['hasPasscode'] ?? json['has_passcode'] ?? false,
      registrationStage:
          json['registrationStage'] ?? json['registration_stage'] ?? 1,
      createdAt: json['created_at'] ?? json['createdAt'],
      updatedAt: json['updated_at'] ?? json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'profileImage': profileImage,
      'address': address,
      'emailVerified': emailVerified,
      'phoneVerified': phoneVerified,
      'hasPasscode': hasPasscode,
      'registrationStage': registrationStage,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
