import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se7ety/core/presentation/cubit/theme.state.dart';
import 'package:se7ety/core/services/local/shared_pref.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeInitialState());

  bool isDarkTheme = SharedPref.isDarkTheme();

  void changeTheme() {
    isDarkTheme = !isDarkTheme;
    SharedPref.setDarkTheme(isDarkTheme);
    emit(ThemeChangedState());
  }
}
