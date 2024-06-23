// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:http/http.dart';
//
// class ApiService {
//
//   Future<Response> post(String endpoint, dynamic data, {required Map<String, String> headers}) async {
//     final url = endpoint;
//     final Response response = await http.post(Uri.parse(url), body: jsonEncode(data), headers: headers);
//     return response;
//   }
//
//   Future<Response> get(String endpoint, {required Map<String, String> headers}) async {
//     final url = endpoint;
//     final Response response = await http.get(Uri.parse(url), headers: headers);
//     return response;
//   }
//
//   Future<Response> patch(String endpoint, dynamic data, {required Map<String, String> headers}) async {
//     final url = endpoint;
//     final Response response = await http.patch(Uri.parse(url), body: jsonEncode(data), headers: headers);
//     return response;
//   }
//
//   Future<Response> put(String endpoint, dynamic data, {required Map<String, String> headers}) async {
//     final url = endpoint;
//     final Response response = await http.put(Uri.parse(url), body: jsonEncode(data), headers: headers);
//     return response;
//   }
//
//   Future<Response> delete(String endpoint, dynamic data, {required Map<String, String> headers}) async {
//     final url = endpoint;
//     final Response response = await http.delete(Uri.parse(url),body: jsonEncode(data), headers: headers);
//     return response;
//   }
// }

import 'package:dio/dio.dart';

import '../../../constants/app_url.dart';

class ApiService {
  static final _options = BaseOptions(
    baseUrl: AppUrl.baseUrl,
    // connectTimeout: AppUrl.connectionTimeout ,
    // receiveTimeout: AppUrl.receiveTimeout ,
    responseType: ResponseType.json,
  );

  // dio instance
  final Dio _dio = Dio(_options)..interceptors.add(LogInterceptor());

  // GET request
  Future<Response> get(
      String url, {
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onReceiveProgress,
      }) async {
    try {
      final Response response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // POST request
  Future<Response> post(
      String url, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
      }) async {
    try {
      final Response response = await _dio.post(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // PUT request
  Future<Response> put(
      String url, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
      }) async {
    try {
      final Response response = await _dio.put(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // PATCH request
  Future<Response> patch(
      String url, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
      }) async {
    try {
      final Response response = await _dio.patch(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // DELETE request
  Future<Response> delete(
      String url, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
      }) async {
    try {
      final Response response = await _dio.delete(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
