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
        validateStatus: (status) {
          if (status! < 500) {
            return true;
          } else {
            return false;
          }
        },
      ),
    );
  }

  static Future<Response?> getRequest({
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

  static Response? response;
  static Future<Response?> postData({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    required Map<String, dynamic> data,
    String? token,
  }) async {
    try {
      if (token != null) {
        dio.options.headers['Authorization'] = 'Bearer $token';
      }
      dio.options.headers['Content-Type'] = 'multipart/form-data';
      response = await dio.post(
        endPoint,
        queryParameters: queryParameters,
        data: FormData.fromMap(data),
      );
      return response;
      // return await dio.post(
      //   endPoint,
      //   queryParameters: queryParameters,
      //   data: FormData.fromMap(data),
      // );
    } catch (e) {
      debugPrint(response.toString());
      debugPrint(response!.statusCode.toString());
      return null;
    }
  }

  static Future<Response> deleteData({
    required String endPoint,
    Map<String, dynamic>? bodyData,
    Map<String, dynamic>? queryParameters,
    required String token,
  }) async {
    dio.options.headers['Content-Type'] = 'application/json';
    dio.options.headers['Authorization'] = 'Bearer $token';
    return await dio.delete(endPoint,
        queryParameters: queryParameters, data: bodyData);
  }
}



//   static Future<Response> getData({
//     required String url,
//     Map<String, dynamic>? query,
//   }) async {
//     dio.options.headers = {
//       "Content-Type": "application/json",
//     };
//     return await dio.get(
//       url,
//       queryParameters: query,
//     );
//   }

//   static Future<Response> getDataWithToken({
//     required String url,
//     Map<String, dynamic>? query,
//   }) async {
//     dio.options.headers = {
//       "Content-Type": "application/json",
//     };
//     return await dio.get(
//       url,
//       queryParameters: query,
//     );
//   }

//   static Future<Response> postData({
//     required String url,
//     required Map<String, dynamic> data,
//     Map<String, dynamic>? query,
//   }) async {
//     dio.options.headers = {
//       "Content-Type": "application/json",
//     };
//     return await dio.post(
//       url,
//       queryParameters: query,
//       data: data,
//     );
//   }

//   static Future<Response> postForm({
//     required String url,
//     required FormData data,
//     Map<String, dynamic>? query,
//   }) async {
//     // dio.options.headers = {
//     //   "Content-Type": "application/json",
//     // };
//     return await dio.post(
//       url,
//       queryParameters: query,
//       data: data,
//     );
//   }

//   static Future<Response> patchData({
//     required String url,
//     required Map<String, dynamic> data,
//     Map<String, dynamic>? query,
//     String? token,
//   }) async {
//     dio.options.headers = {
//       "Content-Type": "application/json",
//     };
//     return await dio.patch(
//       url,
//       queryParameters: query,
//       data: data,
//     );
//   }

//   static Future<Response> deleteData({
//     required String url,
//     Map<String, dynamic>? data,
//     Map<String, dynamic>? query,
//   }) async {
//     dio.options.headers = {
//       "Content-Type": "application/json",
//     };
//     return await dio.delete(
//       url,
//       data: data,
//     );
//   }
// }
