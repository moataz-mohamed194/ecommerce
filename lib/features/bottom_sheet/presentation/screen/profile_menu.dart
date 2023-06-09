import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../login/presentation/screen/login.dart';
import '../../../product/presentation/screen/add_product.dart';
import '../../../profile/presentation/screens/get_profile.dart';
import '../../../profile/presentation/widget/profile_item.dart';
import '../bloc/bottom_navigator_cubit.dart';

class ProfileMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          margin: EdgeInsets.all(20),
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            image: DecorationImage(
                image: AssetImage('assets/images/person.jpeg'),
                fit: BoxFit.contain),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        profileItem(
            context: context,
            title: 'Profile',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GetProfile()),
              );
            }),
        profileItem(
            title: 'Add New Product',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddProduct()),
              );
            },
            context: context),
        profileItem(
            title: 'Logout',
            onTap: () async {
              final SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setBool('login', false);
              context.read<BottomNavigatorCubit>().restart();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Login()),
              );
            },
            context: context),
      ],
    );
  }
}
