import 'package:flutter_bloc/flutter_bloc.dart';



class ChooseFileCubit extends Cubit<String?> {
  ChooseFileCubit() : super(null);
  String? resultGallery ;
  Future<void> chooseFile(String fileData) async {
    resultGallery = fileData;
    emit(fileData);
  }

  String? resultCamera ;
  Future<void> camera(String cameraData) async {
    resultCamera = cameraData;
    emit(cameraData);
  }
  restart(){
    emit(null);
  }
}
