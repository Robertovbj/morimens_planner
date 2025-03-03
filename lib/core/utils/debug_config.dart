class DebugConfig {
  static final DebugConfig _instance = DebugConfig._internal();
  factory DebugConfig() => _instance;
  DebugConfig._internal();

  bool isDebugMode = false;
}
