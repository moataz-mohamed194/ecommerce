part of 'profile_bloc.dart';

@immutable
abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class LoadingProfileState extends ProfileState {}

class ErrorProfileState extends ProfileState {
  final String message;

  ErrorProfileState({required this.message});

  @override
  List<Object> get props => [message];
}

class MessageProfileAccountState extends ProfileState {
  final ProfileData data;

  MessageProfileAccountState({required this.data});

  @override
  List<Object> get props => [data];
}

