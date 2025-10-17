import 'dart:developer';

import 'package:bookia/core/services/api/api_endpoints.dart';
import 'package:bookia/core/services/api/dio_provider.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/features/profile/data/model/profile_response/profile_response.dart';
import 'package:bookia/features/profile/data/model/update_profile_params.dart';

class ProfileRepo {
  static Future<bool> updateProfile(UpdateProfileParams params) async {
    try {
      var res = await DioProvider.post(
        endpoint: ApiEndpoints.updateProfile,
        data: params.toFormData(),
        headers: {"Authorization": "Bearer ${SharedPref.getToken()}"},
      );

      if (res.statusCode == 200) {
        var data = ProfileResponse.fromJson(res.data);
        SharedPref.setUserData(data.data);
        return true;
      } else {
        return false;
      }
    } on Exception catch (e) {
      log(e.toString());
      return false;
    }
  }
}
