class DebugConfig {
  // Singleton pattern implementation
  static final DebugConfig _instance = DebugConfig._internal();
  
  factory DebugConfig() {
    return _instance;
  }
  
  DebugConfig._internal();
  
  // Debug mode flag
  bool isDebugMode = false;
  
  // Contador para toques secretos
  int secretTapCount = 0;
}
