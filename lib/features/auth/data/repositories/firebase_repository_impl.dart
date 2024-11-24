import 'package:tisocial/features/auth/data/remote/datasource/firebase_remote_datasource.dart';
import 'package:tisocial/features/auth/domain/entities/user_details_entity.dart';
import 'package:tisocial/features/auth/domain/entities/user_posts_entity.dart';
import 'package:tisocial/features/auth/domain/repositories/firebase_repository.dart';

class FirebaseRepositoryImpl implements FirebaseRepository {
  final FirebaseRemoteDatasource frirebaseRemoteDatasource;

  FirebaseRepositoryImpl({required this.frirebaseRemoteDatasource});

  @override
  Future<void> addNewPost(UserPostEntity userPostEntity) async =>
      frirebaseRemoteDatasource.addNewPost(userPostEntity);

  @override
  Future<void> deletePost(UserPostEntity userPostEntity) async =>
      frirebaseRemoteDatasource.deletePost(userPostEntity);
  @override
  Future<void> getCreateCurrentUser(
          UserDetailsEntity userDetailsEntity) async =>
      frirebaseRemoteDatasource.getCreateCurrentUser(userDetailsEntity);

  @override
  Future<String> getCurrentUserId() async =>
      frirebaseRemoteDatasource.getCurrentUserId();

  @override
  Stream<List<UserPostEntity>> getPosts(
          String
              uid) => /*If the frirebaseRemoteDatasource.getPosts(uid) already returns a Stream<List<UserPostEntity>>, you don’t need to use async. Simply forward the call as you have done without async:*/
      frirebaseRemoteDatasource.getPosts(uid);

  @override
  Future<bool> isSignIn() async => frirebaseRemoteDatasource.isSignIn();

  @override
  Future<void> signIn(UserDetailsEntity userDetailsEntity) async =>
      frirebaseRemoteDatasource.signIn(userDetailsEntity);

  @override
  Future<void> signOut() async => frirebaseRemoteDatasource.signOut();

  @override
  Future<void> signUp(UserDetailsEntity userDetailsEntity) async =>
      frirebaseRemoteDatasource.signUp(userDetailsEntity);

  @override
  Future<void> updatePost(UserPostEntity userPostEntity) async =>
      frirebaseRemoteDatasource.updatePost(userPostEntity);
}
