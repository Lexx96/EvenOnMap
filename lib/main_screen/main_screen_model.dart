import 'package:flutter/material.dart';

class MainScreenModel extends ChangeNotifier{
  String? _errorMessage;
}

class MainScreenModelProvider extends InheritedNotifier {  // ???? Notifier
  final MainScreenModel model;
  const MainScreenModelProvider({
    Key? key,
    required this.model,
    required Widget child,
  }) : super(key: key,
      notifier: model,
      child: child);

  static MainScreenModelProvider? watch(BuildContext context) {
    return context.
    dependOnInheritedWidgetOfExactType<MainScreenModelProvider>();
  }

  static MainScreenModelProvider? read(BuildContext context) {
    final widget = context.getElementForInheritedWidgetOfExactType<MainScreenModelProvider>()
        ?.widget;
    return widget is MainScreenModelProvider ? widget : null;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }
}