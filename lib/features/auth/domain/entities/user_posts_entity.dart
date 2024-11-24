import 'package:equatable/equatable.dart';

class UserPostEntity extends Equatable {
  final String? postId;
  final String? postName;
  final String? postTime;
  final String? uid;

  const UserPostEntity(
    this.postId,
    this.postName,
    this.postTime,
    this.uid,
  );

  @override
  List<Object?> get props => [postId, postName, postTime, uid];
}
