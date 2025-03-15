import 'package:flutter/material.dart';

/// A utility class that generates consistent colors from strings.
///
/// This class provides a deterministic way to convert strings into colors,
/// which means the same string will always produce the same color.
class ColorGenerator {
  /// Generates a color from a given string input.
  ///
  /// This method uses a hashing algorithm to convert the string into a hue value,
  /// while maintaining fixed saturation and lightness values to ensure visibility
  /// and vibrancy.
  ///
  /// The generated colors:
  /// - Have consistent saturation (70%)
  /// - Have consistent lightness (60%)
  /// - Are deterministic (same string = same color)
  /// - Are distributed across the color spectrum
  ///
  /// Parameters:
  ///   - str: The input string to generate a color from
  ///
  /// Returns:
  ///   A [Color] object representing the generated color
  static Color fromString(String str) {
    var hash = 0;
    for (var i = 0; i < str.length; i++) {
      hash = str.codeUnitAt(i) + ((hash << 5) - hash);
    }
    
    // Ensures the color is not too light or too dark
    final double hue = (hash % 360).abs() / 360;
    const double saturation = 0.7;  // Fixed to keep colors vibrant
    const double lightness = 0.6;   // Fixed to keep colors visible
    
    return HSLColor.fromAHSL(1.0, hue * 360, saturation, lightness).toColor();
  }
}
