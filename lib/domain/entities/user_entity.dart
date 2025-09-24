import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String userId;
  final String email;
  final String campusId;
  final String role;
  final String name;
  final double walletBalance;
  final String? phoneNumber;
  final String? profileImageUrl;

  const UserEntity({
    required this.userId,
    required this.email,
    required this.campusId,
    required this.role,
    required this.name,
    required this.walletBalance,
    this.phoneNumber,
    this.profileImageUrl,
  });

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
