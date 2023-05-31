part of 'sign_up_bloc.dart';

@immutable
abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class SignUpAccountEvent extends SignUpEvent {
  final SignUpData data;

  SignUpAccountEvent({required this.data});

  @override
  List<Object> get props => [data];
}
