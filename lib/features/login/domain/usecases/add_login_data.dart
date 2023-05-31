import 'package:dartz/dartz.dart';

import '../../../../core/error/Failures.dart';
import '../../data/models/login_model.dart';
import '../entities/login.dart';
import '../repositories/loginRepository.dart';

class LoginAccountData {
  final LoginRepository repository;

  LoginAccountData(this.repository);

  Future<Either<Failures, LoginDataModel>> call(LoginData data) async {
    return await repository.loginAccountData(data);
  }
}
