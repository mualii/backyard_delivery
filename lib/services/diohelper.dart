import 'dart:io';

import 'package:backyard_delivery/services/localstroage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class DioHelper {
  static const baseurl="backyardapi.mvdev.xyz";
  //========================== جميع ال Errors ال ممكن تقابلها فى اى تطبيق =============
  static String errorGlobal({required DioError dioError}) {
    if (DioErrorType.response == dioError.type) {
      return dioError.response!.data.toString();
    } else if (DioErrorType.connectTimeout == dioError.type) {
      return "Connection timeout with API server";
    } else if (DioErrorType.receiveTimeout == dioError.type) {
      return "Receive timeout in connection with API server";
    } else if (DioErrorType.sendTimeout == dioError.type) {
      return "Send timeout in connection with API server";
    } else if (DioErrorType.cancel == dioError.type) {
      return "Request to API server was cancelled";
    } else if (DioErrorType.other == dioError.type) {
      return "Connection to API server failed due to internet connection";
    } else {
      return "Error All";
    }
  }

  static getData(
      {required String endpoint,
      required Map<String, dynamic>? setParamars,

      required BuildContext context}) async {

    try{
    Uri uri = Uri.https(baseurl, endpoint,setParamars);
    Response respone = await Dio().getUri(uri,
        options: Options(
          headers:{
            'X-Requested-With': 'XMLHttpRequest',
            'Content-Type': 'application/json',
            'Content-Language': LocalStorage.getData(key: "Lang"),
            if(LocalStorage.getData(key: "deviceToken")!=null)
        HttpHeaders.authorizationHeader: "Bearer " + LocalStorage.getData(key: "deviceToken")
          },
        ));
    print(respone.toString());
    return respone.data;
    }
        on DioError catch(e)
    {
      print (e.error);
      return errorGlobal(dioError: e);
    }
  }

  static Future postData(
      {required String endpoint,
         Map<String, dynamic>? formData,

        required BuildContext context}) async {

    try{
    Uri uri = Uri.https(baseurl, endpoint);
    print(uri.toString());
    Response respone = await Dio().postUri(uri,data: formData,
        options: Options(
          headers: {
            'X-Requested-With': 'XMLHttpRequest',
            'Content-Type': 'application/json',
            'Content-Language':  LocalStorage.getData(key: "Lang"),
         if(LocalStorage.getData(key: "deviceToken")!=null)   HttpHeaders.authorizationHeader: "Bearer " +LocalStorage.getData(key: "deviceToken")
          },
        ));

    return respone.data;
    }
        on DioError catch (e){
      print(e.error);
      return errorGlobal(dioError: e);
        }
  }

}
