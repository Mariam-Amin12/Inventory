import 'package:curt_task/feature/Auth/data/model/user_model.dart';

abstract class BaseAuthRepository {
  Future<bool> logIn(String email, String password);
  Future<bool> signUp(String email, String password);
}