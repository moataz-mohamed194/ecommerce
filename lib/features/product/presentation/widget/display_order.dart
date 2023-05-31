import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_colors.dart';
import '../bloc/product_bloc.dart';
import '../cubit/counter_of_items_of_order_cubit.dart';

displayOrder(
    {required BuildContext context,
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
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, maxLines: 1, overflow: TextOverflow.ellipsis),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Count: $count',
                      style: const TextStyle(color: Colors.black, fontSize: 15),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 130,
                      child: Text(
                        '\$ ${(price * count).toStringAsFixed(1)}',
                        style:
                            TextStyle(color: AppColors.primary, fontSize: 17),
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
