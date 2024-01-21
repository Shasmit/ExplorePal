import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../../data/repository/profile_remote_repo_impl.dart';
import '../entity/profile_entity.dart';

final profileRepositoryProvider = Provider<IProfileRepository>(
  (ref) => ref.watch(profileRemoteRepoProvider),
);

abstract class IProfileRepository {
  Future<Either<Failure, List<ProfileEntity>>> getUserProfile();
  Future<Either<Failure, String>> uploadProfilePicture(File file);
  Future<Either<Failure, bool>> editProfile(String username, String email);
}
