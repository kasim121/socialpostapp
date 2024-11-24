import 'package:tisocial/features/auth/domain/repositories/firebase_repository.dart';
import '../entities/user_posts_entity.dart';

class UpdatePostUsecase {
  final FirebaseRepository repository;

  UpdatePostUsecase({required this.repository});
  Future<void> call(UserPostEntity userPostEntity) async {
    return repository.updatePost(userPostEntity);
  }
}
