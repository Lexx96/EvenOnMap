

class DecorationPageState {
  DecorationPageState();
  factory DecorationPageState.systemThemeDecorationPageState() = SystemThemeDecorationPageState;
  factory DecorationPageState.lightThemeDecorationPageState() = LightThemeDecorationPageState;
  factory DecorationPageState.darkThemeDecorationPageState() = DarkThemeDecorationPageState;
  factory DecorationPageState.emptyDecorationPageState() = EmptyDecorationPageState;

}

class EmptyDecorationPageState extends DecorationPageState {}

class SystemThemeDecorationPageState extends DecorationPageState {}

class LightThemeDecorationPageState extends DecorationPageState {}

class DarkThemeDecorationPageState extends DecorationPageState {}