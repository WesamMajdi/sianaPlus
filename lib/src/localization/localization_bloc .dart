import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';

class LocalizationBlocProvider extends StatelessWidget {
  final Widget child;
  final LocalizationBloc bloc;

  const LocalizationBlocProvider({
    Key? key,
    required this.child,
    required this.bloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: child,
    );
  }

  static LocalizationBloc of(BuildContext context) {
    return BlocProvider.of<LocalizationBloc>(context, listen: false);
  }
}
