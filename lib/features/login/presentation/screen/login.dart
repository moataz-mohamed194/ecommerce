import 'package:ecommerce/features/sign_up/presentation/screen/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/bloc/eyes_cubit.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_images.dart';
import '../../../../core/widget/button_widget.dart';
import '../../../../core/widget/scaffold_message.dart';
import '../../../../core/widget/text_form_with_title_widget.dart';
import '../../../bottom_sheet/presentation/screen/bottom_navigator.dart';
import '../../domain/entities/login.dart';
import '../bloc/login_bloc.dart';
import 'package:flutter/cupertino.dart';
import '../../../../core/injector/injector.dart' as di;

class Login extends StatelessWidget {
  GlobalKey<FormState> signInFormKey = GlobalKey<FormState>();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Log in',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: signInFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(AppImages.homeScreenMainImage),
                textFormFieldWithTextWidget(
                  controller: userNameController,
                  hint: 'Enter Username',
                  validator: (val) {
                    return (val.isEmpty || val == '' || val.length < 3)
                        ? 'must add username'
                        : null;
                  },
                  title: 'Username',
                ),
                const SizedBox(
                  height: 20,
                ),
                BlocBuilder<EyesCubit, bool>(builder: (context, state) {
                  return textFormFieldWithTextWidget(
                    controller: passwordController,
                    obscureText: state,
                    validator: (val) {
                      return val.isEmpty || val == ''
                          ? 'must add password'
                          : null;
                    },
                    rightWidget: IconButton(
                        onPressed: () {
                          context.read<EyesCubit>().changeEyes();
                        },
                        icon: Icon(state == true
                            ? CupertinoIcons.eye
                            : CupertinoIcons.eye_slash)),
                    hint: 'Enter Password',
                    title: 'Password',
                  );
                }),
                const SizedBox(
                  height: 20,
                ),
                BlocConsumer<LoginBloc, LoginState>(builder: (context, state) {
                  if (state is LoadingLoginState) {
                    return CircularProgressIndicator(
                      color: AppColors.primary,
                    );
                  } else {
                    return ButtonWidget(
                      text: 'Login',
                      action: () {
                        final isValid = signInFormKey.currentState!.validate();
                        if (isValid) {
                          BlocProvider.of<LoginBloc>(context).add(
                              LoginAccountEvent(
                                  data: LoginData(
                                      userName: userNameController.text,
                                      password: passwordController.text)));
                        }
                      },
                      width: MediaQuery.of(context).size.width - 40,
                      backgroundColor: AppColors.primary,
                      textColor: Colors.white,
                      boarderColor: Colors.transparent,
                      marginHeight: 15,
                      marginWidth: 0,
                    );
                  }
                }, listener: (context, state) {
                  if (state is MessageLoginAccountState) {
                    scaffoldMessage(
                        context: context, message: 'Welcome', isItAlert: false);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BottomNavigator()),
                    );
                  } else if (state is ErrorLoginState) {
                    scaffoldMessage(
                        context: context,
                        message: state.message,
                        isItAlert: true);
                  }
                  return;
                }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don’t have an account?',
                      style: TextStyle(color: Colors.grey.shade500),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SignUp(),
                        ));
                      },
                      child: Text(
                        ' Sign up',
                        style: TextStyle(color: AppColors.primary),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
