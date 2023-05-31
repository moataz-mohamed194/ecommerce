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
  // Scaffold(
  // appBar: AppBar(
  //
  // actions: [
  // IconButton(
  // onPressed: () {
  // BlocProvider.of<HomeBloc>(context)
  //     .add(DeleteOneProductEvent(id: id));
  // },
  // icon: Icon(
  // Icons.delete,
  // color: Colors.black,
  // size: 30,
  // )),
  // ],
  // ),
  // body: ),
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: BlocProvider<HomeBloc>(
            create: (context) =>
                di.sl<HomeBloc>()..add(GetOneProductEvent(id: id)),
            child: BlocConsumer<HomeBloc, HomeState>(
              builder: (context, state) {

                if (state is LoadedOneProductHomeState) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: ListView(
                      children: [
                        Image.network(
                          state.data.image.toString(),
                          height: 400,
                          fit: BoxFit.fill,
                        ),
                        Text(
                          state.data.title.toString(),
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Rate(
                          iconSize: 25,
                          color: Colors.yellow.shade300,
                          initialValue: state.data.rating!.rate!.toDouble(),
                          readOnly: true,
                          onChange: (value) => print(value),
                        ),
                        Text(
                          "Price:${state.data.price.toString()}\$",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
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
                        Row(
                          children: [
                            Expanded(
                              child: IconButton(
                                  onPressed: () {
                                    BlocProvider.of<HomeBloc>(context)
                                        .add(DeleteOneProductEvent(id: id));
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.black,
                                    size: 30,
                                  )),
                            ),
                            Expanded(
                              child: IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AddProduct(
                                                isItEdit: true,
                                                image:
                                                    state.data.image.toString(),
                                                price:
                                                    state.data.price.toString(),
                                                title:
                                                    state.data.title.toString(),
                                                description: state
                                                    .data.description
                                                    .toString(),
                                                category: state.data.category
                                                    .toString(),
                                              )),
                                    );
                                  },
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.black,
                                    size: 30,
                                  )),
                            )
                          ],
                        )
                      ],
                    ),
                  );
                }
                else if (state is ErrorHomeState) {
                  return Text(state.message);
                } else if (state is DeleteProductHomeState) {
                  scaffoldMessage(
                      context: context, message: 'Deleted', isItAlert: false);
                  Navigator.pop(context);
                  return Container();
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primary,
                    ),
                  );
                }
              },
              listener: (context, state) {
                if (state is DeleteProductHomeState) {
                  scaffoldMessage(
                      context: context, message: 'Deleted', isItAlert: false);
                  Navigator.pop(context);
                } else if (state is ErrorHomeState) {
                  scaffoldMessage(
                      context: context,
                      message: "Can't delete it",
                      isItAlert: true);
                  Navigator.pop(context);

                }else if (state is ErrorCartHomeState) {
                  scaffoldMessage(
                      context: context,
                      message: "Order added before",
                      isItAlert: true);
                  Navigator.pop(context);

                }

                else if(state is AddedToCartProductAccountState){
                  scaffoldMessage(
                      context: context, message: 'Added to cart', isItAlert: false);
                  Navigator.pop(context);
                }
                return;
              },
            )),
      ),
    );
  }
}
