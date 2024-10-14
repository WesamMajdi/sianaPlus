import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Events
abstract class ThemeChangerEvent {}

class ToggleThemeEvent extends ThemeChangerEvent {}

// States
enum ThemeType { light, dark }

class ThemeChangerState {
  final ThemeType themeType;

  ThemeChangerState(this.themeType);
}

// Bloc
class ThemeChangerBloc extends Bloc<ThemeChangerEvent, ThemeChangerState> {
  final SharedPreferences prefs;

  ThemeChangerBloc(this.prefs) : super(_getStateFromPrefs(prefs)) {
    on<ToggleThemeEvent>((event, emit) async {
      final newTheme =
          state.themeType == ThemeType.light ? ThemeType.dark : ThemeType.light;

      await prefs.setInt('themeType', newTheme.index);

      emit(ThemeChangerState(newTheme));
    });
  }

  static ThemeChangerState _getStateFromPrefs(SharedPreferences prefs) {
    final themeTypeIndex = prefs.getInt('themeType') ?? ThemeType.light.index;
    return ThemeChangerState(ThemeType.values[themeTypeIndex]);
  }
}
