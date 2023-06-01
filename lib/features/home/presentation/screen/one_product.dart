import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rate/rate.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widget/button_widget.dart';
import '../../../../core/widget/scaffold_message.dart';
import '../../../product/presentation/screen/add_product.dart';
import '../bloc/home_bloc.dart';
import '../../../../core/injector/injector.dart' as di;

class OneProduct extends StatelessWidget {
  final int id;

  const OneProduct({super.key, required this.id});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider<HomeBloc>(
          create: (context) =>
              di.sl<HomeBloc>()..add(GetOneProductEvent(id: id)),
          child: BlocConsumer<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is LoadedOneProductHomeState) {
                return Scaffold(
                    appBar: AppBar(
                      actions: [
                        PopupMenuButton(
                          icon: Icon(CupertinoIcons.ellipsis_vertical),
                            itemBuilder: (context) {
                          return [
                            PopupMenuItem<int>(
                              value: 0,
                              child: Row(
                                children: const [
                                  Icon(
                                    Icons.delete,
                                    color: Colors.black,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("Delete")
                                ],
                              ),
                            ),
                            PopupMenuItem<int>(
                              value: 1,
                              child: Row(
                                children: const [
                                  Icon(
                                    Icons.edit,
                                    color: Colors.black,
                                    size: 30,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("Edit"),
                                ],
                              ),
                            ),
                          ];
                        }, onSelected: (value) {
                          if (value == 0) {
                            BlocProvider.of<HomeBloc>(context)
                                .add(DeleteOneProductEvent(id: id));
                          }
                          else if (value == 1) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddProduct(
                                        isItEdit: true,
                                        image: state.data.image.toString(),
                                        price: state.data.price.toString(),
                                        title: state.data.title.toString(),
                                        id: state.data.id,
                                        description:
                                            state.data.description.toString(),
                                        category:
                                            state.data.category.toString(),
                                      )),
                            );
                          }
                        }),
                      ],
                    ),
                    body: Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: ListView(
                        children: [
                          Image.network(
                            state.data.image.toString(),
                            height: 200.h,
                            fit: BoxFit.fitHeight,
                          ),
                          SizedBox(height: 20.h,),
                          Text(
                            state.data.title.toString(),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 20.h,),
                          Rate(
                            iconSize: 25,
                            color: Colors.yellow.shade300,
                            initialValue: state.data.rating!.rate!.toDouble(),
                            readOnly: true,
                            onChange: (value) => print(value),
                          ),
                          SizedBox(height: 20.h,),
                          Text(
                            "Price:${state.data.price.toString()}\$",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 50.h,),
                          ButtonWidget(
                            text: 'Add to cart',
                            action: () {
                              BlocProvider.of<HomeBloc>(context)
                                  .add(AddProductToCartEvent(data: state.data));
                            },
                            width: double.infinity,
                            backgroundColor: AppColors.primary,
                            textColor: Colors.white,
                            boarderColor: Colors.transparent,
                            marginHeight: 10,
                            marginWidth: 0,
                          ),
                        ],
                      ),
                    ));
              } else if (state is ErrorHomeState) {
                return Scaffold(body: Text(state.message));
              }  else {
                return Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primary,
                    ),
                  ),
                );
              }
            },
            listener: (context, state) {
              if (state is DeleteProductHomeState) {
                WidgetsBinding.instance.addPostFrameCallback((_) => scaffoldMessage(
                    context: context, message: 'Deleted', isItAlert: false));


                Navigator.pop(context);
              } else if (state is ErrorHomeState) {
                WidgetsBinding.instance.addPostFrameCallback((_) => scaffoldMessage(
                    context: context,
                    message: "Can't delete it",
                    isItAlert: true));



                Navigator.pop(context);
              } else if (state is ErrorCartHomeState) {
                WidgetsBinding.instance.addPostFrameCallback((_) => scaffoldMessage(
                    context: context,
                    message: "Order added before",
                    isItAlert: true));

                Navigator.pop(context);
              } else if (state is AddedToCartProductAccountState) {
                WidgetsBinding.instance.addPostFrameCallback((_) => scaffoldMessage(
                    context: context,
                    message: 'Added to cart',
                    isItAlert: false));

                Navigator.pop(context);
              }
              return;
            },
          ),
        ),

    );
  }
}
