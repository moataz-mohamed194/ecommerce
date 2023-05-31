import 'package:flutter/material.dart';

profileItem(
        {required String title,
        required GestureTapCallback? onTap,
        required context}) =>
    Container(
      margin: EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        children: [
          InkWell(
            onTap: onTap,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: TextStyle(fontSize: 16),
                    ),
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),

                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          // SizedBox(
          //   height: 20,
          // ),
          Container(
            height: 1,
            width: MediaQuery.of(context).size.width,
            color: Colors.grey.shade300,
          ),

        ],
      ),
    );
