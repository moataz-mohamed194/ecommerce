import 'package:equatable/equatable.dart';

class LoginData extends Equatable {
  String? message;
  String? token;
  String? userName;
  String? password;

  LoginData({this.message, this.token, this.userName, this.password});

  @override
  List<Object?> get props => [message, token, userName, password];
}
