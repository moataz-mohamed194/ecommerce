import 'package:dartz/dartz.dart';
import '../../../../core/error/Failures.dart';
import '../../data/models/profile_model.dart';
import '../entities/profile.dart';

abstract class GetProfileRepository {
  Future<Either<Failures, ProfileDataModel>> getProfileData(int id);
}
