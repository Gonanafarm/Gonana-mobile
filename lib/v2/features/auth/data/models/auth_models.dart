// Auth models - Plain Dart classes

// ==================== REQUESTS ====================

class LoginRequest {
  final String email;
  final String password;

  LoginRequest({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
      };
}

class SignUpRequest {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String phone;

  SignUpRequest({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.phone,
  });

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
        'phone': phone,
      };
}

class OtpRequest {
  final String otp;
  final String? email;

  OtpRequest({
    required this.otp,
    this.email,
  });

  Map<String, dynamic> toJson() => {
        'otp': otp,
        if (email != null) 'email': email,
      };
}

class ResendOtpRequest {
  final String email;

  ResendOtpRequest({required this.email});

  Map<String, dynamic> toJson() => {'email': email};
}

class ForgotPasswordRequest {
  final String email;

  ForgotPasswordRequest({required this.email});

  Map<String, dynamic> toJson() => {'email': email};
}

class ResetPasswordRequest {
  final String email;
  final String password;
  final String? otp;

  ResetPasswordRequest({
    required this.email,
    required this.password,
    this.otp,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        if (otp != null) 'otp': otp,
      };
}

class UpdateProfileRequest {
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String? address;

  UpdateProfileRequest({
    this.firstName,
    this.lastName,
    this.phone,
    this.address,
  });

  Map<String, dynamic> toJson() => {
        if (firstName != null) 'firstName': firstName,
        if (lastName != null) 'lastName': lastName,
        if (phone != null) 'phone': phone,
        if (address != null) 'address': address,
      };
}

class PasscodeRequest {
  final String passcode;

  PasscodeRequest({required this.passcode});

  Map<String, dynamic> toJson() => {'passcode': passcode};
}

// ==================== RESPONSES ====================

class AuthResponse {
  final bool success;
  final String message;
  final String? token;
  final UserData? user;
  final dynamic data;

  AuthResponse({
    required this.success,
    required this.message,
    this.token,
    this.user,
    this.data,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      token: json['token'],
      user: json['user'] != null ? UserData.fromJson(json['user']) : null,
      data: json['data'],
    );
  }
}

class UserResponse {
  final bool success;
  final String message;
  final UserData? user;
  final dynamic data;

  UserResponse({
    required this.success,
    required this.message,
    this.user,
    this.data,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      user: json['user'] != null ? UserData.fromJson(json['user']) : null,
      data: json['data'],
    );
  }
}

class BaseResponse {
  final bool success;
  final String message;
  final dynamic data;

  BaseResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory BaseResponse.fromJson(Map<String, dynamic> json) {
    return BaseResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'],
    );
  }
}

// ==================== USER DATA ====================

class UserData {
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

  UserData({
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

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
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
}
