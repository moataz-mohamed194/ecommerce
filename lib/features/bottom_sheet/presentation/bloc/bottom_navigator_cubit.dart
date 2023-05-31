import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

class BottomNavigatorCubit extends Cubit<int> {
  BottomNavigatorCubit() : super(0);
  void changeIndex(int index) {
    emit(index);
  }
}
