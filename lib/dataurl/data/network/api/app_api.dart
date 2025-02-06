import 'package:dio/dio.dart';

import '../service/api_service.dart';

class AppApi {
  final ApiService _apiService = ApiService();

  Future<Response> get(url,options) async {
    try {
      final Response response = await _apiService.get(url,options: options);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> post({url,Map<String, dynamic>? data,options}) async {
    try {
      final Response response = await _apiService.post(
        url,
        data: data,
        options: options,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> put(url, {Map<String, dynamic>? data,options}) async {
    try {
      final Response response = await _apiService.put(
        url,
        data: data,
        options: options,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> delete(url,options) async {
    try {
      final Response response = await _apiService.delete(
          url,
          options: options
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
