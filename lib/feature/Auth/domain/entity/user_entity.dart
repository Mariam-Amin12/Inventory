import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
    final String? id;
  final String userName;
  final String password;
  final String role;

  UserEntity( {
    required this.id,
    required this.userName,
    required this.password,
    required this.role,

  });

  @override
  List<Object?> get props => [id, userName, password, role];

}
