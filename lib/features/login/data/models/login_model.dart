import '../../domain/entities/login.dart';

class LoginDataModel extends LoginData {
  LoginDataModel(
      {String? message, String? userName, String? token, String? password})
      : super(
          userName: userName,
          message: message,
          token: token,
          password: password,
        );
  factory LoginDataModel.fromJson(Map<String, dynamic> json) {
    return LoginDataModel(
      userName: json['username'] ?? '',
      message: json['message'] ?? '',
      token: json['token'] ?? '',
      password: json['password'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'username': userName, 'message': message, 'password': password};
  }
}
