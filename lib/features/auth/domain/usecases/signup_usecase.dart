import 'package:tisocial/features/auth/domain/entities/user_details_entity.dart';
import 'package:tisocial/features/auth/domain/repositories/firebase_repository.dart';

class SignUpUseCase {
  final FirebaseRepository repository;

  SignUpUseCase({required this.repository});
  Future<void> call(UserDetailsEntity userDetalsEnttiy) async {
    return repository.signIn(userDetalsEnttiy);
  }
}
