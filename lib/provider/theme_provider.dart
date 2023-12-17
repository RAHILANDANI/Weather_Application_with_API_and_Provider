import 'package:flutter/cupertino.dart';
import 'package:wheater/model/theme_model.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeModel themeModel = ThemeModel(isdark: false);

  void changetheme() {
    themeModel.isdark = !themeModel.isdark;
    notifyListeners();
  }
}
