part of 'login_bloc.dart';

@immutable
abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginAccountEvent extends LoginEvent {
  final LoginData data;

  LoginAccountEvent({required this.data});

  @override
  List<Object> get props => [data];
}
