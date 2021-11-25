import 'package:flutter/material.dart';

class ThemeChanger with ChangeNotifier {
  // Propiedad privada
  ThemeData _themeData;

  // Constructor
  ThemeChanger(this._themeData);

  getTheme() => _themeData;

  // Establece el valor que recibe
  setTheme(ThemeData theme) {
    this._themeData = theme;
    // Notifica a todos los hijos que escuchen la clase.
    notifyListeners();
  }
}
