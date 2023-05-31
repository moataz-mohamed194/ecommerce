import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rate/rate.dart';
import '../../../../core/injector/injector.dart' as di;
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widget/button_widget.dart';
import '../../../../core/widget/scaffold_message.dart';
import '../../../../core/widget/text_form_with_title_widget.dart';
import '../bloc/home_bloc.dart';
import '../cubit/check_box_cubit.dart';
import '../cubit/drop_down_bloc.dart';
import '../widget/bootom_sheet.dart';
import '../widget/card_of_product.dart';
import '../widget/drop_down_list.dart';

class homePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

return BlocProvider<HomeBloc>(
    create: (context) => di.sl<HomeBloc>()..add(GetHomeEvent()),
    child: BlocConsumer<HomeBloc, HomeState>(
      builder: (context, stateHome) {
        if (stateHome is LoadedHomeState) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            // height: MediaQuery.of(context).,

            child: ListView(
              children: [
                textFormFieldWithTextWidget(
                    hint: 'Search',
                    rightWidget: IconButton(
                        onPressed: () {
                          bottomSheet(
                              context0: context,
                              categoryList: stateHome.dataCategory);
                        },
                        icon: Icon(Icons.filter_list_outlined))
                  // title: 'Username',
                ),
                SizedBox(height: 30,),

                GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    physics: ScrollPhysics(),
                    crossAxisSpacing: MediaQuery.of(context).orientation == Orientation.portrait ?10:5,
                    mainAxisSpacing: MediaQuery.of(context).orientation == Orientation.portrait ?15:5,
                    childAspectRatio: MediaQuery.of(context).orientation == Orientation.portrait ? .55:1.2,
                    children: List.generate(
                        stateHome.data.length,
                            (index) => CardOfProduct(
                          rate: stateHome.data[index].rating!.rate!,
                          category: stateHome.data[index].category
                              .toString(),
                          price:
                          stateHome.data[index].price.toString(),
                          image: stateHome.data[index].image ?? '',
                          name:
                          stateHome.data[index].title.toString(),
                          id: stateHome.data[index].id!,
                        ))),
              ],
            ),
          );
        } else if (stateHome is LoadedHomeSearchState) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              children: [
                textFormFieldWithTextWidget(
                hint: 'Search',
                rightWidget: IconButton(
                    onPressed: () {
                      bottomSheet(
                          context0: context,
                          categoryList: stateHome.dataCategory);
                    },
                    icon: Icon(Icons.filter_list_outlined))
            ),
                SizedBox(height: 30,),
                GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    physics: ScrollPhysics(),
                    crossAxisSpacing: MediaQuery.of(context).orientation == Orientation.portrait ?10:5,
                    mainAxisSpacing: MediaQuery.of(context).orientation == Orientation.portrait ?15:5,
                    childAspectRatio: MediaQuery.of(context).orientation == Orientation.portrait ? .55:1.2,
                    children: List.generate(
                        stateHome.data.length,
                            (index) => CardOfProduct(
                          rate: stateHome.data[index].rating!.rate!,
                          category: stateHome.data[index].category
                              .toString(),
                          price:
                          stateHome.data[index].price.toString(),
                          image: stateHome.data[index].image ?? '',
                          name:
                          stateHome.data[index].title.toString(),
                          id: stateHome.data[index].id!,
                        ))),
              ],
            ),
          );
        } else if (stateHome is ErrorHomeState) {
          return Text(stateHome.message);
        } else {
          return CircularProgressIndicator(
            color: AppColors.primary,
          );
        }
      },
      listener: (context, state) {
        if (state is DeleteProductHomeState) {
          scaffoldMessage(
              context: context, message: 'Deleted', isItAlert: false);
        } else if (state is ErrorHomeState) {
          scaffoldMessage(
              context: context,
              message: "Can't delete it",
              isItAlert: true);
        }
        return;
      },
    ));

  }
}
