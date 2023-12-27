import 'package:dartz/dartz.dart';
import 'package:exploree_pal/features/auth/domain/entity/user_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../../data/repository/auth_remote_repository.dart';

final authRepositoryProvider = Provider<IAuthRepository>(
  (ref) {
    return ref.read(authRemoteRepositoryProvider);
  },
);

abstract class IAuthRepository {
  Future<Either<Failure, bool>> registerUser(UserEntity user);
  Future<Either<Failure, bool>> loginUser(String username, String password);
}
