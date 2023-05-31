part of 'login_bloc.dart';

@immutable
abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoadingLoginState extends LoginState {}

class ErrorLoginState extends LoginState {
  final String message;

  ErrorLoginState({required this.message});

  @override
  List<Object> get props => [message];
}

class MessageLoginAccountState extends LoginState {
  final LoginData data;

  MessageLoginAccountState({required this.data});

  @override
  List<Object> get props => [data];
}
