import 'dart:developer';

import 'package:bookia/core/services/api/api_endpoints.dart';
import 'package:bookia/core/services/api/dio_provider.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/features/auth/data/models/request/auth_params.dart';
import 'package:bookia/features/auth/data/models/response/auth_response/auth_response.dart';

class AuthRepo {
  static Future<AuthResponse?> register(AuthParams params) async {
    try {
      var res = await DioProvider.post(
        endpoint: ApiEndpoints.register,
        data: params.toJson(),
      );

      if (res.statusCode == 201) {
        // parse json to object
        var data = AuthResponse.fromJson(res.data);
        // cache token
        SharedPref.saveToken(data.data?.token);
        return data;
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<AuthResponse?> login(AuthParams params) async {
    try {
      var res = await DioProvider.post(
        endpoint: ApiEndpoints.login,
        data: params.toJson(),
      );
      if (res.statusCode == 200) {
        // parse json to object
        var data = AuthResponse.fromJson(res.data);
        // cache token
        SharedPref.saveToken(data.data?.token);
        return data;
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());

      return null;
    }
  }
}
