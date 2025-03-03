import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff465669),
      surfaceTint: Color(0xff506073),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff5e6e82),
      onPrimaryContainer: Color(0xffe7f0ff),
      secondary: Color(0xff595f67),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffdde3ed),
      onSecondaryContainer: Color(0xff5f656d),
      tertiary: Color(0xff644d62),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff7d657b),
      onTertiaryContainer: Color(0xffffe9fa),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfffbf9fa),
      onSurface: Color(0xff1b1c1d),
      onSurfaceVariant: Color(0xff44474c),
      outline: Color(0xff74777d),
      outlineVariant: Color(0xffc4c6cd),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff303032),
      inversePrimary: Color(0xffb7c8df),
      primaryFixed: Color(0xffd3e4fb),
      onPrimaryFixed: Color(0xff0c1d2d),
      primaryFixedDim: Color(0xffb7c8df),
      onPrimaryFixedVariant: Color(0xff38485b),
      secondaryFixed: Color(0xffdde3ed),
      onSecondaryFixed: Color(0xff161c23),
      secondaryFixedDim: Color(0xffc1c7d1),
      onSecondaryFixedVariant: Color(0xff41474f),
      tertiaryFixed: Color(0xfff8d9f3),
      onTertiaryFixed: Color(0xff271527),
      tertiaryFixedDim: Color(0xffdbbed7),
      onTertiaryFixedVariant: Color(0xff554054),
      surfaceDim: Color(0xffdbd9db),
      surfaceBright: Color(0xfffbf9fa),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff5f3f4),
      surfaceContainer: Color(0xffefedef),
      surfaceContainerHigh: Color(0xffeae7e9),
      surfaceContainerHighest: Color(0xffe4e2e3),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff283749),
      surfaceTint: Color(0xff506073),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff5e6e82),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff31373e),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff686d76),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff442f43),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff7d657b),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff740006),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffcf2c27),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffbf9fa),
      onSurface: Color(0xff101112),
      onSurfaceVariant: Color(0xff33363b),
      outline: Color(0xff4f5358),
      outlineVariant: Color(0xff6a6d73),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff303032),
      inversePrimary: Color(0xffb7c8df),
      primaryFixed: Color(0xff5e6e82),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff465669),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff686d76),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff4f555e),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff7e667c),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff644e63),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffc7c6c7),
      surfaceBright: Color(0xfffbf9fa),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff5f3f4),
      surfaceContainer: Color(0xffeae7e9),
      surfaceContainerHigh: Color(0xffdedcde),
      surfaceContainerHighest: Color(0xffd3d1d3),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff1d2d3f),
      surfaceTint: Color(0xff506073),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff3b4a5d),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff272d34),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff444a52),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff392639),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff584257),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff600004),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff98000a),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffbf9fa),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff000000),
      outline: Color(0xff292c31),
      outlineVariant: Color(0xff46494f),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff303032),
      inversePrimary: Color(0xffb7c8df),
      primaryFixed: Color(0xff3b4a5d),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff243446),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff444a52),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff2d333b),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff584257),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff402c3f),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffbab8ba),
      surfaceBright: Color(0xfffbf9fa),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff2f0f2),
      surfaceContainer: Color(0xffe4e2e3),
      surfaceContainerHigh: Color(0xffd6d4d5),
      surfaceContainerHighest: Color(0xffc7c6c7),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffb7c8df),
      surfaceTint: Color(0xffb7c8df),
      onPrimary: Color(0xff223243),
      primaryContainer: Color(0xff5e6e82),
      onPrimaryContainer: Color(0xffe7f0ff),
      secondary: Color(0xffc1c7d1),
      onSecondary: Color(0xff2b3139),
      secondaryContainer: Color(0xff444952),
      onSecondaryContainer: Color(0xffb3b9c2),
      tertiary: Color(0xffdbbed7),
      onTertiary: Color(0xff3e2a3d),
      tertiaryContainer: Color(0xff7d657b),
      onTertiaryContainer: Color(0xffffe9fa),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff131315),
      onSurface: Color(0xffe4e2e3),
      onSurfaceVariant: Color(0xffc4c6cd),
      outline: Color(0xff8e9197),
      outlineVariant: Color(0xff44474c),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe4e2e3),
      inversePrimary: Color(0xff506073),
      primaryFixed: Color(0xffd3e4fb),
      onPrimaryFixed: Color(0xff0c1d2d),
      primaryFixedDim: Color(0xffb7c8df),
      onPrimaryFixedVariant: Color(0xff38485b),
      secondaryFixed: Color(0xffdde3ed),
      onSecondaryFixed: Color(0xff161c23),
      secondaryFixedDim: Color(0xffc1c7d1),
      onSecondaryFixedVariant: Color(0xff41474f),
      tertiaryFixed: Color(0xfff8d9f3),
      onTertiaryFixed: Color(0xff271527),
      tertiaryFixedDim: Color(0xffdbbed7),
      onTertiaryFixedVariant: Color(0xff554054),
      surfaceDim: Color(0xff131315),
      surfaceBright: Color(0xff39393a),
      surfaceContainerLowest: Color(0xff0d0e0f),
      surfaceContainerLow: Color(0xff1b1c1d),
      surfaceContainer: Color(0xff1f2021),
      surfaceContainerHigh: Color(0xff292a2b),
      surfaceContainerHighest: Color(0xff343536),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffcddef5),
      surfaceTint: Color(0xffb7c8df),
      onPrimary: Color(0xff172738),
      primaryContainer: Color(0xff8292a7),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffd7dde7),
      onSecondary: Color(0xff20262e),
      secondaryContainer: Color(0xff8b919a),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xfff2d3ed),
      onTertiary: Color(0xff321f32),
      tertiaryContainer: Color(0xffa389a0),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffd2cc),
      onError: Color(0xff540003),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff131315),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffdadce3),
      outline: Color(0xffafb2b8),
      outlineVariant: Color(0xff8e9096),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe4e2e3),
      inversePrimary: Color(0xff39495c),
      primaryFixed: Color(0xffd3e4fb),
      onPrimaryFixed: Color(0xff021222),
      primaryFixedDim: Color(0xffb7c8df),
      onPrimaryFixedVariant: Color(0xff283749),
      secondaryFixed: Color(0xffdde3ed),
      onSecondaryFixed: Color(0xff0c1219),
      secondaryFixedDim: Color(0xffc1c7d1),
      onSecondaryFixedVariant: Color(0xff31373e),
      tertiaryFixed: Color(0xfff8d9f3),
      onTertiaryFixed: Color(0xff1c0b1c),
      tertiaryFixedDim: Color(0xffdbbed7),
      onTertiaryFixedVariant: Color(0xff442f43),
      surfaceDim: Color(0xff131315),
      surfaceBright: Color(0xff444446),
      surfaceContainerLowest: Color(0xff070708),
      surfaceContainerLow: Color(0xff1d1e1f),
      surfaceContainer: Color(0xff272829),
      surfaceContainerHigh: Color(0xff323234),
      surfaceContainerHighest: Color(0xff3d3d3f),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffe8f1ff),
      surfaceTint: Color(0xffb7c8df),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffb3c4db),
      onPrimaryContainer: Color(0xff000c1b),
      secondary: Color(0xffebf0fa),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffbdc3cd),
      onSecondaryContainer: Color(0xff060c12),
      tertiary: Color(0xffffeafa),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffd7bad3),
      onTertiaryContainer: Color(0xff150516),
      error: Color(0xffffece9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffaea4),
      onErrorContainer: Color(0xff220001),
      surface: Color(0xff131315),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xffeef0f6),
      outlineVariant: Color(0xffc0c2c9),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe4e2e3),
      inversePrimary: Color(0xff39495c),
      primaryFixed: Color(0xffd3e4fb),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffb7c8df),
      onPrimaryFixedVariant: Color(0xff021222),
      secondaryFixed: Color(0xffdde3ed),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffc1c7d1),
      onSecondaryFixedVariant: Color(0xff0c1219),
      tertiaryFixed: Color(0xfff8d9f3),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffdbbed7),
      onTertiaryFixedVariant: Color(0xff1c0b1c),
      surfaceDim: Color(0xff131315),
      surfaceBright: Color(0xff505051),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff1f2021),
      surfaceContainer: Color(0xff303032),
      surfaceContainerHigh: Color(0xff3b3b3d),
      surfaceContainerHighest: Color(0xff464748),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
    useMaterial3: true,
    brightness: colorScheme.brightness,
    colorScheme: colorScheme,
    textTheme: textTheme.apply(
      bodyColor: colorScheme.onSurface,
      displayColor: colorScheme.onSurface,
    ),
    scaffoldBackgroundColor: colorScheme.surface,
    canvasColor: colorScheme.surface,
    extensions: [
      RarityColors(
        ssrColor: colorScheme.brightness == Brightness.light 
          ? sSRRarity.light.color 
          : sSRRarity.dark.color,
        srColor: colorScheme.brightness == Brightness.light 
          ? sRRarity.light.color 
          : sRRarity.dark.color,
        rColor: colorScheme.brightness == Brightness.light 
          ? rRarity.light.color 
          : rRarity.dark.color,
        nColor: colorScheme.brightness == Brightness.light 
          ? nRarity.light.color 
          : nRarity.dark.color,
      ),
      RealmColors(
        ultraColor: colorScheme.brightness == Brightness.light 
          ? ultra.light.color 
          : ultra.dark.color,
        aequorColor: colorScheme.brightness == Brightness.light 
          ? aequor.light.color 
          : aequor.dark.color,
        chaosColor: colorScheme.brightness == Brightness.light 
          ? chaos.light.color 
          : chaos.dark.color,
        caroColor: colorScheme.brightness == Brightness.light 
          ? caro.light.color 
          : caro.dark.color,
      ),
    ],
  );

  /// Ultra
  static const ultra = ExtendedColor(
    seed: Color(0xffccbee0),
    value: Color(0xffccbee0),
    light: ColorFamily(
      color: Color(0xff645977),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffccbee0),
      onColorContainer: Color(0xff564c68),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(0xff645977),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffccbee0),
      onColorContainer: Color(0xff564c68),
    ),
    lightHighContrast: ColorFamily(
      color: Color(0xff645977),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffccbee0),
      onColorContainer: Color(0xff564c68),
    ),
    dark: ColorFamily(
      color: Color(0xffe8dafd),
      onColor: Color(0xff352c46),
      colorContainer: Color(0xffccbee0),
      onColorContainer: Color(0xff564c68),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(0xffe8dafd),
      onColor: Color(0xff352c46),
      colorContainer: Color(0xffccbee0),
      onColorContainer: Color(0xff564c68),
    ),
    darkHighContrast: ColorFamily(
      color: Color(0xffe8dafd),
      onColor: Color(0xff352c46),
      colorContainer: Color(0xffccbee0),
      onColorContainer: Color(0xff564c68),
    ),
  );

  /// Aequor
  static const aequor = ExtendedColor(
    seed: Color(0xffb0d7e4),
    value: Color(0xffb0d7e4),
    light: ColorFamily(
      color: Color(0xff3e646f),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffb0d7e4),
      onColorContainer: Color(0xff395e6a),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(0xff3e646f),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffb0d7e4),
      onColorContainer: Color(0xff395e6a),
    ),
    lightHighContrast: ColorFamily(
      color: Color(0xff3e646f),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffb0d7e4),
      onColorContainer: Color(0xff395e6a),
    ),
    dark: ColorFamily(
      color: Color(0xffcff3ff),
      onColor: Color(0xff0a353f),
      colorContainer: Color(0xffb0d7e4),
      onColorContainer: Color(0xff395e6a),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(0xffcff3ff),
      onColor: Color(0xff0a353f),
      colorContainer: Color(0xffb0d7e4),
      onColorContainer: Color(0xff395e6a),
    ),
    darkHighContrast: ColorFamily(
      color: Color(0xffcff3ff),
      onColor: Color(0xff0a353f),
      colorContainer: Color(0xffb0d7e4),
      onColorContainer: Color(0xff395e6a),
    ),
  );

  /// Chaos
  static const chaos = ExtendedColor(
    seed: Color(0xffdad0a8),
    value: Color(0xffdad0a8),
    light: ColorFamily(
      color: Color(0xff655f3e),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffdad0a8),
      onColorContainer: Color(0xff5f5939),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(0xff655f3e),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffdad0a8),
      onColorContainer: Color(0xff5f5939),
    ),
    lightHighContrast: ColorFamily(
      color: Color(0xff655f3e),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffdad0a8),
      onColorContainer: Color(0xff5f5939),
    ),
    dark: ColorFamily(
      color: Color(0xfff7ecc3),
      onColor: Color(0xff363114),
      colorContainer: Color(0xffdad0a8),
      onColorContainer: Color(0xff5f5939),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(0xfff7ecc3),
      onColor: Color(0xff363114),
      colorContainer: Color(0xffdad0a8),
      onColorContainer: Color(0xff5f5939),
    ),
    darkHighContrast: ColorFamily(
      color: Color(0xfff7ecc3),
      onColor: Color(0xff363114),
      colorContainer: Color(0xffdad0a8),
      onColorContainer: Color(0xff5f5939),
    ),
  );

  /// Caro
  static const caro = ExtendedColor(
    seed: Color(0xffe9a29f),
    value: Color(0xffe9a29f),
    light: ColorFamily(
      color: Color(0xff874f4d),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffe9a29f),
      onColorContainer: Color(0xff6b3736),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(0xff874f4d),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffe9a29f),
      onColorContainer: Color(0xff6b3736),
    ),
    lightHighContrast: ColorFamily(
      color: Color(0xff874f4d),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffe9a29f),
      onColorContainer: Color(0xff6b3736),
    ),
    dark: ColorFamily(
      color: Color(0xffffc0bd),
      onColor: Color(0xff512221),
      colorContainer: Color(0xffe9a29f),
      onColorContainer: Color(0xff6b3736),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(0xffffc0bd),
      onColor: Color(0xff512221),
      colorContainer: Color(0xffe9a29f),
      onColorContainer: Color(0xff6b3736),
    ),
    darkHighContrast: ColorFamily(
      color: Color(0xffffc0bd),
      onColor: Color(0xff512221),
      colorContainer: Color(0xffe9a29f),
      onColorContainer: Color(0xff6b3736),
    ),
  );

  /// SSR Rarity
  static const sSRRarity = ExtendedColor(
    seed: Color(0xfff1c660),
    value: Color(0xfff1c660),
    light: ColorFamily(
      color: Color(0xff775a00),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xfff1c660),
      onColorContainer: Color(0xff6d5200),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(0xff775a00),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xfff1c660),
      onColorContainer: Color(0xff6d5200),
    ),
    lightHighContrast: ColorFamily(
      color: Color(0xff775a00),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xfff1c660),
      onColorContainer: Color(0xff6d5200),
    ),
    dark: ColorFamily(
      color: Color(0xffffe5af),
      onColor: Color(0xff3f2e00),
      colorContainer: Color(0xfff1c660),
      onColorContainer: Color(0xff6d5200),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(0xffffe5af),
      onColor: Color(0xff3f2e00),
      colorContainer: Color(0xfff1c660),
      onColorContainer: Color(0xff6d5200),
    ),
    darkHighContrast: ColorFamily(
      color: Color(0xffffe5af),
      onColor: Color(0xff3f2e00),
      colorContainer: Color(0xfff1c660),
      onColorContainer: Color(0xff6d5200),
    ),
  );

  /// SR Rarity
  static const sRRarity = ExtendedColor(
    seed: Color(0xffd691e6),
    value: Color(0xffd691e6),
    light: ColorFamily(
      color: Color(0xff834594),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffd691e6),
      onColorContainer: Color(0xff602471),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(0xff834594),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffd691e6),
      onColorContainer: Color(0xff602471),
    ),
    lightHighContrast: ColorFamily(
      color: Color(0xff834594),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffd691e6),
      onColorContainer: Color(0xff602471),
    ),
    dark: ColorFamily(
      color: Color(0xfff1afff),
      onColor: Color(0xff4f1262),
      colorContainer: Color(0xffd691e6),
      onColorContainer: Color(0xff602471),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(0xfff1afff),
      onColor: Color(0xff4f1262),
      colorContainer: Color(0xffd691e6),
      onColorContainer: Color(0xff602471),
    ),
    darkHighContrast: ColorFamily(
      color: Color(0xfff1afff),
      onColor: Color(0xff4f1262),
      colorContainer: Color(0xffd691e6),
      onColorContainer: Color(0xff602471),
    ),
  );

  /// R Rarity
  static const rRarity = ExtendedColor(
    seed: Color(0xff84afc8),
    value: Color(0xff84afc8),
    light: ColorFamily(
      color: Color(0xff38637a),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xff84afc8),
      onColorContainer: Color(0xff124358),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(0xff38637a),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xff84afc8),
      onColorContainer: Color(0xff124358),
    ),
    lightHighContrast: ColorFamily(
      color: Color(0xff38637a),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xff84afc8),
      onColorContainer: Color(0xff124358),
    ),
    dark: ColorFamily(
      color: Color(0xffa1cce6),
      onColor: Color(0xff003549),
      colorContainer: Color(0xff84afc8),
      onColorContainer: Color(0xff124358),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(0xffa1cce6),
      onColor: Color(0xff003549),
      colorContainer: Color(0xff84afc8),
      onColorContainer: Color(0xff124358),
    ),
    darkHighContrast: ColorFamily(
      color: Color(0xffa1cce6),
      onColor: Color(0xff003549),
      colorContainer: Color(0xff84afc8),
      onColorContainer: Color(0xff124358),
    ),
  );

  /// N Rarity
  static const nRarity = ExtendedColor(
    seed: Color(0xff96bc8f),
    value: Color(0xff96bc8f),
    light: ColorFamily(
      color: Color(0xff446741),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xff96bc8f),
      onColorContainer: Color(0xff2b4c29),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(0xff446741),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xff96bc8f),
      onColorContainer: Color(0xff2b4c29),
    ),
    lightHighContrast: ColorFamily(
      color: Color(0xff446741),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xff96bc8f),
      onColorContainer: Color(0xff2b4c29),
    ),
    dark: ColorFamily(
      color: Color(0xffb1d8a9),
      onColor: Color(0xff173716),
      colorContainer: Color(0xff96bc8f),
      onColorContainer: Color(0xff2b4c29),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(0xffb1d8a9),
      onColor: Color(0xff173716),
      colorContainer: Color(0xff96bc8f),
      onColorContainer: Color(0xff2b4c29),
    ),
    darkHighContrast: ColorFamily(
      color: Color(0xffb1d8a9),
      onColor: Color(0xff173716),
      colorContainer: Color(0xff96bc8f),
      onColorContainer: Color(0xff2b4c29),
    ),
  );

  List<ExtendedColor> get extendedColors => [
    ultra,
    aequor,
    chaos,
    caro,
    sSRRarity,
    sRRarity,
    rRarity,
    nRarity,
  ];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}

@immutable
class RarityColors extends ThemeExtension<RarityColors> {
  const RarityColors({
    required this.ssrColor,
    required this.srColor,
    required this.rColor,
    required this.nColor,
  });

  final Color ssrColor;
  final Color srColor;
  final Color rColor;
  final Color nColor;
  
  // Método de conveniência para obter a cor com base no tier
  Color getTierColor(int tier) {
    return switch (tier) {
      4 => ssrColor,
      3 => srColor,
      2 => rColor,
      1 => nColor,
      _ => nColor,
    };
  }

  @override
  RarityColors copyWith({
    Color? ssrColor,
    Color? srColor,
    Color? rColor,
    Color? nColor,
  }) {
    return RarityColors(
      ssrColor: ssrColor ?? this.ssrColor,
      srColor: srColor ?? this.srColor,
      rColor: rColor ?? this.rColor,
      nColor: nColor ?? this.nColor,
    );
  }

  @override
  RarityColors lerp(ThemeExtension<RarityColors>? other, double t) {
    if (other is! RarityColors) {
      return this;
    }
    return RarityColors(
      ssrColor: Color.lerp(ssrColor, other.ssrColor, t)!,
      srColor: Color.lerp(srColor, other.srColor, t)!,
      rColor: Color.lerp(rColor, other.rColor, t)!,
      nColor: Color.lerp(nColor, other.nColor, t)!,
    );
  }
}

@immutable
class RealmColors extends ThemeExtension<RealmColors> {
  const RealmColors({
    required this.ultraColor,
    required this.aequorColor,
    required this.chaosColor,
    required this.caroColor,
  });

  final Color ultraColor;
  final Color aequorColor;
  final Color chaosColor;
  final Color caroColor;

  @override
  RealmColors copyWith({
    Color? ultraColor,
    Color? aequorColor,
    Color? chaosColor,
    Color? caroColor,
  }) {
    return RealmColors(
      ultraColor: ultraColor ?? this.ultraColor,
      aequorColor: aequorColor ?? this.aequorColor,
      chaosColor: chaosColor ?? this.chaosColor,
      caroColor: caroColor ?? this.caroColor,
    );
  }

  @override
  RealmColors lerp(ThemeExtension<RealmColors>? other, double t) {
    if (other is! RealmColors) {
      return this;
    }
    return RealmColors(
      ultraColor: Color.lerp(ultraColor, other.ultraColor, t)!,
      aequorColor: Color.lerp(aequorColor, other.aequorColor, t)!,
      chaosColor: Color.lerp(chaosColor, other.chaosColor, t)!,
      caroColor: Color.lerp(caroColor, other.caroColor, t)!,
    );
  }
}
