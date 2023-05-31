import 'package:dartz/dartz.dart';

import '../../../../core/error/Failures.dart';
import '../../data/models/sign_up_model.dart';
import '../entities/sign_up_entities.dart';
import '../repositories/sign_up_repository.dart';

class SignUpAccountData {
  final SignUpRepository repository;

  SignUpAccountData(this.repository);

  Future<Either<Failures, SignUpDataModel>> call(SignUpData data) async {
    return await repository.signUpAccountData(data);
  }
}
