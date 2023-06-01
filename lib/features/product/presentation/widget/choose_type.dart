import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../cubit/choose_file_cubit.dart';

chooseType({required context}) => showDialog<String>(
      context: context,
      builder: (BuildContext context) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Choose Way',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: Container(),
                    flex: 1,
                  ),
                  Expanded(
                    flex: 2,
                    child: InkWell(
                      onTap: () async {
                        FilePickerResult? result =
                            await FilePicker.platform.pickFiles(
                          type: FileType.custom,
                          allowedExtensions: ['jpg', 'png'],
                        );
                        if (result != null) {
                          File file = File(result.files.single.path!);
                          BlocProvider.of<ChooseFileCubit>(context).chooseFile(file.path);
                        } else {
                          // User canceled the picker
                        }
                      },
                      child: Image.asset(
                        'assets/icons/gallery.png',
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(),
                    flex: 1,
                  ),
                  Expanded(
                    flex: 2,
                    child: InkWell(
                      onTap: () async {
                        final ImagePicker _picker = ImagePicker();

                        final XFile? pickedFile = await _picker.pickImage(
                          source: ImageSource.camera,
                        );
                          print('pickedFile:${pickedFile!.path}');
                        BlocProvider.of<ChooseFileCubit>(context).camera(pickedFile.path);

                      },
                      child: Image.asset(
                        'assets/icons/camera.png',
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(),
                    flex: 1,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
