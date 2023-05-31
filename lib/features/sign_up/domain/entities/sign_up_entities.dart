import 'package:equatable/equatable.dart';

class SignUpData extends Equatable {
  String? message;
  String? token;
  String? userName;
  String? email;
  String? password;

  SignUpData(
      {this.message, this.token, this.userName, this.email, this.password});

  @override
  List<Object?> get props => [message, token, email, userName, password];
}
