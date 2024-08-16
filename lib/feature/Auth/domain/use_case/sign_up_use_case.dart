import '../base_repo/base_auth_repo.dart';

class SignUpUseCase {
  final BaseAuthRepository repository;

  SignUpUseCase(this.repository);

  Future<bool> call(String email, String password) async {
    return await repository.signUp(email, password);
  
  }
}
