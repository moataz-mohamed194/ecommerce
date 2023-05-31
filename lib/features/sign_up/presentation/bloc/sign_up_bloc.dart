import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/Failures.dart';
import '../../../../core/error/failures_message.dart';
import '../../domain/entities/sign_up_entities.dart';
import '../../domain/usecases/add_sign_up_data.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final SignUpAccountData signUpAccount;

  SignUpBloc({required this.signUpAccount}) : super(SignUpInitial()) {
    on<SignUpEvent>((event, emit) async {
      if (event is SignUpAccountEvent) {
        emit(LoadingSignUpState());
        final failureOrDoneMessage = await signUpAccount(event.data);
        emit(_mapFailureOrPostsToStateForGet(failureOrDoneMessage));
      }
    });
  }
}

SignUpState _mapFailureOrPostsToStateForGet(
    Either<Failures, SignUpData> either) {
  return either.fold(
    (failure) => ErrorSignUpState(message: _mapFailureToMessage(failure)),
    (data) => MessageSignUpAccountState(data: data),
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
