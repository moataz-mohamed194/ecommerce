import 'package:dartz/dartz.dart';
import '../../../../core/error/Failures.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/login.dart';
import '../../domain/repositories/loginRepository.dart';
import '../datasouces/login_remote_data_source.dart';
import '../models/login_model.dart';

class loginRepositoriesImpl implements LoginRepository {
  final LoginRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  loginRepositoriesImpl(
      {required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failures, LoginDataModel>> loginAccountData(
      LoginData data) async {
    final LoginDataModel signUpDataModel = LoginDataModel(
        userName: data.userName.toString(), password: data.password.toString());
    if (await networkInfo.isConnected) {
      try {
        final currentAccount =
            await remoteDataSource.loginAccount(signUpDataModel);
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
