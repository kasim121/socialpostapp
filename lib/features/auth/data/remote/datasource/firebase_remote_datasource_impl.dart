import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tisocial/features/auth/data/remote/datasource/firebase_remote_datasource.dart';
import 'package:tisocial/features/auth/data/remote/models/user_posts_model.dart';

import 'package:tisocial/features/auth/domain/entities/user_details_entity.dart';
import 'package:tisocial/features/auth/domain/entities/user_posts_entity.dart';

import '../models/user_details_model.dart';

class FirebaseRemoteDatasourceImpl implements FirebaseRemoteDatasource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  FirebaseRemoteDatasourceImpl({required this.auth, required this.firestore});
  @override
  Future<void> addNewPost(UserPostEntity userPostEntity) async {
    final postCollectionRef = firestore
        .collection("users")
        .doc(userPostEntity.uid)
        .collection("posts");
    final postId = postCollectionRef.doc().id;
    postCollectionRef.doc(postId).get().then((post) {
      final newUserPost = UserPostsModel(
              uid: userPostEntity.uid,
              postId: postId,
              postMessage: userPostEntity.postMessage,
              postTime: userPostEntity.postTime)
          .toDocument();
      if (!post.exists) {
        postCollectionRef.doc(postId).set(newUserPost);
      }
      return;
    });
  }

  @override
  Future<void> deletePost(UserPostEntity userPostEntity) async {
    final postCollectionRef = firestore
        .collection("users")
        .doc(userPostEntity.uid)
        .collection("posts");

    postCollectionRef.doc(userPostEntity.postId).get().then((post) {
      if (post.exists) {
        postCollectionRef.doc(userPostEntity.postId).delete();
      }
      return;
    });
  }

  @override
  Future<void> getCreateCurrentUser(UserDetailsEntity userDetailsEntity) async {
    final userPostCollectionRef = firestore.collection("users");
    final uid = await getCurrentUserId();
    userPostCollectionRef.doc(uid).get().then((userDetails) async {
      final newUser = UserDetailsModel(
        uid: uid,
        name: userDetailsEntity.name,
        email: userDetailsEntity.email,
        status: userDetailsEntity.status,
      ).toDocument();
      if (!userDetails.exists) {
        userPostCollectionRef.doc(uid).set(newUser);
      }
      return;
    });
  }

  @override
  Future<String> getCurrentUserId() async => auth.currentUser!.uid;

  @override
  Stream<List<UserPostEntity>> getPosts(String uid) {
    final postCollectionRef =
        firestore.collection("users").doc(uid).collection("posts");
    return postCollectionRef.snapshots().map((querySnapshot) {
      return querySnapshot.docs
          .map((documentSnapshot) =>
              UserPostsModel.fromSnapshot(documentSnapshot))
          .toList();
    });
  }

  @override
  Future<bool> isSignIn() async => auth.currentUser?.uid != null;

  @override
  Future<void> signIn(UserDetailsEntity userDetailsEntity) async =>
      auth.signInWithEmailAndPassword(
          email: userDetailsEntity.email!,
          password: userDetailsEntity.password!);

  @override
  Future<void> signOut() async => auth.signOut();

  @override
  Future<void> signUp(UserDetailsEntity userDetailsEntity) async =>
      auth.createUserWithEmailAndPassword(
          email: userDetailsEntity.email!,
          password: userDetailsEntity.password!);

  @override
  Future<void> updatePost(UserPostEntity userPostEntity) async {
    Map<String, dynamic> postMap = Map();
    final postCollectionRef = firestore
        .collection("users")
        .doc(userPostEntity.uid)
        .collection("posts");
    if (userPostEntity.postMessage != null) {
      postMap['postMessage'] = userPostEntity.postMessage;
    }

    if (userPostEntity.postTime != null) {
      postMap['postTime'] = userPostEntity.postTime;
    }

    postCollectionRef.doc(userPostEntity.postId).update(postMap);
  }
}
