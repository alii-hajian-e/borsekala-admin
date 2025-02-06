import 'package:dio/dio.dart';

import '../service/api_service_panel.dart';

class AppApiPanel {
  final ApiServicePanel _apiService = ApiServicePanel();

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

  Future<Response> delete(url,options,{Map<String, dynamic>? data}) async {
    try {
      final Response response = await _apiService.delete(
          url,
          data: data,
          options: options
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
  Future<Response> patch({url,Map<String, dynamic>? data,options}) async {
    try {
      final Response response = await _apiService.patchRequest(
        url,
        data: data,
        options: options,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}