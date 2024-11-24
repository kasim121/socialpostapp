import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tisocial/features/auth/domain/entities/user_posts_entity.dart';

class UserPostsModel extends UserPostEntity {
  const UserPostsModel({
    final String? postId,
    final String? postMessage,
    final Timestamp? postTime,
    final String? uid,
  }) : super(
            postId: postId,
            postMessage: postMessage,
            postTime: postTime,
            uid: uid);
  factory UserPostsModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return UserPostsModel(
      postId: documentSnapshot.get('postId'),
      postMessage: documentSnapshot.get('postMessage'),
      postTime: documentSnapshot.get('postTime'),
      uid: documentSnapshot.get('uid'),
    );
  }
  Map<String, dynamic> toDocument() {
    return {
      "postId": uid,
      "postMessage": postMessage,
      "postTime": postTime,
      "uid": uid,
    };
  }
}
