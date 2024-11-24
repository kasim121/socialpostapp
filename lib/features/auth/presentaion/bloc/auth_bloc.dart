import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/login_user.dart';
import '../../domain/usecases/register_user.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final RegisterUseCase registerUseCase;
  final LoginUseCase loginUseCase;

  AuthBloc({
    required this.registerUseCase,
    required this.loginUseCase,
  }) : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is RegisterEvent) {
      yield AuthLoading();
      final result = await registerUseCase.execute(
        event.username,
        event.email,
        event.password,
      );
      yield result.fold(
        (failure) => AuthError(failure.message),
        (user) => AuthSuccess(user),
      );
    } else if (event is LoginEvent) {
      yield AuthLoading();
      final result = await loginUseCase.execute(
        event.email,
        event.password,
      );
      yield result.fold(
        (failure) => AuthError(failure.message),
        (user) => AuthSuccess(user),
      );
    }
  }
}
