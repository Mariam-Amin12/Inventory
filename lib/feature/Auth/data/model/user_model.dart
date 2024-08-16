import 'package:curt_task/feature/Auth/domain/entity/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.id,
    required super.userName,
    required super.password,
    required super.role,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': userName,
      'password': password,
      'role': role,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      userName: json['username'],
      password: json['password'],
      role: json['role'],
    );
  }

}
