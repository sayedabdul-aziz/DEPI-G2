import 'package:bookia/core/di/service_locator.dart';
import 'package:bookia/features/auth/domain/usecases/login_use_case.dart';
import 'package:bookia/features/auth/domain/usecases/register_use_case.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:bookia/features/auth/presentation/page/forget_password/forget_send_email_screen.dart';
import 'package:bookia/features/auth/presentation/page/login_screen.dart';
import 'package:bookia/features/auth/presentation/page/register_screen.dart';
import 'package:bookia/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:bookia/features/cart/presentation/page/place_order_screen.dart';
import 'package:bookia/features/home/data/models/best_seller_response/product.dart';
import 'package:bookia/features/home/presentation/cubit/home_cubit.dart';
import 'package:bookia/features/home/presentation/page/details_screen.dart';
import 'package:bookia/features/main/main_app_screen.dart';
import 'package:bookia/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:bookia/features/profile/presentation/page/edit_profile_screen.dart';
import 'package:bookia/features/splash/splash_screen.dart';
import 'package:bookia/features/welcome/welcome_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class Routes {
  static const String splash = '/';
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgetSendEmail = '/forget-send-email';
  static const String main = '/main';
  static const String details = '/details';
  static const String placeOrder = '/place-order';
  static const String editProfile = '/editProfile';

  static final routes = GoRouter(
    initialLocation: splash,
    routes: [
      GoRoute(path: splash, builder: (context, state) => const SplashScreen()),
      GoRoute(
        path: welcome,
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: login,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(
            loginUseCase: gi<LoginUseCase>(),
            registerUseCase: gi<RegisterUseCase>(),
          ),
          child: const LoginScreen(),
        ),
      ),
      GoRoute(
        path: register,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(
            loginUseCase: gi<LoginUseCase>(),
            registerUseCase: gi<RegisterUseCase>(),
          ),
          child: const RegisterScreen(),
        ),
      ),

      GoRoute(
        path: forgetSendEmail,
        builder: (context, state) => BlocProvider.value(
          value: gi<AuthCubit>(),
          child: ForgetSendEmailScreen(email: state.extra as String),
        ),
      ),

      GoRoute(
        path: main,
        builder: (context, state) =>
            MainAppScreen(initialIndex: state.extra as int?),
      ),

      GoRoute(
        path: details,
        builder: (context, state) => BlocProvider(
          create: (context) => HomeCubit(),
          child: DetailsScreen(product: state.extra as Product),
        ),
      ),
      GoRoute(
        path: placeOrder,
        builder: (context, state) => BlocProvider(
          create: (context) => CartCubit()..preFillUserData(),
          child: PlaceOrderScreen(total: state.extra as String),
        ),
      ),
      GoRoute(
        path: editProfile,
        builder: (context, state) => BlocProvider(
          create: (context) => ProfileCubit()..initData(),
          child: EditProfileScreen(),
        ),
      ),
    ],
  );
}
