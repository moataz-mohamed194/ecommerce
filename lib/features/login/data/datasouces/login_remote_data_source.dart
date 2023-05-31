import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../../../core/api/end_points.dart';
import '../../../../core/error/exception.dart';
import '../../domain/entities/login.dart';
import '../models/login_model.dart';

abstract class LoginRemoteDataSource {
  Future<LoginDataModel> loginAccount(LoginData data);
}

class LoginRemoteDataSourceImple extends LoginRemoteDataSource {
  final http.Client client;

  LoginRemoteDataSourceImple({required this.client});

  @override
  Future<LoginDataModel> loginAccount(LoginData data) async {
    try {
      final response = await client.post(Uri.parse(EndPoints.signInUrl),
          headers: {"Content-Type": "application/x-www-form-urlencoded"},
          body: {"username": data.userName, "password": data.password});
      if (response.statusCode == 200) {
        final LoginDataModel dataModels =
            LoginDataModel.fromJson(json.decode(response.body));
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
