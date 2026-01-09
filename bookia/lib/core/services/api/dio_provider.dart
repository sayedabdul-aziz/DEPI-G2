import 'package:bookia/core/services/api/api_endpoints.dart';
import 'package:bookia/core/services/api/base_response.dart';
import 'package:bookia/core/services/api/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class DioProvider {
  static late Dio dio;

  static init() {
    dio = Dio(BaseOptions(baseUrl: ApiEndpoints.baseUrl));
  }

  static DioProvider get instance => DioProvider();

  static Future<Either<Failure, dynamic>> get({
    required String endpoint,
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      var response = await dio.get(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      var responseData = BaseResponse.fromJson(response.data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(responseData.data);
      } else {
        return Left(ServerFailure(responseData.message ?? ''));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(handleDioErrors(e)));
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  static Future<Either<Failure, dynamic>> post({
    required String endpoint,
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      var response = await dio.post(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      var responseData = BaseResponse.fromJson(response.data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(responseData.data);
      } else {
        return Left(ServerFailure(responseData.message ?? ''));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(handleDioErrors(e)));
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  static Future<Either<Failure, dynamic>> put({
    required String endpoint,
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      var response = await dio.put(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      var responseData = BaseResponse.fromJson(response.data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(responseData.data);
      } else {
        return Left(ServerFailure(responseData.message ?? ''));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(handleDioErrors(e)));
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  static Future<Either<Failure, dynamic>> delete({
    required String endpoint,
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      var response = await dio.delete(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      var responseData = BaseResponse.fromJson(response.data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(responseData.data);
      } else {
        return Left(ServerFailure(responseData.message ?? ''));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(handleDioErrors(e)));
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  static String handleDioErrors(DioException e) {
    switch (e.type) {
      case DioExceptionType.badResponse:
        return e.response?.statusMessage ?? '';
      case DioExceptionType.connectionTimeout:
        return e.message ?? '';
      case DioExceptionType.receiveTimeout:
        return e.message ?? '';
      case DioExceptionType.sendTimeout:
        return e.message ?? '';
      default:
        return e.message ?? '';
    }
  }
}
