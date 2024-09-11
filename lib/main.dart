import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello/layout/news_app/cubit/news_cubit.dart';
import 'package:hello/shared/bloc_observer.dart';
import 'package:hello/shared/networks/local/cash_helper.dart';
import 'package:hello/shared/networks/remote/dio_helper.dart';
import 'package:hexcolor/hexcolor.dart';
import 'layout/news_app/cubit/news_states.dart';
import 'layout/news_app/news_layout/news_layout.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.initDio();
  await CashHelper.init();
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<NewsCubit>(
       create: (context) => NewsCubit()..getBusinessData()..changeMode(true),
      child: BlocConsumer<NewsCubit,NewsStates>(
         builder: (context, state) => MaterialApp(
           theme:ThemeData(
             textTheme: TextTheme(button: TextStyle(
               color: Colors.black,
               fontSize: 17,
               fontWeight: FontWeight.w600,
             )),
             primarySwatch: Colors.deepOrange ,
             floatingActionButtonTheme: FloatingActionButtonThemeData(
                 backgroundColor: Colors.deepOrange
             ),
             scaffoldBackgroundColor: Colors.white,
             bottomNavigationBarTheme: BottomNavigationBarThemeData(
               type: BottomNavigationBarType.fixed,
               selectedItemColor: Colors.deepOrange,
             ),
             appBarTheme: AppBarTheme(
               titleSpacing: 20,
               iconTheme: IconThemeData(
                 color: Colors.black,
               ),
               titleTextStyle: TextStyle(
                 color: Colors.black,

               ),
               backwardsCompatibility: false,
               elevation: 0,
               backgroundColor: Colors.white,
               systemOverlayStyle: SystemUiOverlayStyle(
                 statusBarIconBrightness: Brightness.dark,
                 statusBarColor: Colors.white,
               ),
             ),
           ) ,
           darkTheme: ThemeData(
             textTheme: TextTheme(button: TextStyle(
               color: Colors.white,
               fontSize: 17,
               fontWeight: FontWeight.w600,
             )),
             primarySwatch: Colors.deepOrange ,
             scaffoldBackgroundColor: HexColor("333437"),
             bottomNavigationBarTheme: BottomNavigationBarThemeData(
                 type: BottomNavigationBarType.fixed,
                 selectedItemColor: Colors.deepOrange,
                 backgroundColor: HexColor("333439"),
                 unselectedItemColor:  Colors.grey
             ),
             appBarTheme: AppBarTheme(
               titleSpacing: 20,
               iconTheme: IconThemeData(
                 color: Colors.white,
               ),
               titleTextStyle: TextStyle(
                 color: Colors.white,
               ),
               backwardsCompatibility: false,
               elevation: 0,
               backgroundColor: HexColor("333437"),
               systemOverlayStyle: SystemUiOverlayStyle(
                   statusBarColor: HexColor("333437"),
                statusBarIconBrightness: Brightness.light
               ),
             ),
           ),
           themeMode:NewsCubit.get(context).mode ,
           debugShowCheckedModeBanner: false,

           home: NewsLayout(),
         ),
        listener: (context, state) {

        },
      ),
    );
  }
}

