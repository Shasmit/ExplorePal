import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../entity/profile_entity.dart';
import '../repository/profile_repository.dart';

final profileUseCaseProvider = Provider<ProfileUseCase>(
  (ref) => ProfileUseCase(
    profileRepository: ref.watch(profileRepositoryProvider),
  ),
);

class ProfileUseCase {
  final IProfileRepository profileRepository;

  ProfileUseCase({
    required this.profileRepository,
  });

  Future<Either<Failure, List<ProfileEntity>>> getUserProfile() async {
    return await profileRepository.getUserProfile();
  }

  Future<Either<Failure, String>> uploadProfilePicture(File file) async {
    return await profileRepository.uploadProfilePicture(file);
  }

  Future<Either<Failure, bool>> editProfile(
      String username, String email) async {
    return await profileRepository.editProfile(username, email);
  }
}
