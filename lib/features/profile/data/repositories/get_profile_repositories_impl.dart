import 'package:dartz/dartz.dart';
import '../../../../core/error/Failures.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/profile.dart';
import '../../domain/repositories/get_profile_repository.dart';
import '../datasouces/get_Profile_remote_data_source.dart';
import '../models/profile_model.dart';

class ProfileRepositoriesImpl implements GetProfileRepository {
  final GetProfileRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ProfileRepositoriesImpl(
      {required this.remoteDataSource, required this.networkInfo});


  @override
  Future<Either<Failures, ProfileDataModel>> getProfileData(int id) async {

    if (await networkInfo.isConnected) {
      try {
        final currentAccount =
            await remoteDataSource.getProfileAccount(id);
        return Right(currentAccount);
      } on OfflineException {
        return Left(OfflineFailures());
      } on CheckDataException {
        return Left(CheckDataFailures());
      }
    } else {
      return Left(OfflineFailures());
    }
  }

}
