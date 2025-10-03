import 'dart:developer';

import 'package:bookia/core/services/api_endpoints.dart';
import 'package:bookia/core/services/dio_provider.dart';
import 'package:bookia/features/home/data/models/best_seller_response/best_seller_response.dart';

class HomeRepo {
  static Future<BestSellerResponse?> getBestSeller() async {
    try {
      var res = await DioProvider.get(
        endpoint: ApiEndpoints.productsBestseller,
      );

      if (res.statusCode == 200) {
        return BestSellerResponse.fromJson(res.data);
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }
}
