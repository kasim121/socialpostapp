import 'package:tisocial/features/auth/domain/repositories/firebase_repository.dart';

import '../entities/user_details_entity.dart';

class GetCreateCurrentUserUsecase {
  final FirebaseRepository repository;

  GetCreateCurrentUserUsecase({required this.repository});
  Future<void> call(UserDetailsEntity userDetailsEntity) async {
    return repository.getCreateCurrentUser(userDetailsEntity);
  }
}
