import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello/layout/news_app/cubit/news_cubit.dart';
import 'package:hello/layout/news_app/cubit/news_states.dart';
import 'package:hello/shared/componants/componants.dart';

class ScienceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    NewsCubit cubit=NewsCubit.get(context);
    return BlocConsumer<NewsCubit,NewsStates>(
      listener:(context, state) {
      } ,
      builder:(context, state)=> ConditionalBuilder(
          condition: cubit.scienceData.length>0,
          builder: (context) => ListView.separated(
              physics: BouncingScrollPhysics() ,
              itemBuilder: (context, index) => BuiledNewsApp(cubit.scienceData[index],context,"science"),
              separatorBuilder: (context, index)=>BuiledSeprationBuilder(),
              itemCount: cubit.scienceData.length),
          fallback:(context) => Center(child: CircularProgressIndicator())),
    );
  }
}
