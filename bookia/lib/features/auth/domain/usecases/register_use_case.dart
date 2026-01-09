import 'package:bookia/core/services/api/failure.dart';
import 'package:bookia/features/auth/domain/entities/request/auth_params.dart';
import 'package:bookia/features/auth/domain/entities/response/auth_response/auth_response.dart';
import 'package:bookia/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

class RegisterUseCase {
  final AuthRepository authRepository;
  RegisterUseCase({required this.authRepository});

  Future<Either<Failure, AuthResponse>> call(AuthParams params) {
    return authRepository.register(params);
  }
}
