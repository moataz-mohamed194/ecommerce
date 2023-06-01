import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/injector/injector.dart' as di;
import '../../../../core/utils/app_colors.dart';
import '../bloc/profile_bloc.dart';

class GetProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
          child: Container(
        // alignment: Alignment.center,
        // margin: const EdgeInsets.symmetric(horizontal: 20),
        child: BlocProvider<AddProfileBloc>(
            create: (context) =>
                di.sl<AddProfileBloc>()..add(GetProfileEvent(id: 1)),
            child: BlocBuilder<AddProfileBloc, ProfileState>(
                builder: (context, state) {
              if (state is MessageProfileAccountState) {
                return Container(
                  // width: MediaQuery.of(context).size.width,

                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,

                        child: Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.all(20),
                          width: 100,
                          height: 100,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: AssetImage('assets/images/person.jpeg'),
                                fit: BoxFit.contain),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 70,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Full name',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10),

                            child: Text(
                              "${state.data.names!.firstName} ${state.data.names!.lastName}",
                              style: TextStyle(color: Colors.grey.shade500),
                            ),
                          ),
                          const Text(
                            'Email',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Text(
                              "${state.data.email} ",
                              style: TextStyle(color: Colors.grey.shade500),
                            ),
                          ),
                          const Text(
                            'User name',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10),

                            child: Text(
                              "${state.data.username}",
                              style: TextStyle(color: Colors.grey.shade500),
                            ),
                          ),
                          const Text(
                            'Phone',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Text(
                              "${state.data.phone}",
                              style: TextStyle(color: Colors.grey.shade500),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              } else if (state is ErrorProfileState) {
                return Text(state.message);
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primary,
                  ),
                );
              }
            })),
      )),
    );
  }
}
