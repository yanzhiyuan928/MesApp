import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  MaterialColor _themeColor = Colors.blue;

  // 获取当前主题，如果为设置主题，则默认使用蓝色主题
  MaterialColor get getTheme => _themeColor;

  // 主题改变后，通知其依赖项，新主题会立即生效
  setTheme(MaterialColor color) {
    if (getTheme != color) {
      _themeColor = color;
      notifyListeners();
    }
  }
}

class LanageProvider extends ChangeNotifier {
  String _lanage = 'en';

  String get getLanage => _lanage;

  setLanage(String lanage) {
    if (getLanage != lanage) {
      _lanage = lanage;
      notifyListeners();
    }
  }
}
