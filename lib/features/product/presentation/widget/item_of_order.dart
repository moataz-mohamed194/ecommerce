import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_colors.dart';
import '../bloc/product_bloc.dart';
import '../cubit/counter_of_items_of_order_cubit.dart';

ItemOfOrder(
    {required BuildContext context,
required BuildContext context1,
    required double price,
    required int count,
    required String image,
    required int id,
    required String name}) {
  return Column(
    children: [
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 2.0, color: Colors.grey.shade200),
          borderRadius: BorderRadius.circular(25),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.shade500,
                blurRadius: 1.0,
                offset: Offset(0.0, 0.75))
          ],
        ),
        // width: MediaQuery.of(context).size.width,

        margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                image,
                height: 250.w,
                width: 200.w,
                fit: BoxFit.fill,
              ),
            ),
            // SizedBox(
            //   width: 5.w,
            // ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Text(name,
                              maxLines: 1, overflow: TextOverflow.ellipsis),
                        ),
                        Expanded(
                            flex: 1,
                            child: TextButton(
                                onPressed: () {
                                  // context
                                  //     .read<AddProductBloc>()
                                  //     .deleteProduct(id);
                                  BlocProvider.of<AddProductBloc>(context).add(DeleteProductCartEvent(id:id));//.deleteProduct(id);

                                },
                                child: Image.asset('assets/icons/delete2.png')))
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 130,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '\$ ${(price * count).toStringAsFixed(1)}',
                            style: TextStyle(
                                color: AppColors.primary, fontSize: 17),
                          ),
                          Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              decoration: const BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(3.0),
                                ),
                              ),
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      context1
                                          .read<CounterOfItemsOfOrderCubit>()
                                          .decrease(count, id);
                                    },
                                    child: const Icon(
                                      CupertinoIcons.minus,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Text(
                                    '$count',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      context1
                                          .read<CounterOfItemsOfOrderCubit>()
                                          .increase(count, id);
                                    },
                                    child: const Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ],
  );
}
// }
