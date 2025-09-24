import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String userId;
  final String email;
  final String campusId;
  final String role;
  final String name;
  final double walletBalance;
  final String? phoneNumber;
  final String? profileImageUrl;

  const UserModel({
    required this.userId,
    required this.email,
    required this.campusId,
    required this.role,
    required this.name,
    required this.walletBalance,
    this.phoneNumber,
    this.profileImageUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'] as String,
      email: json['email'] as String,
      campusId: json['campusId'] as String,
      role: json['role'] as String,
      name: json['name'] as String,
      walletBalance: (json['walletBalance'] as num).toDouble(),
      phoneNumber: json['phoneNumber'] as String?,
      profileImageUrl: json['profileImageUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'email': email,
      'campusId': campusId,
      'role': role,
      'name': name,
      'walletBalance': walletBalance,
      'phoneNumber': phoneNumber,
      'profileImageUrl': profileImageUrl,
    };
  }

  UserModel copyWith({
    String? userId,
    String? email,
    String? campusId,
    String? role,
    String? name,
    double? walletBalance,
    String? phoneNumber,
    String? profileImageUrl,
  }) {
    return UserModel(
      userId: userId ?? this.userId,
      email: email ?? this.email,
      campusId: campusId ?? this.campusId,
      role: role ?? this.role,
      name: name ?? this.name,
      walletBalance: walletBalance ?? this.walletBalance,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
    );
  }

  @override
  List<Object?> get props {
    return [
      userId,
      email,
      campusId,
      role,
      name,
      walletBalance,
      phoneNumber,
      profileImageUrl,
    ];
  }
}
