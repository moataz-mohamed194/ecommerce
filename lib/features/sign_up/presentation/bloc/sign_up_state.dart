part of 'sign_up_bloc.dart';

@immutable
abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}

class SignUpInitial extends SignUpState {}

class LoadingSignUpState extends SignUpState {}

class ErrorSignUpState extends SignUpState {
  final String message;

  ErrorSignUpState({required this.message});

  @override
  List<Object> get props => [message];
}

class MessageSignUpAccountState extends SignUpState {
  final SignUpData data;

  MessageSignUpAccountState({required this.data});

  @override
  List<Object> get props => [data];
}
