import 'package:event_on_map/navigation/main_navigation.dart';
import 'package:flutter/material.dart';

class AuthModel extends ChangeNotifier{
  final loginTextFieldController = TextEditingController();
  final passwordTextFieldController = TextEditingController();
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  final navigation = MainNavigation().routes;

  /*
  bool _isAuthProgress = false;
  bool get canStartAuth => !_isAuthProgress;  = true
   */

  bool _isAuthProgress = true;  //false
  bool get canStartAuth => !_isAuthProgress;

  Future<void> signIn (BuildContext context) async{
    Navigator.of(context).pushNamed('auth/authSignIn');
  }
}


class AuthScreenWidgetProvider extends InheritedNotifier {  // ???? Notifier
  final AuthModel model;
  const AuthScreenWidgetProvider({
    Key? key,
    required this.model,
    required Widget child,
  }) : super(key: key,
      notifier: model,
      child: child);

  static AuthScreenWidgetProvider? watch(BuildContext context) {
    return context.
    dependOnInheritedWidgetOfExactType<AuthScreenWidgetProvider>();
  }

  static AuthScreenWidgetProvider? read(BuildContext context) {
    final widget = context.getElementForInheritedWidgetOfExactType<AuthScreenWidgetProvider>()
        ?.widget;
    return widget is AuthScreenWidgetProvider ? widget : null;
  }
}