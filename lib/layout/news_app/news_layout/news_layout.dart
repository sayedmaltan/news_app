import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello/layout/news_app/cubit/news_cubit.dart';
import 'package:hello/layout/news_app/cubit/news_states.dart';
import 'package:hello/modules/search/search.dart';

class NewsLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      builder: (context, state) {
        NewsCubit cubit=NewsCubit.get(context);
        return Scaffold(
        appBar: AppBar(
          title:Text(
            "News App",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize:23,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                 Navigator.push(
                   context,
                     MaterialPageRoute(builder: (context) => SearchScreen(),)
                 );
              },
              icon: Icon(Icons.search),

            ),
            IconButton(
                onPressed: () {
                  cubit.changeMode(false);
            },
                icon: Icon(Icons.brightness_4)
            )
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            cubit.changeNavBar(value);
            if(value==1){
              cubit.getSportsData();
            }
            else  if(value==2) {
                cubit.getScienceData();
            }

          },
          currentIndex: cubit.counter,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: "Business",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.sports),
              label: "Sports",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.science),
              label: "Science",
            ),
          ],
        ),
          body: cubit.list[cubit.counter],
      );
      },
      listener: (context, state) {

      },
    );
  }
}
