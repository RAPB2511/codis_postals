import 'package:flutter/material.dart';

class AppStyles {
  // Colores principales
  static const Color primaryColor = Colors.teal;
  static const Color backgroundColor = Color(0xFFF5F5F5);
  static const Color cardColor = Colors.white;
  static const Color textColor = Color(0xFF333333);
  static const Color subtitleColor = Color(0xFF666666);
  static const Color errorColor = Colors.redAccent;

  // Espaciados
  static const double paddingS = 8.0;
  static const double paddingM = 16.0;
  static const double paddingL = 24.0;

  // Estilos de texto
  static const TextStyle titleStyle = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: textColor,
  );

  static const TextStyle subtitleStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: subtitleColor,
  );

  static const TextStyle bodyStyle = TextStyle(fontSize: 14, color: textColor);

  static const TextStyle infoMessageStyle = TextStyle(
    fontSize: 16,
    color: subtitleColor,
    fontStyle: FontStyle.italic,
  );
}
