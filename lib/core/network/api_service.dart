import 'dart:io';

import 'package:curt_task/core/local/user_data.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../error/faliure.dart';
import '../local/user_access_token.dart';
import '../utililes/app_strings.dart';

class ApiService {
  static const String baseUrl = "http://192.168.100.3:8080";

  Dio dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(milliseconds: 30000),
      receiveTimeout: const Duration(milliseconds: 30000),
      headers: {
        'Content-Type': 'application/json',

      },
      validateStatus: (int? status) {
        return (status ?? 0) < 500;
      },
    ),
  );

  void initialize(String token) {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }
 Future<Response> get({ required String endPoint,
    
    String? token,}) async {
    try {
      final response = await dio.get(
        '$baseUrl$endPoint',
        options: Options(
          headers: token == null ? {} : {'Authorization': 'Bearer $token'},
        ),
      );
      print('Response here : ${response.statusCode}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        print("Error here: ${response.statusCode}");
        throw Exception('Failed to load data');
      }
    } catch (e) {
      if (e is DioError) {
        print('DioError: ${e.message}');
        throw ServerFailure.fromDioError(e);
      } else {
        print('Unhandled Exception: $e');
        throw Exception('Unhandled error occurred');
      }
    }
  }


  Future<Response> post({
    required String endPoint,
    Object? data,
    String? token,
  }) async {
    try {
      dio.options.headers = token == null
          ? {}
          : {
              'Authorization': 'Bearer $token',
            };

      Response response = await dio.post(
        '$baseUrl$endPoint',
        data: data,
      );
      print('Response here : ${response.data}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        throw response;
      }
    } catch (e) {
      if (e is DioException) {
        throw ServerFailure.fromDioError(e);
      } else {
        throw _handleError(e);
      }
    }
  }

  Future<Response> delete({
    required String endPoint,
    String? token,
    Object? data
  }) async {
    try {
      dio.options.headers = token == null
          ? {}
          : {
              'Authorization': 'Bearer $token',
            };

      Response response = await dio.delete(
        '$baseUrl$endPoint',
        data: data,

      );
      print('Response here : ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        throw response;
      }
    } catch (e) {
      if (e is DioException) {
        throw ServerFailure.fromDioError(e);
      } else {
        throw _handleError(e);
      }
    }
  }

  static Exception _handleError(dynamic e) {
    if (e.data != null) {
      final response = e.data;
      switch (e.statusCode) {
        case 400:
          throw ServerFailure(message: response['message'] ?? 'Bad request');
        case 401:
          throw const ServerFailure(message: AppStrings.errorUnauthorized);
        case 403:
          throw const ServerFailure(message: AppStrings.errorForbidden);
        case 404:
          throw ServerFailure(
              message: response['message'] ?? AppStrings.errorResource);
        case 429:
          throw const ServerFailure(message: AppStrings.errorServer);
        case 500:
          throw const ServerFailure(message: AppStrings.errorInternal);
        default:
          throw ServerFailure(
              message:
                  'Server error: ${e.response!.statusCode} ${e.response!.statusMessage}');
      }
    } else {
      throw const ServerFailure(message: AppStrings.errorNetwork);
    }
  }

  Future<bool> login(String username, String password) async {
    try {
      final response = await dio.post(
        '/auth/login',
        data: {'username': username, 'password': password},
      );
      if (kDebugMode) {
        print('Response Status Code: ${response.statusCode}');
      }
      print('Response here: ${response.data}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        UserAccessToken.accessToken = response.data['token'];
        UserData.userRole = response.data['user']['role'];
        UserData.username = response.data['user']['username'];

        initialize(UserAccessToken.accessToken!);
        print('Login Successful: ${response.data}');

        return true;
      } else if (response.statusCode == 400) {
        print('Login Failed: Invalid credentials');
        return false;
      } else {
        print('Login Failed: ${response.statusCode} ${response.statusMessage}');
        return false;
      }
    } catch (e) {
      if (e is DioException) {
        print('Login Failed: ${e.response?.statusCode} ${e.response?.statusMessage}');
        print('Error Data: ${e.response?.data}');
        throw ServerFailure.fromDioError(e);
      } else if (e is SocketException) {
        print('Login Failed: Connection refused');
        throw ServerFailure(message: 'Connection refused');
      } else {
        print('Unexpected Error: $e');
        throw Exception('Unexpected error occurred');
      }
    }
  }



Future<bool> signUp(String email, String password) async {
  try {
    final response = await dio.post(
      '/auth/register',
      data: {'username': email, 'password': password, 'role': 'user'},
    );
    if (kDebugMode) {
      print('Response Status Code: ${response.statusCode}');
    }
    print('Response here: ${response.data}');
    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Sign Up Successful: ${response.data}');
      return true;
    } else {
      print('Sign Up Failed: ${response.statusCode} ${response.statusMessage}');
      return false;
    }
  } catch (e) {
    if (e is DioException) {
      print('Sign Up Failed: ${e.response?.statusCode} ${e.response?.statusMessage}');
      print('Error Data: ${e.response?.data}');
      throw ServerFailure.fromDioError(e);
    } else if (e is SocketException) {
      print('Sign Up Failed: Connection refused');
      return false;
    } else {
      print('Sign Up Failed: $e');
      throw _handleError(e);
    }
  }
}
}
