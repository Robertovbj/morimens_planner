import 'package:flutter/material.dart';

class ColorGenerator {
  static Color fromString(String str) {
    var hash = 0;
    for (var i = 0; i < str.length; i++) {
      hash = str.codeUnitAt(i) + ((hash << 5) - hash);
    }
    
    // Garante que a cor não seja muito clara nem muito escura
    final double hue = (hash % 360).abs() / 360;
    const double saturation = 0.7;  // Fixo para manter cores vivas
    const double lightness = 0.6;   // Fixo para manter cores visíveis
    
    return HSLColor.fromAHSL(1.0, hue * 360, saturation, lightness).toColor();
  }
}
