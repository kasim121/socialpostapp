import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UserPostEntity extends Equatable {
  final String? postId;
  final String? postMessage;
  final Timestamp? postTime;
  final String? uid;

  const UserPostEntity({
    this.postId,
    this.postMessage,
    this.postTime,
    this.uid,
  });

  @override
  List<Object?> get props => [postId, postMessage, postTime, uid];
}
