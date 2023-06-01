import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/injector/injector.dart' as di;
import '../../../../core/injector/injector.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widget/button_widget.dart';
import '../../domain/entities/product.dart';
import '../bloc/product_bloc.dart';
import '../cubit/counter_of_items_of_order_cubit.dart';
import '../widget/display_order.dart';
import '../widget/item_of_order.dart';
import '../widget/row_two_text.dart';

class checkOutCartData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: BlocProvider<AddProductBloc>(
          create: (context) =>
          di.sl<AddProductBloc>()..add(GetProductCartEvent()),
          child: BlocConsumer<AddProductBloc, ProductState>(
            builder: (context, state) {
              if (state is LoadedCartProductAccountState) {
                return Column(
                  children: [
                    Expanded(
                      child:
                      SingleChildScrollView(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: List.generate(
                                state.data.length,
                                    (index) => displayOrder(
                                    price:
                                    double.parse(state.data[index].price!),
                                    name: state.data[index].title!,
                                    id: state.data[index].id!,
                                    image: state.data[index].image!,
                                    count: state.data[index].count!,
                                    context: context))),
                      ),
                    ),
                    Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey.shade300,
                            width: 1,
                          ),
                          borderRadius: const BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
                          color: Colors.white,

                        ),
                        width: MediaQuery.of(context).size.width,
                        child: Column(

                          children: [

                            SizedBox(height: 10.h,),
                            RowTwoText(
                              text: 'Subtotal',
                              data: state.data.fold(0,
                                      (double sum, ProductData product) {
                                    double productSum =
                                        double.parse(product.price ?? '0') *
                                            (product.count ?? 0);
                                    return sum + productSum;
                                  }),
                              total: false,
                              isItTaxes: false,
                            ),

                            RowTwoText(
                              text: 'Tax (10%)',
                              data: state.data.fold(0,
                                      (double sum, ProductData product) {
                                    double productSum =
                                        double.parse(product.price ?? '0') *
                                            (product.count ?? 0);
                                    return sum + productSum;
                                  }),
                              total: false,
                              isItTaxes: true,
                            ),
                            SizedBox(height: 10.h,),
                            Container(height: 1,width: MediaQuery.of(context).size.width-100,color: Colors.grey,),

                            SizedBox(height: 10.h,),
                            RowTwoText(
                              text: 'Total',
                              data: state.data.fold(0,
                                      (double sum, ProductData product) {
                                    double productSum =
                                        double.parse(product.price ?? '0') *
                                            (product.count ?? 0);
                                    return sum + productSum;
                                  }),
                              total: true,
                              isItTaxes: true,
                            ),

                            const SizedBox(
                              height: 30,
                            ),
                            ButtonWidget(
                              text: 'Submit',
                              action: () {},
                              width: double.infinity,
                              backgroundColor: AppColors.primary,
                              textColor: Colors.white,
                              boarderColor: Colors.transparent,
                              marginHeight: 0,
                              marginWidth: 10,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      ),


                  ],
                );
              } else if (state is ErrorProductState) {
                return Text(state.message);
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primary,
                  ),
                );
              }
            },
            listener: (context, state) {
              return;
            },
          )),
    );
  }
}
