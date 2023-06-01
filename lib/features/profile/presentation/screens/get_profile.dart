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
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: BlocProvider<AddProfileBloc>(
                  create: (context) =>
                      di.sl<AddProfileBloc>()..add(GetProfileEvent(id: 1)),
                  child: BlocBuilder<AddProfileBloc, ProfileState>(
                      builder: (context, state) {
                    if (state is MessageProfileAccountState) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                          SizedBox(height: 70,),
                          Row(
                            children: [
                              Expanded(child: Text('Full name', style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),)),
                              Expanded(child: Text("${state.data.names!.firstName} ${state.data.names!.lastName}")),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(child: Text('Email', style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),)),
                              Expanded(child: Text("${state.data.email}")),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(child: Text('User name', style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),)),
                              Expanded(child: Text("${state.data.username}")),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(child: Text('Phone', style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),)),
                              Expanded(child: Text("${state.data.phone}")),
                            ],
                          ),
                        ],
                      );
                    } else if (state is ErrorProfileState) {
                      return Text(state.message);
                    } else {
                      return CircularProgressIndicator(
                        color: AppColors.primary,
                      );
                    }
                  })),
            ),
          )),
    );
  }
}
