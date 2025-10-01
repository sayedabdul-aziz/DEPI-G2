import 'dart:developer';

import 'package:bookia/core/services/api_endpoints.dart';
import 'package:bookia/core/services/dio_provider.dart';
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
        return AuthResponse.fromJson(res.data);
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
        var data = res.data;
        return AuthResponse.fromJson(data);
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());

      return null;
    }
  }
}
