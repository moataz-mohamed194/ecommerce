import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../../../core/api/end_points.dart';
import '../../../../core/error/exception.dart';
import '../../domain/entities/profile.dart';
import '../models/profile_model.dart';

abstract class GetProfileRemoteDataSource {
  Future<ProfileDataModel> getProfileAccount(int id);
}

class GetProfileRemoteDataSourceImple extends GetProfileRemoteDataSource {
  final http.Client client;

  GetProfileRemoteDataSourceImple({required this.client});

  @override
  Future<ProfileDataModel> getProfileAccount(int id) async {
    try {
      final response =
          await client.get(Uri.parse(EndPoints.getProfileUrl(id)), headers: {
        'Accept': 'application/json',
      }, );
      if (response.statusCode == 200) {
        final ProfileDataModel dataModels =
        ProfileDataModel.fromJson(json.decode(response.body));
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
