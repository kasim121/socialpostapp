import 'package:equatable/equatable.dart';

class UserDetailsEntity extends Equatable {
  final String? uid;
  final String? name;
  final String? email;
  final String? password;
  final String? status;

  const UserDetailsEntity({
    this.uid,
    this.name,
    this.email,
    this.password,
    this.status,
  });

  @override
  List<Object?> get props => [uid, name, email, password, status];
}
