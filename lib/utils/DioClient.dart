import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fintech_asmt/utils/utils.dart';

class DioClient {
  late Dio _dio;
  DioClient() {
    _dio = Dio();
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (request, handler) async {
          String? jwt = await getSharedPreferences("string", "jwt");
          if (jwt != null && jwt != '') {
            request.data['jwt'] = jwt;
            request.headers['Token'] = jwt;
          }
          return handler.next(request);
        },
      ),
    );
  }

  Future<Map<String, dynamic>> post(String uri, data) async {
    try {
      var response = await _dio.post(uri, data: data);
      print(response.data);
      var responseData = jsonDecode(response.data.toString());
      return responseData;
    } catch (e) {
      rethrow;
    }
  }

  Future get(String uri) async {
    try {
      var response = await _dio.get(uri);
      var responseData = response.data;
      return responseData;
    } catch (e) {
      rethrow;
    }
  }
}
