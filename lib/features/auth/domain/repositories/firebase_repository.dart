import 'package:tisocial/features/auth/domain/entities/user_details_entity.dart';
import 'package:tisocial/features/auth/domain/entities/user_posts_entity.dart';

abstract class FirebaseRepository {
  Future<bool> isSignIn();
  Future<void> signIn(UserDetailsEntity userDetailsEntity);
  Future<void> signUp(UserDetailsEntity userDetailsEntity);
  Future<void> isSignOut();
  Future<String> getCurrentUserId();
  Future<void> getCreateCurrentUser(UserDetailsEntity userDetailsEntity);
  Future<void> addPost(UserPostEntity userDetailsEntity);
  Future<void> updatePost(UserPostEntity userDetailsEntity);
  Future<void> deletePost(UserPostEntity userDetailsEntity);
  Stream<List<UserPostEntity>> getPosts(String uid);
}
