import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../home/presentation/screen/home_page.dart';
import '../../../product/presentation/screen/get_cart_data.dart';
import 'profile_menu.dart';
import '../bloc/bottom_navigator_cubit.dart';

class BottomNavigator extends StatelessWidget {
  List<Widget> _widgetOptions = <Widget>[
    homePage(),
    GetCartData(),
    ProfileMenu(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigatorCubit, int>(builder: (context, state) {
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('E-commerce'),
          ),
          body: Center(
            child: _widgetOptions.elementAt(state),
          ),
          bottomNavigationBar: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),

            child: BottomNavigationBar(

              backgroundColor: AppColors.bgBottomPrimary.withOpacity(.9),
              // type: BottomNavigationBarType.shifting,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.add_shopping_cart),
                  label: 'Cart ',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile ',
                ),
              ],
              currentIndex: state,
              unselectedItemColor: Colors.white,
              selectedItemColor: AppColors.primary.withOpacity(.6),
              onTap: (index) {
                context.read<BottomNavigatorCubit>().changeIndex(index);
              },
            ),
          ),
        ),
      );
    });
  }
}
