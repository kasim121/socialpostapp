import 'package:tisocial/features/auth/domain/repositories/firebase_repository.dart';

class IsSigninUseCase {
  final FirebaseRepository repository;

  IsSigninUseCase({required this.repository});
  Future<bool> call() async {
    return repository.isSignIn();
  }
}
