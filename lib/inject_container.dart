import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';

final getIt = GetIt.instance;

void setup() {
  // Register FirebaseAuth instance
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  // Register use cases
  getIt.registerLazySingleton<RegisterUseCase>(
      () => RegisterUseCase(firebaseAuth: getIt()));
  getIt.registerLazySingleton<LoginUseCase>(
      () => LoginUseCase(firebaseAuth: getIt()));
}
