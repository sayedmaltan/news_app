import 'package:dio/dio.dart';

class DioHelper{

  static late  Dio dio;

  static void  initDio() {
    dio=Dio(
      BaseOptions(
        baseUrl: 'https://newsapi.org/',
        receiveDataWhenStatusError: true,

      ),

    );
  }

  static Future<Response> getData({required path,required  query}) async {
   return  await dio.get(
     "$path",
     queryParameters: query,
   ).catchError((onError){
     print(onError.toString());
   });
  }

}