import 'package:flutter/material.dart';

class ThemeChanger with ChangeNotifier {
  // Propiedad privada
  ThemeData _themeData;
  bool _isDark;

  // Constructor
  ThemeChanger(this._themeData, this._isDark);

  getTheme() => _themeData;
  getIsDark() => _isDark;

  // Establece el valor que recibe
  setTheme(ThemeData theme, bool isdark) {
    this._themeData = theme;
    this._isDark = isdark;
    // Notifica a todos los hijos que escuchen la clase.
    notifyListeners();
  }
}
