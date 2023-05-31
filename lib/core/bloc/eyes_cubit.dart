import 'package:bloc/bloc.dart';


class EyesCubit extends Cubit<bool> {
  EyesCubit() : super(true);
  void changeEyes(){
    emit(!state);
  }
}
