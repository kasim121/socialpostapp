import 'package:tisocial/features/auth/domain/repositories/firebase_repository.dart';

class GetCurrentUidUsecase {
  final FirebaseRepository repository;

  GetCurrentUidUsecase({required this.repository});
  Future<String> call() async {
    return repository.getCurrentUserId();
  }
}
