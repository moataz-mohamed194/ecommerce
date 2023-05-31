import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rate/rate.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widget/button_widget.dart';
import '../screen/one_product.dart';

class CardOfProduct extends StatelessWidget {
  final String price;
  final String image;
  final String name;
  final String category;
  final num rate;
  final int id;

  const CardOfProduct(
      {super.key,
      required this.id,
      required this.price,
      required this.image,
      required this.name,
      required this.category,
      required this.rate});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => OneProduct(
                id: id,
              )),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20)),
            border: Border.all(
              color: Colors.grey.shade100,
              width: 1,
            )),
        // width: MediaQuery.of(context).size.width/3,
        // height: 300.h,
        child: Column(
          children: [
            Image.network(
              image,
              height: 120.h,
              fit: BoxFit.fitWidth,
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              name,
              softWrap: true,
              maxLines: 1,
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              category,
              softWrap: true,
              maxLines: 1,
            ),
            SizedBox(
              height: 5.h,
            ),
            Rate(
              iconSize: 25,
              color: Colors.yellow.shade300,
              initialValue: rate.toDouble(),
              readOnly: true,
              onChange: (value) => print(value),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Price'),
                Text(
                  "$price\$",
                  softWrap: true,
                  maxLines: 1,
                ),
              ],
            ),
            ButtonWidget(
              text: 'Details',
              action: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => OneProduct(
                            id: id,
                          )),
                );
              },
              width: double.infinity,
              backgroundColor: AppColors.primary,
              textColor: Colors.white,
              boarderColor: Colors.transparent,
              marginHeight: 10,
              marginWidth: 0,
            )
          ],
        ),
      ),
    );
  }
}
