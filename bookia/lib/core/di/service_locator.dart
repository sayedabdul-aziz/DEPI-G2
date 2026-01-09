import 'package:bookia/core/services/api/dio_provider.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/features/auth/data/data_source/auth_data_source.dart';
import 'package:bookia/features/auth/data/data_source/auth_data_source_impl.dart';
import 'package:bookia/features/auth/data/repository/auth_repository_impl.dart';
import 'package:bookia/features/auth/domain/repository/auth_repository.dart';
import 'package:bookia/features/auth/domain/usecases/login_use_case.dart';
import 'package:bookia/features/auth/domain/usecases/register_use_case.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:get_it/get_it.dart';

final gi = GetIt.instance;

Future<void> setupServiceLocator() async {
  await DioProvider.init();
  await SharedPref.init();
  // register services
  gi.registerSingleton(() => SharedPref.instance);
  gi.registerSingleton(() => DioProvider.instance);

  // register data sources
  gi.registerLazySingleton<AuthDataSource>(() => AuthRemoteDataSourceImpl());

  // register repositories
  gi.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(authDataSource: gi<AuthDataSource>()),
  );

  // register use cases
  gi.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(authRepository: gi<AuthRepository>()),
  );
  gi.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(authRepository: gi<AuthRepository>()),
  );

  // register cubit
  gi.registerLazySingleton<AuthCubit>(
    () => AuthCubit(
      loginUseCase: gi<LoginUseCase>(),
      registerUseCase: gi<RegisterUseCase>(),
    ),
  );
}
