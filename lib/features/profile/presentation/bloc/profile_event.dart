part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class GetProfileEvent extends ProfileEvent {
  final int id;

  GetProfileEvent({required this.id});

  @override
  List<Object> get props => [id];
}