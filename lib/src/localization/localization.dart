import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';

abstract class LocalizationEvent {}

class SwitchLocaleEvent extends LocalizationEvent {
  final String languageCode;

  SwitchLocaleEvent(this.languageCode);
}

class LocalizationState {
  final Locale currentLocale;

  LocalizationState(this.currentLocale);
}

class LocalizationBloc extends Bloc<LocalizationEvent, LocalizationState> {
  late SharedPreferences _pref;

  LocalizationBloc() : super(LocalizationState(const Locale('ar'))) {
    _loadSharedData();
  }

  void _loadSharedData() async {
    _pref = await SharedPreferences.getInstance();
    _loadLocalData();
  }

  void _loadLocalData() async {
    final languageCode = _pref.getString('languageCode') ?? 'ar';
    // ignore: invalid_use_of_visible_for_testing_member
    emit(LocalizationState(Locale(languageCode)));
  }

  Stream<LocalizationState> mapEventToState(LocalizationEvent event) async* {
    if (event is SwitchLocaleEvent) {
      _pref.setString('languageCode', event.languageCode);
      _loadLocalData();
    }
  }
}
