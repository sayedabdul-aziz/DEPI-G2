import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:se7ety/feature/auth/data/models/user_type_enum.dart';
import 'package:se7ety/feature/auth/presentation/cubit/auth_cubit.dart';
import 'package:se7ety/feature/auth/presentation/page/login_screen.dart';
import 'package:se7ety/feature/auth/presentation/page/register_screen.dart';
import 'package:se7ety/feature/intro/onboarding/onboarding_screen.dart';
import 'package:se7ety/feature/intro/splash/splash_screen.dart';
import 'package:se7ety/feature/intro/welcome/welcome_screen.dart';

class Routes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String register = '/register';

  static final routes = GoRouter(
    initialLocation: splash,
    routes: [
      GoRoute(path: splash, builder: (context, state) => const SplashScreen()),
      GoRoute(
        path: onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: welcome,
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: login,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(),
          child: LoginScreen(userType: state.extra as UserTypeEnum),
        ),
      ),
      GoRoute(
        path: register,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(),
          child: RegisterScreen(userType: state.extra as UserTypeEnum),
        ),
      ),
    ],
  );
}
