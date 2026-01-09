import 'package:bookia/features/auth/domain/entities/request/auth_params.dart';
import 'package:bookia/features/auth/domain/usecases/login_use_case.dart';
import 'package:bookia/features/auth/domain/usecases/register_use_case.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  AuthCubit({required this.loginUseCase, required this.registerUseCase})
    : super(AuthInitialState());

  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  register() async {
    emit(AuthLoadingState());

    var params = AuthParams(
      name: nameController.text,
      email: emailController.text,
      password: passwordController.text,
      passwordConfirmation: confirmPasswordController.text,
    );

    var result = await registerUseCase.call(params);

    result.fold(
      (left) {
        emit(AuthErrorState(message: left.errorMessage));
      },
      (right) {
        emit(AuthSuccessState());
      },
    );
  }

  login() async {
    emit(AuthLoadingState());

    var params = AuthParams(
      email: emailController.text,
      password: passwordController.text,
    );

    var result = await loginUseCase.call(params);

    result.fold(
      (left) {
        emit(AuthErrorState(message: left.errorMessage));
      },
      (right) {
        emit(AuthSuccessState());
      },
    );
  }
}
