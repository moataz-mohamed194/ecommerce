import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../../../core/api/end_points.dart';
import '../../../../core/error/exception.dart';
import '../../domain/entities/sign_up_entities.dart';
import '../models/sign_up_model.dart';

abstract class SignUpRemoteDataSource {
  Future<SignUpDataModel> signUpAccount(SignUpData data);
}

class SignUpRemoteDataSourceImple extends SignUpRemoteDataSource {
  final http.Client client;

  SignUpRemoteDataSourceImple({required this.client});

  @override
  Future<SignUpDataModel> signUpAccount(SignUpData data) async {
    try {
      final response = await client.post(Uri.parse(EndPoints.signUpUrl),
          headers: {
            "Content-Type": "application/x-www-form-urlencoded"
          },
          body: {
            "username": data.userName,
            "password": data.password,
            'email': data.email
          });
      if (response.statusCode == 200) {
        final SignUpDataModel dataModels =
            SignUpDataModel.fromJson(json.decode(response.body));
        return dataModels;
      } else if (response.statusCode == 401) {
        throw CheckDataException();
      } else {
        throw OfflineException();
      }
    } catch (e) {
      if (e is CheckDataException) {
        throw CheckDataException();
      }
      throw OfflineException();
    }
  }
}
