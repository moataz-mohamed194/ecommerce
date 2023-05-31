import 'package:dartz/dartz.dart';

import '../../../../core/error/Failures.dart';
import '../../data/models/profile_model.dart';
import '../entities/profile.dart';
import '../repositories/get_profile_repository.dart';

class GetProfileAccountData {
  final GetProfileRepository repository;

  GetProfileAccountData(this.repository);

  Future<Either<Failures, ProfileDataModel>> call(int id) async {
    return await repository.getProfileData(id);
  }
}
