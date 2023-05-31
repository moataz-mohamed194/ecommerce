import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      child: Center(
        child: Column(
          mainAxisAlignment:
          MainAxisAlignment.center,
          children: <Widget>[
            BlocBuilder<CheckBoxCubit, bool>(
                builder: (context, state) {
                  return CheckboxListTile(
                    //checkbox positioned at left
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
                    child: ElevatedButton(
                      child:
                      const Text('Clear'),
                      onPressed: (){


                        BlocProvider.of<CheckBoxCubit>(context0).clearCheck();
                        BlocProvider.of<DropDownBloc>(context0).clearValues();
                        BlocProvider.of<HomeBloc>(context0)
                            .add(GetHomeEvent());
                        Navigator.pop(context0);
                      },
                    ),
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    child: ElevatedButton(
                      child:
                      const Text('Search'),
                      onPressed: (){


                        BlocProvider.of<HomeBloc>(context0)
                            .add(GetSearchProductEvent(sort: context
                            .read<CheckBoxCubit>().state, category: context
                            .read<DropDownBloc>().selectedValueCategory,limit:  context
                            .read<DropDownBloc>().selectedValue));
                        Navigator.pop(context0);
                      },
                    ),
                  ),
                ],
              ),
            )

          ],
        ),
      ),
    );
  },
);