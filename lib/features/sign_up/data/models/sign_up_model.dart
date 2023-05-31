import '../../domain/entities/sign_up_entities.dart';

class SignUpDataModel extends SignUpData {
  SignUpDataModel(
      {String? message,
      String? userName,
      String? email,
      String? token,
      String? password})
      : super(
          userName: userName,
          message: message,
          token: token,
          email: email,
          password: password,
        );
  factory SignUpDataModel.fromJson(Map<String, dynamic> json) {
    return SignUpDataModel(
      userName: json['username'] ?? '',
      message: json['message'] ?? '',
      email: json['email'] ?? '',
      token: json['token'] ?? '',
      password: json['password'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': userName,
      'message': message,
      'password': password,
      'email': email
    };
  }
}
