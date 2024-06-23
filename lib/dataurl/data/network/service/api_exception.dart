//
// import 'dart:convert';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
//
// import '../../../../presention/controller/login/logic.dart';
//
// dynamic handleResponse(http.Response response) {
//   final loginLogic = Get.put(LoginLogic());
//   if (response.statusCode >= 200 && response.statusCode < 300) {
//     // Successful response
//     return response;
//   } else if (response.statusCode >= 400 && response.statusCode < 500) {
//     // Client error
//     loginLogic.loading.value = false;
//     return[response.statusCode, response.body];
//     // throw Exception('Client Error: ${response.statusCode}');
//   } else if (response.statusCode >= 500) {
//     // Server error
//     loginLogic.loading.value = false;
//     throw Exception('Server Error: ${response.statusCode}');
//   } else {
//     // Other errors
//     loginLogic.loading.value = false;
//     throw Exception('Error: ${response.statusCode}');
//   }
// }
// dynamic handleResponseDelete(http.Response response) {
//   final loginLogic = Get.put(LoginLogic());
//   if (response.statusCode >= 200 && response.statusCode < 300) {
//     // Successful response
//     return response.statusCode;
//   } else if (response.statusCode >= 400 && response.statusCode < 500) {
//     // Client error
//     loginLogic.loading.value = false;
//     throw Exception('Client Error: ${response.statusCode}');
//   } else if (response.statusCode >= 500) {
//     // Server error
//     loginLogic.loading.value = false;
//     throw Exception('Server Error: ${response.statusCode}');
//   } else {
//     // Other errors
//     loginLogic.loading.value = false;
//     throw Exception('Error: ${response.statusCode}');
//   }
// }

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../../presention/component/error/error.dart';
import '../../../../presention/resources/color_manager.dart';
import '../../../../presention/resources/string_manager.dart';

class ApiException implements Exception {
  ApiException.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.cancel:
        message = "Request to API server was cancelled";
        break;
      case DioExceptionType.connectionTimeout:
        message = "Connection timeout with API server";
        break;
      case DioExceptionType.receiveTimeout:
        message = "Receive timeout in connection with API server";
        break;
      case DioExceptionType.badResponse:
        if (dioError.response?.statusCode == 401) {
        } else {
          message = _handleError(
            dioError.response?.statusCode,
            dioError.response?.data,
          );
        }
        break;
      case DioExceptionType.sendTimeout:
        message = "Send timeout in connection with API server";
        break;
      case DioExceptionType.unknown:
        if (dioError.message!.contains("SocketException")) {
          message = 'No Internet';
        } else {
          message = "Unexpected error occurred";
        }
        break;
      default:
        message = "Something went wrong";
        break;
    }
  }

  String? message;

  @override
  String toString() => message ?? '';

  String _handleError(int? statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        return '${SnackBarWid(AppString.error400.toString(), AppString.error, ColorManager.red, const Icon(Icons.lock)).build()}';
      case 403:
        return '${SnackBarWid(AppString.error403.toString(), AppString.error, ColorManager.red,  const Icon(Icons.lock)).build()}';
    // case 404:
    //   return '${SnackBarWid(AppString.error404.toString(), AppString.error, ColorManager.red, CocoIconLine.Lock).build()}';
      case 500:
        return '${SnackBarWid(AppString.error500.toString(), AppString.error, ColorManager.red,  const Icon(Icons.lock)).build()}';
      case 501:
        return '${SnackBarWid(AppString.error501.toString(), AppString.error, ColorManager.red,  const Icon(Icons.lock)).build()}';
      case 502:
        return '${SnackBarWid(AppString.error502.toString(), AppString.error, ColorManager.red,  const Icon(Icons.lock)).build()}';
      default:
        return '${SnackBarWid('', AppString.error.toString(), ColorManager.red,  const Icon(Icons.lock)).build()}';
    }
  }
}