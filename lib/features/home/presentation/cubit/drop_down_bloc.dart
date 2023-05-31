import 'package:flutter_bloc/flutter_bloc.dart';


class DropDownBloc extends Cubit<String?> {
  DropDownBloc() : super('');

  String? selectedValue;

  void changeValue(String? choose) {
    selectedValue = choose;
    emit(choose!);
  }

  String? selectedValueCategory;

  void changeValueCategory(String? choose) {
    selectedValueCategory = choose;
    emit(choose!);
  }

  void clearValues(){
    selectedValueCategory=null;
    selectedValue=null;
    emit('');
  }
}
