import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widget/button_widget.dart';
import '../../../../core/widget/scaffold_message.dart';
import '../../../../core/widget/text_form_with_title_widget.dart';
import '../../domain/entities/product.dart';
import '../bloc/product_bloc.dart';

class AddProduct extends StatelessWidget {
  GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController desController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  File? file;
  bool? isItEdit;
  String? title;
  String? price;
  String? description;
  String? image;
  String? category;
  AddProduct(
      {this.title, this.price, this.description, this.category, this.isItEdit, this.image});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Add Product',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: signUpFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                textFormFieldWithTextWidget(
                  controller: isItEdit == false ? titleController : null,
                  hint: 'Enter title',
                  oldData: title,
                  validator: (val) {
                    if (val.isEmpty || val == '') {
                      return 'must add title';
                    } else {
                      title = val;
                      return null;
                    }
                  },
                  title: 'Title',
                ),
                const SizedBox(
                  height: 20,
                ),
                textFormFieldWithTextWidget(
                  controller: isItEdit == false ? desController : null,
                  hint: 'Enter description',
                  oldData: description,
                  validator: (val) {
                    if(val.isEmpty || val == '' || val.length < 3){
                      return 'must add description';
                    }else{
                      description = val;
                      return null;
                    }
                  },
                  title: 'Description',
                ),
                const SizedBox(
                  height: 20,
                ),
                textFormFieldWithTextWidget(
                  oldData: category,
                  controller: isItEdit == false ? categoryController : null,
                  validator: (val) {
                    if(val.isEmpty || val == ''){
                      return 'must add category';
                    }else{
                      category = val;
                      return null;
                    }
                  },
                  hint: 'Enter category',
                  title: 'category',
                ),

                const SizedBox(
                  height: 20,
                ),

                textFormFieldWithTextWidget(
                  oldData: price,
                  controller: isItEdit == false ? priceController : null,
                  keyboardType: TextInputType.number,
                  validator: (val) {
                    if (val.isEmpty || val == '') {
                      return 'must add price';
                    } else {
                      price = val;
                      return null;
                    }
                  },
                  hint: 'Enter price',
                  title: 'Price',
                ),
                const SizedBox(
                  height: 20,
                ),
                ButtonWidget(
                        text: 'Choose file',
                        action: () async {
                          FilePickerResult? result =
                              await FilePicker.platform.pickFiles(
                            type: FileType.custom,
                            allowedExtensions: ['jpg', 'png'],
                          );

                          if (result != null) {
                            file = File(result.files.single.path!);
                            image = file!.path;
                          } else {
                            // User canceled the picker
                          }
                        },
                        width: MediaQuery.of(context).size.width - 40,
                        backgroundColor: Colors.white,
                        textColor: AppColors.primary,
                        boarderColor: Colors.grey.shade500,
                        marginHeight: 15,
                        marginWidth: 0,
                      ),
                // ButtonWidget(
                //   text: 'Take pic',
                //   action: () async{
                //     FilePickerResult? result = await FilePicker.platform.pickFiles(
                //       type: FileType.custom,
                //       allowedExtensions: ['jpg', 'png'],
                //     );
                //
                //     if (result != null) {
                //       File file = File(result.files.single.path!);
                //       print(file.path);
                //     } else {
                //       // User canceled the picker
                //     }
                //   },
                //   width: MediaQuery.of(context).size.width - 40,
                //   backgroundColor: Colors.white,
                //   textColor: AppColors.primary,
                //   boarderColor: Colors.grey.shade500,
                //   marginHeight: 15,
                //   marginWidth: 0,
                // ),
                const SizedBox(
                  height: 20,
                ),
                BlocConsumer<AddProductBloc, ProductState>(
                    builder: (context, state) {
                  if (state is LoadingProductState) {
                    return CircularProgressIndicator(
                      color: AppColors.primary,
                    );
                  } else {
                    return ButtonWidget(
                      text: isItEdit == true ? 'Edit' : 'Add',
                      action: () async {
                        final isValid = signUpFormKey.currentState!.validate();
                        if (isItEdit == true) {
                          BlocProvider.of<AddProductBloc>(context).add(
                              EditProductEvent(
                                  data: ProductData(
                                      title: title,
                                      description: description,
                                      price: price,
                                      image: image,
                                      category: category)));
                        } else {
                          if (file == null) {
                            scaffoldMessage(
                                context: context,
                                message: 'add file',
                                isItAlert: true);
                          }
                          else if (isValid) {
                            BlocProvider.of<AddProductBloc>(context).add(
                                AddProductEvent(
                                    data: ProductData(
                                        title: titleController.text,
                                        description: desController.text,
                                        price: priceController.text.toString(),
                                        image: file!.path,
                                        category: categoryController.text)));
                          }
                        }
                      },
                      width: MediaQuery.of(context).size.width - 40,
                      backgroundColor: AppColors.primary,
                      textColor: Colors.white,
                      boarderColor: Colors.transparent,
                      marginHeight: 15,
                      marginWidth: 0,
                    );
                  }
                }, listener: (context, state) {
                  if (state is MessageProductAccountState) {
                    scaffoldMessage(
                        context: context, message: 'Added', isItAlert: false);
                    Navigator.pop(context);
                  } else if (state is ErrorProductState) {
                    scaffoldMessage(
                        context: context,
                        message: state.message,
                        isItAlert: true);
                  }else if (state is MessageEditProductAccountState) {
                    scaffoldMessage(
                        context: context, message: 'Edited', isItAlert: false);
                    Navigator.pop(context);
                    Navigator.pop(context);
                  }
                  return;
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
