import 'package:bloc/bloc.dart';
import 'package:curt_task/feature/Auth/domain/use_case/log_in_use_case.dart';
import 'package:curt_task/feature/Auth/domain/use_case/sign_up_use_case.dart';
import 'package:equatable/equatable.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LogInUseCase logInUseCase;
  final SignUpUseCase signUpUseCase;

  AuthCubit(this.logInUseCase, this.signUpUseCase) : super(AuthInitial());

  Future<void> login(String email, String password) async {
    try {
      emit(AuthLoading());
      final respons= await logInUseCase.call(email, password);

      if (respons ) {
        emit(AuthSuccess());
      } else {
        emit(AuthFailure('Login failed'));
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

 Future<void> signUp(String email, String password) async {
    try {
      emit(AuthLoading());
      final success = await signUpUseCase.call(email, password);
      if (success) {
        emit(AuthSuccess());
      } else {
        emit(AuthFailure('Sign up failed'));
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}