import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widget/button_widget.dart';
import '../bloc/home_bloc.dart';
import '../cubit/check_box_cubit.dart';
import '../cubit/drop_down_bloc.dart';
import 'drop_down_list.dart';

bottomSheet({context0, required List categoryList})=>showModalBottomSheet<void>(
  context: context0,
  builder: (BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.white,
      height: 300,
      child: Center(
        child: Column(
          mainAxisAlignment:
          MainAxisAlignment.center,
          children: <Widget>[
            BlocBuilder<CheckBoxCubit, bool>(
                builder: (context, state) {
                  return CheckboxListTile(
                    value: state,
                    controlAffinity:
                    ListTileControlAffinity.leading,
                    onChanged: (bool? value) {
                      context
                          .read<CheckBoxCubit>()
                          .changeCheck();
                    },
                    title: Text("Show as desc"),
                  );
                }),
            Row(
              children: [
                DropdownButtonHideUnderline(
                  child: BlocBuilder<DropDownBloc, String?>(
                      builder: (context, state) {
                        return DropDownList(
                          label: 'Limit',
                          items: List.generate(20, (index) => index + 1),
                          value: context
                              .read<DropDownBloc>()
                              .selectedValue,
                          change: (value) {
                            context
                                .read<DropDownBloc>()
                                .changeValue(
                                value as String);
                          },
                        );
                      }),
                ),
                DropdownButtonHideUnderline(
                  child: BlocBuilder<DropDownBloc, String?>(
                      builder: (context, state) {
                        return DropDownList(
                          label: 'Category',
                          items: categoryList,
                          value: context
                              .read<DropDownBloc>()
                              .selectedValueCategory,
                          change: (value) {
                            context
                                .read<DropDownBloc>()
                                .changeValueCategory(
                                value as String);
                          },
                        );
                      }),
                ),
              ],
            ),

            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Row(

                children: [
                  Expanded(
                    child: ButtonWidget(
                      text: 'Search',
                      action: () {
                        BlocProvider.of<HomeBloc>(context0)
                            .add(GetSearchProductEvent(sort: context
                            .read<CheckBoxCubit>().state, category: context
                            .read<DropDownBloc>().selectedValueCategory,limit:  context
                            .read<DropDownBloc>().selectedValue));
                        Navigator.pop(context0);
                      },
                      width: double.infinity,
                      backgroundColor: AppColors.primary,
                      textColor: Colors.white,
                      boarderColor: Colors.transparent,
                      marginHeight: 10,
                      marginWidth: 0,
                    ),
                  ),
                  SizedBox(width: 10,),

                  Expanded(
                    child: ButtonWidget(
                      text: 'Clear',
                      action: () {
                        BlocProvider.of<CheckBoxCubit>(context0).clearCheck();
                        BlocProvider.of<DropDownBloc>(context0).clearValues();
                        BlocProvider.of<HomeBloc>(context0)
                            .add(GetHomeEvent());
                        Navigator.pop(context0);
                      },
                      width: double.infinity,
                      backgroundColor: Colors.white,
                      textColor: AppColors.primary,
                      boarderColor: AppColors.primary,
                      marginHeight: 10,
                      marginWidth: 0,
                    ),
                  )
                ],
              ),
            )

          ],
        ),
      ),
    );
  },
);