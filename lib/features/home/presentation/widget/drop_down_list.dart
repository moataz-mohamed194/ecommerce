import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class DropDownList extends StatelessWidget {
  final String label;
  final List<dynamic>? items;
  final dynamic value;
  final ValueChanged<dynamic?>? change;

  const DropDownList({
    super.key,
    required this.label,
    this.items,
    required this.value,
    required this.change,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          value==null?Container():Padding(
            padding: EdgeInsets.only(left: 18.r, top: 8.r, bottom: 8.r),
            child: Text(
              label.toString(),
              style: TextStyle(
                  fontSize: 15,
                  // color: AppColors.textGreyColor,
                  fontWeight: FontWeight.normal),
            ),
          ),
          DropdownButton2(
            isExpanded: true,
            hint: Row(
              children: [
                Expanded(
                  child: Text(
                    label,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            items: items!
                    .map((item) => DropdownMenuItem<String>(
                          value: item.toString(),
                          child: Text(
                            item.toString(),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ))
                    .toList(),
            value: value,
            onChanged: (value) {
              change!(value);
            },
            buttonStyleData: ButtonStyleData(
              height: 50.h,
              width: 140.w,
              padding: const EdgeInsets.only(left: 25, right: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.r),

              ),
              elevation: 0,
            ),
            iconStyleData: const IconStyleData(
              icon: Icon(
                Icons.arrow_drop_down_rounded,
              ),
              iconSize: 25,
            ),
            dropdownStyleData: DropdownStyleData(
                maxHeight: 200.h,
                padding: null,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 0,
                scrollbarTheme: ScrollbarThemeData(
                  radius: const Radius.circular(40),
                  thickness: MaterialStateProperty.all(6),
                  thumbVisibility: MaterialStateProperty.all(true),
                )),
            menuItemStyleData: const MenuItemStyleData(
              height: 40,
              padding: EdgeInsets.only(left: 14, right: 14),
            ),
          ),

        ],
      ),
    );
  }
}
