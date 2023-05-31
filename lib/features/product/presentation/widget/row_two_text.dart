import 'package:ecommerce/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RowTwoText extends StatelessWidget {
  final String text;
  final double data;
  final double? tax;
  final bool isItTaxes;
  final bool total;

  const RowTwoText(
      {Key? key,
      required this.text,
        required this.total,
        required this.isItTaxes,
        this.tax,
      required this.data})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width-50,
      margin: const EdgeInsets.symmetric(vertical: 5),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            text,
            style: TextStyle(
                color: Colors.black,
                fontSize: 16),
          ),
          Container(
              alignment: Alignment.centerRight,
              child:isItTaxes==false&&total==false? Text(
                "\$ ${data.toStringAsFixed(3)}",
                style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ):isItTaxes==true&&total==false?Text(
                "\$ ${(data*.1).toStringAsFixed(3)}",
                style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ):Text(
                "\$ ${(data+(data*.1)).toStringAsFixed(3)}",
                style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ))
        ],
      ),
    );
  }
}
