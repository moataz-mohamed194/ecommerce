import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/injector/injector.dart' as di;
import '../../../../core/injector/injector.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widget/button_widget.dart';
import '../bloc/product_bloc.dart';
import '../cubit/counter_of_items_of_order_cubit.dart';
import '../widget/item_of_order.dart';
import 'checkOut_cart_data.dart';

class GetCartData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddProductBloc>(
        create: (context) =>
            di.sl<AddProductBloc>()..add(GetProductCartEvent()),
        child: BlocConsumer<AddProductBloc, ProductState>(
          builder: (context, state) {
            if (state is LoadedCartProductAccountState) {
              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: List.generate(
                              state.data.length,
                              (index) => BlocProvider(
                                  create: (context1) => CounterOfItemsOfOrderCubit(updateCount: sl()),
                                  child:
                                      BlocBuilder<CounterOfItemsOfOrderCubit, int>(
                                          builder: (context1, isChecked) {
                                    return ItemOfOrder(
                                      price: double.parse(state.data[index].price!),
                                      name: state.data[index].title!,
                                      id: state.data[index].id!,
                                      image: state.data[index].image!,
                                      count:BlocProvider.of<CounterOfItemsOfOrderCubit>(context1).isStartChange==true?isChecked: state.data[index].count,//!=isChecked?isChecked:state.data[index].count!,
                                        context: context,
                                        context1: context1
                                    );
                                  })))),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: ButtonWidget(
                      text: 'Checkout',
                      action: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => checkOutCartData(

                              )),
                        );
                      },
                      width: double.infinity,
                      backgroundColor: AppColors.primary,
                      textColor: Colors.white,
                      boarderColor: Colors.transparent,
                      marginHeight: 0,
                      marginWidth: 10,
                    ),
                  ),
                  // SizedBox(
                  //   height: 30,
                  // )
                ],
              );
            } else if (state is ErrorProductState) {
              return Text(state.message);
            } else {
              return CircularProgressIndicator(
                color: AppColors.primary,
              );
            }
          },
          listener: (context, state){

            return;
          },
        ));
    ;
  }
}
