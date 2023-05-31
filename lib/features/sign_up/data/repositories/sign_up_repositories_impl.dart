import 'package:dartz/dartz.dart';
import '../../../../core/error/Failures.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/sign_up_entities.dart';
import '../../domain/repositories/sign_up_repository.dart';
import '../datasouces/sign_up_remote_data_source.dart';
import '../models/sign_up_model.dart';

class signUpRepositoriesImpl implements SignUpRepository {
  final SignUpRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  signUpRepositoriesImpl(
      {required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failures, SignUpDataModel>> signUpAccountData(
      SignUpData data) async {
    final SignUpDataModel signUpDataModel = SignUpDataModel(
        userName: data.userName.toString(),
        password: data.password.toString(),
        email: data.email.toString());
    if (await networkInfo.isConnected) {
      try {
        final currentAccount =
            await remoteDataSource.signUpAccount(signUpDataModel);
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
