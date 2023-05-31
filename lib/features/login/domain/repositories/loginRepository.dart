import 'package:dartz/dartz.dart';
import '../../../../core/error/Failures.dart';
import '../../data/models/login_model.dart';
import '../entities/login.dart';

abstract class LoginRepository {
  Future<Either<Failures, LoginDataModel>> loginAccountData(LoginData data);
}
