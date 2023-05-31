import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/Failures.dart';
import '../../../../core/error/failures_message.dart';
import '../../domain/entities/profile.dart';
import '../../domain/usecases/get_profile_data.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class AddProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileAccountData getProfile;
  AddProfileBloc({required this.getProfile}) : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) async {
      if (event is GetProfileEvent) {
        emit(LoadingProfileState());
        final failureOrDoneMessage = await getProfile(event.id);
        emit(_mapFailureOrPostsToEditStateForGet(failureOrDoneMessage));
      }
    });
  }
}

ProfileState _mapFailureOrPostsToEditStateForGet(
    Either<Failures, ProfileData> either) {
  return either.fold(
        (failure) => ErrorProfileState(message: _mapFailureToMessage(failure)),
        (data) => MessageProfileAccountState(data: data),
  );
}


String _mapFailureToMessage(Failures failure) {
  switch (failure.runtimeType) {
    case OfflineFailures:
      return SERVER_FAILURE_MESSAGE;
    case CheckDataFailures:
      return LOGIN_FAILURE_MESSAGE;
    case OfflineFailures:
      return OFFLINE_FAILURE_MESSAGE;
    default:
      return "Unexpected Error , Please try again later .";
  }
}
