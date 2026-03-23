import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.dark);

  void toggleTheme() =>
      emit(state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark);
}
