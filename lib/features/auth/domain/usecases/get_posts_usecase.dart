import 'package:tisocial/features/auth/domain/repositories/firebase_repository.dart';
import '../entities/user_posts_entity.dart';

class GetPostsUsecase {
  final FirebaseRepository repository;

  GetPostsUsecase({required this.repository});
  Stream<List<UserPostEntity>> call(String uid) {
    return repository.getPosts(uid);
  }
}
