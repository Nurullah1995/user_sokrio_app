
import 'package:user_app_for_sokrio/features/user/domain/entities/user_entities.dart';

class UserModel extends UserEntity  {
  const UserModel({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.avatar,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'],
    firstName: json['first_name'],
    lastName: json['last_name'],
    email: json['email'],
    avatar: json['avatar'],
  );
}