import 'package:flutter/material.dart';

MaterialColor customBlack = createMaterialColor(const Color(0xFF000000)); // Primary black

MaterialColor createMaterialColor(Color color) {
  List<Color> shades = <Color>[];
  for (int i = 0; i <= 9; i++) {
    double factor = i / 9.0;
    Color shade = Color.lerp(Colors.white, color, factor)!;
    shades.add(shade);
  }
  return MaterialColor(color.value, <int, Color>{
    50: shades[0],
    100: shades[1],
    200: shades[2],
    300: shades[3],
    400: shades[4],
    500: shades[5],
    600: shades[6],
    700: shades[7],
    800: shades[8],
    900: shades[9], // Primary color
  });
}