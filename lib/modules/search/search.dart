import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello/layout/news_app/cubit/news_cubit.dart';
import 'package:hello/layout/news_app/cubit/news_states.dart';
import 'package:hello/shared/componants/componants.dart';

class SearchScreen extends StatelessWidget {
  var searchControl=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultTextFormFeild(
                  control: searchControl,
                  labletext: "Search",
                  prfexicon: Icons.search,
                  validator: ( value) {
                    if(value!.isEmpty )
                      return "search must not be empty";
                  },
                  onFieldSubmitted:  (value) {
                    print(value);
                    NewsCubit.get(context).getSearchData(value);
                  },
                 colorOfEnabledBorder: Colors.grey,
                  colorOfFocusedBorder: Colors.grey,
                  colorOfLabel: Colors.grey,
                  colorOfInputText: Colors.grey,
                  colorOfprefixIcon: Colors.grey,
                ),
              ),
              Expanded(
                child: ConditionalBuilder(
                    condition:NewsCubit.get(context).searchData.length>0,
                    builder: (context) => ListView.separated(
                        physics: BouncingScrollPhysics() ,
                        itemBuilder: (context, index) => BuiledNewsApp(NewsCubit.get(context).searchData[index],context,"search"),
                        separatorBuilder: (context, index)=>BuiledSeprationBuilder(),
                        itemCount: NewsCubit.get(context).searchData.length),
                    fallback:(context) => Container()),
              ),
            ],
          ),
        );

      },

    );
  }
}
