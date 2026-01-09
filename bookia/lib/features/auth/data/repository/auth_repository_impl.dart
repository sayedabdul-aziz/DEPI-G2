import 'package:bookia/core/services/api/failure.dart';
import 'package:bookia/features/auth/data/data_source/auth_data_source.dart';
import 'package:bookia/features/auth/domain/entities/request/auth_params.dart';
import 'package:bookia/features/auth/domain/entities/response/auth_response/auth_response.dart';
import 'package:bookia/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthDataSource authDataSource;

  AuthRepositoryImpl({required this.authDataSource});
  @override
  Future<Either<Failure, AuthResponse>> login(AuthParams params) async {
    return authDataSource.login(params);
  }

  @override
  Future<Either<Failure, AuthResponse>> register(AuthParams params) {
    return authDataSource.register(params);
  }
}
