import '../../../domain/entities/user_details_entity.dart';
import '../../../domain/entities/user_posts_entity.dart';

abstract class FirebaseRemoteDatasource {
  Future<bool> isSignIn();
  Future<void> signIn(UserDetailsEntity userDetailsEntity);
  Future<void> signUp(UserDetailsEntity userDetailsEntity);
  Future<void> signOut();
  Future<String> getCurrentUserId();
  Future<void> getCreateCurrentUser(UserDetailsEntity userDetailsEntity);
  Future<void> addNewPost(UserPostEntity userPostEntity);
  Future<void> updatePost(UserPostEntity userPostEntity);
  Future<void> deletePost(UserPostEntity userPostEntity);
  Stream<List<UserPostEntity>> getPosts(String uid);
}
