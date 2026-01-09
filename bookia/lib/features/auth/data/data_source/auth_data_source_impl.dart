import 'package:bookia/core/services/api/api_endpoints.dart';
import 'package:bookia/core/services/api/dio_provider.dart';
import 'package:bookia/core/services/api/failure.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/features/auth/data/data_source/auth_data_source.dart';
import 'package:bookia/features/auth/domain/entities/request/auth_params.dart';
import 'package:bookia/features/auth/domain/entities/response/auth_response/auth_response.dart';
import 'package:dartz/dartz.dart';

class AuthRemoteDataSourceImpl extends AuthDataSource {
  @override
  Future<Either<Failure, AuthResponse>> login(AuthParams params) async {
    var res = await DioProvider.post(
      endpoint: ApiEndpoints.login,
      data: params.toJson(),
    );

    return res.fold(
      (l) {
        return Left(ServerFailure(l.toString()));
      },
      (res) {
        var data = AuthResponse.fromJson(res);
        // cache token
        SharedPref.saveToken(data.token);
        SharedPref.setUserData(data.user);
        return Right(data);
      },
    );
  }

  @override
  Future<Either<Failure, AuthResponse>> register(AuthParams params) async {
    var res = await DioProvider.post(
      endpoint: ApiEndpoints.register,
      data: params.toJson(),
    );

    return res.fold(
      (l) {
        return Left(ServerFailure(l.toString()));
      },
      (res) {
        var data = AuthResponse.fromJson(res);
        // cache token
        SharedPref.saveToken(data.token);
        SharedPref.setUserData(data.user);
        return Right(data);
      },
    );
  }
}
