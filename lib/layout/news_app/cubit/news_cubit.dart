import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello/modules/busniess/busniess.dart';
import 'package:hello/modules/science/Science.dart';
import 'package:hello/modules/sports/sports.dart';
import 'package:hello/shared/networks/local/cash_helper.dart';
import 'package:hello/shared/networks/remote/dio_helper.dart';

import 'news_states.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsIninialState());

  int counter = 0;
  List<Widget> list = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];

  List businessData = [];
  List sportsData = [];
  List scienceData = [];
  List searchData = [];
  bool isDark = false;
  ThemeMode mode = ThemeMode.light;

  static NewsCubit get(context) {
    return BlocProvider.of(context);
  }

  void changeNavBar(index) {
    counter = index;
    emit(ChangeBottomNav());
  }

  void getBusinessData() {
    emit(LoadingBusinessAppData());
    DioHelper.getData(path: "v2/everything", query: {
      'q':'السيد',
      'apiKey': '65f7f556ec76449fa7dc7c0069f040ca'
    }).then((value) {
      businessData = value.data["articles"];
      print(businessData.length);
      print(businessData);
      emit(GetNewsAppBusinessDataSucced());
    }).catchError((onError) {
      emit(GetNewsAppBusinessDataError(onError));
      print(onError.toString());
    });
  }

  void getScienceData() {
    if (scienceData.length == 0) {
      emit(LoadingSienceDAppData());
      DioHelper.getData(path: "v2/top-headlines", query: {
        'country': 'eg',
        'category': 'science',
        'apiKey': '65f7f556ec76449fa7dc7c0069f040ca'
      }).then((value) {
        scienceData = value.data["articles"];
        print(scienceData.length);
        print(scienceData);
        emit(GetNewsAppScienceDataSucced());
      }).catchError((onError) {
        emit(GetNewsAppSportsDDataError(onError));
        print(onError.toString());
      });
    } else
      emit(GetNewsAppScienceDataSucced());
  }

  void getSportsData() {
    if (sportsData.length == 0) {
      emit(LoadingSportsDAppData());
      DioHelper.getData(path: "v2/everything", query: {
        'q':'القدم',
        'apiKey': '65f7f556ec76449fa7dc7c0069f040ca'
      }).then((value) {
        sportsData = value.data["articles"];
        print(sportsData.length);
        print(sportsData);
        emit(GetNewsAppSportsDataSucced());
      }).catchError((onError) {
        emit(GetNewsAppSportsDDataError(onError));
        print(onError.toString());
      });
    } else
      emit(GetNewsAppSportsDataSucced());
  }

  void getSearchData(value) async {
    emit(LoadingSearchAppData());
    DioHelper.getData(path: "v2/everything", query: {
      'q':'$value',
      'apiKey': '65f7f556ec76449fa7dc7c0069f040ca'
    }).then((value) {
      searchData = value.data["articles"];
      print(searchData.length);
      print(searchData);
      emit(GetNewsAppBusinessDataSucced());
      return value;
    }).catchError((onError) {
      emit(GetSearchDataError(onError));
      print(onError.toString());
    });
    return null;
  }

  void changeMode(bool comeFromCubit) {
    if (comeFromCubit) {
      if (CashHelper.getData("dark") == null) {
        isDark = false;
        mode = ThemeMode.light;
      } else {
        isDark = (CashHelper.getData("dark")!);
        if (isDark)
          mode = ThemeMode.dark;
        else
          mode = ThemeMode.light;
      }
    } else {
      if (CashHelper.getData("dark") == null) {
        isDark = false;
        mode = ThemeMode.light;
      } else {
        isDark = !(CashHelper.getData("dark")!);
        if (isDark)
          mode = ThemeMode.dark;
        else
          mode = ThemeMode.light;
      }
    }

    CashHelper.setData("dark", isDark).then((value) {
      emit(ChangeBetweenModes());
    });
  }
}
