
import 'package:curt_task/feature/Auth/domain/base_repo/base_auth_repo.dart';


class LogInUseCase {
  final BaseAuthRepository _authRepository;

  LogInUseCase(this._authRepository);

  Future<bool> call(String email, String password)async {
    return await _authRepository.logIn(email, password);
  }

}
