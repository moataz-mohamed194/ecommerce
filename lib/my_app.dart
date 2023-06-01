import 'package:ecommerce/core/bloc/eyes_cubit.dart';
import 'package:ecommerce/features/login/presentation/screen/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/injector/injector.dart' as di;

import 'features/bottom_sheet/presentation/bloc/bottom_navigator_cubit.dart';
import 'features/home/presentation/bloc/home_bloc.dart';
import 'features/home/presentation/cubit/check_box_cubit.dart';
import 'features/home/presentation/cubit/drop_down_bloc.dart';
import 'features/login/presentation/bloc/login_bloc.dart';
import 'features/product/presentation/bloc/product_bloc.dart';
import 'features/product/presentation/cubit/choose_file_cubit.dart';
import 'features/profile/presentation/bloc/profile_bloc.dart';
import 'features/sign_up/presentation/bloc/sign_up_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [

        BlocProvider(create: (_) => di.sl<ChooseFileCubit>()),
        BlocProvider(create: (_) => di.sl<HomeBloc>()),
        BlocProvider(create: (_) => di.sl<AddProfileBloc>()),
        BlocProvider(create: (_) => di.sl<AddProductBloc>()),
        BlocProvider(create: (_) => di.sl<BottomNavigatorCubit>()),
        BlocProvider(create: (_) => di.sl<LoginBloc>()),
        BlocProvider(create: (_) => di.sl<SignUpBloc>()),
        BlocProvider(create: (_) => di.sl<EyesCubit>()),
        BlocProvider(create: (_) => di.sl<CheckBoxCubit>()),
        BlocProvider(create: (_) => di.sl<DropDownBloc>()),

      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: ScreenUtilInit(designSize: const Size(1000, 690),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, widget) =>  Login()),
      ),
    );
  }
}

