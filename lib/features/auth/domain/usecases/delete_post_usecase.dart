import 'package:tisocial/features/auth/domain/repositories/firebase_repository.dart';
import '../entities/user_posts_entity.dart';

class DeletePostUsecase {
  final FirebaseRepository repository;

  DeletePostUsecase({required this.repository});
  Future<void> call(UserPostEntity userPostEntity) async {
    return repository.deletePost(userPostEntity);
  }
}
