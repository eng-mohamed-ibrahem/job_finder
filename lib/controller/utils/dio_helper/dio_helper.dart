import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'url_paths.dart';

class DioHelper {
  static late Dio dio;

  static void init() {
    dio = Dio(
      BaseOptions(
        baseUrl: UrlPaths.baseUrl,
        receiveDataWhenStatusError: true,
        // validateStatus: (status) {
        //   if (status! < 500) {
        //     return true;
        //   } else {
        //     return false;
        //   }
        // },
      ),
    );
  }

  static Future<Response?> getData({
    required String endPoint,
    Map<String, dynamic>? querryParameters,
    String? token,
  }) async {
    try {
      if (token != null) {
        dio.options.headers['Authorization'] = 'Bearer $token';
      }
      return await dio.get(endPoint, queryParameters: querryParameters);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  static Future<Response?> postData({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    String? token,
  }) async {
    try {
      if (token != null) {
        dio.options.headers['Authorization'] = 'Bearer $token';
      }
      dio.options.headers['Content-Type'] = 'multipart/form-data';
      return await dio.post(
        endPoint,
        queryParameters: queryParameters,
        data: data != null ? FormData.fromMap(data) : null,
      );
    } catch (e) {
      debugPrint('diohelper--$e');
      return null;
    }
  }

  static Future<Response> post(
      {required String endpoint, Map<String, dynamic>? queryParameters}) async {
    return await dio.post(
      endpoint,
      queryParameters: queryParameters,
    );
  }

  static Future<Response> deleteData({
    required String endPoint,
    Map<String, dynamic>? bodyData,
    Map<String, dynamic>? queryParameters,
    required String token,
  }) async {
    dio.options.headers['Content-Type'] = 'application/json';
    dio.options.headers['Authorization'] = 'Bearer $token';
    return await dio.delete(
      endPoint,
      queryParameters: queryParameters,
      data: bodyData,
    );
  }
}
