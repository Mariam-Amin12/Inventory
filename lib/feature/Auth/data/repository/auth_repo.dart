import 'package:curt_task/feature/Auth/data/data_source/data_source.dart';
import 'package:curt_task/feature/Auth/domain/base_repo/base_auth_repo.dart';

class AuthRepository extends BaseAuthRepository {
  final AuthDataSource authDataSource;

  AuthRepository(this.authDataSource);

  @override
  Future<bool> logIn(String email, String password) async {
   return await authDataSource.login(email, password);
  }

  @override
  Future<bool> signUp(String email, String password) async {
   return await authDataSource.signUp(email, password);

  }
}