import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/Failures.dart';
import '../../../../core/error/failures_message.dart';
import '../../domain/entities/login.dart';
import '../../domain/usecases/add_login_data.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginAccountData loginAccount;

  LoginBloc({required this.loginAccount}) : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      if (event is LoginAccountEvent) {
        emit(LoadingLoginState());
        final failureOrDoneMessage = await loginAccount(event.data);
        emit(_mapFailureOrPostsToStateForGet(failureOrDoneMessage));
      }
    });
  }
}

LoginState _mapFailureOrPostsToStateForGet(Either<Failures, LoginData> either) {
  return either.fold(
    (failure) => ErrorLoginState(message: _mapFailureToMessage(failure)),
    (data) => MessageLoginAccountState(data: data),
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
