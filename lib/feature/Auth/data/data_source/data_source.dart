import 'package:curt_task/core/network/api_service.dart';
import 'package:curt_task/feature/Auth/data/model/user_model.dart';

abstract class AuthDataSource {
  Future<bool> login(String email, String password);
  Future<bool> signUp(String email, String password);
}

class LocalAuthDataSource extends AuthDataSource {


  ApiService apiService=ApiService();
@override
  Future<bool> login(String email, String password) async {
      return await apiService.login(email, password);

  }

  @override
  Future<bool> signUp(String email, String password) {
  return apiService.signUp(email, password);
  }

  }

