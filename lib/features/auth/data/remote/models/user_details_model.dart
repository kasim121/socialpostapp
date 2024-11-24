import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../domain/entities/user_details_entity.dart';

class UserDetailsModel extends UserDetailsEntity {
  const UserDetailsModel({
    String? uid,
    String? name,
    String? email,
    String? password,
    String? status,
  }) : super(
          uid: uid,
          name: name,
          email: email,
          password: password,
          status: status,
        );

  factory UserDetailsModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return UserDetailsModel(
      uid: documentSnapshot.get('uid'),
      name: documentSnapshot.get('name'),
      email: documentSnapshot.get('email'),
      status: documentSnapshot.get('status'),
    );
  }
  Map<String, dynamic> toDocument() {
    return {
      "uid": uid,
      "name": name,
      "email": email,
      "password": password,
      "status": status,
    };
  }
}
