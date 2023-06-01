import 'package:flutter/material.dart';

textFormFieldWithTextWidget({
  TextEditingController? controller,
  required String hint,
  String? title,
  Widget? leftWidget,
  FormFieldValidator? validator,
  double? width,
  Widget? rightWidget,
  TextInputType? keyboardType,
  EdgeInsetsGeometry? contentPadding,
  bool? obscureText,
  String? oldData,
  int? maxLines
}) =>
    SizedBox(
      width: width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title==null?Container():Text(title, style: TextStyle(color: Colors.grey.shade500),),
          const SizedBox(height: 10,),
          TextFormField(
              controller: controller,

              keyboardType: keyboardType ?? TextInputType.multiline,
              maxLines: maxLines??1,
initialValue: oldData,
              validator: (val) => validator!(val),
              decoration: InputDecoration(
                  contentPadding: contentPadding,
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                        width: 1, color: Colors.grey.shade500),
                  ),
                  fillColor: Colors.white,
                  hintText: hint,
                  suffixIcon: rightWidget,
                  prefixIcon: leftWidget,
                  hintStyle: const TextStyle(color: Colors.grey, fontSize: 14)),
              obscureText: obscureText??false),
        ],
      ),
    );
