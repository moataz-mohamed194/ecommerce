import 'package:dartz/dartz.dart';
import '../../../../core/error/Failures.dart';
import '../../data/models/sign_up_model.dart';
import '../entities/sign_up_entities.dart';

abstract class SignUpRepository {
  Future<Either<Failures, SignUpDataModel>> signUpAccountData(SignUpData data);
}
