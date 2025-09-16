class PhoneData {
  final String phone;
  final String userType;
  final String email;

  PhoneData({required this.phone, required this.userType, required this.email});

  factory PhoneData.fromJson(Map<String, dynamic> json) {
    return PhoneData(
      phone: json['phone'],
      userType: json['user_type'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'phone': phone, 'user_type': userType, 'email': email};
  }
}

class CheckPhoneExistResponse {
  final int status;
  final String message;
  final PhoneData? data;
  final String? error;

  CheckPhoneExistResponse({
    required this.status,
    required this.message,
    this.data,
    this.error,
  });

  /// Factory constructor to create from JSON
  factory CheckPhoneExistResponse.fromJson(Map<String, dynamic> json) {
    return CheckPhoneExistResponse(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null ? PhoneData.fromJson(json['data']) : null,
      error: json['error'],
    );
  }

  /// Convert back to JSON
  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data?.toJson(),
      'error': error,
    };
  }

  /// Helper getter to check success
  bool get success => status >= 200 && status < 300;

  /// Create a success response manually
  factory CheckPhoneExistResponse.success({
    PhoneData? data,
    String? message,
    int status = 200,
  }) {
    return CheckPhoneExistResponse(
      status: status,
      message: message ?? "Success",
      data: data,
      error: null,
    );
  }

  /// Create an error response manually
  factory CheckPhoneExistResponse.error({
    String? message,
    int status = 400,
    String? error,
  }) {
    return CheckPhoneExistResponse(
      status: status,
      message: message ?? "Error",
      data: null,
      error: error,
    );
  }
}
