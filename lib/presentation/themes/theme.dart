import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'palette.dart';
import 'text_styles.dart';

class AppTheme {
  static ThemeData androidTheme() {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: Palette.primary,
      highlightColor: Palette.primary.withAlpha(Palette.opacity20),
      splashColor: Palette.primary.withAlpha(Palette.opacity20),
      fontFamily: "Lato",
      primaryColorBrightness: Brightness.dark,
      scaffoldBackgroundColor: Palette.obsolete,
      indicatorColor: Palette.primary,
      textTheme: TextTheme(
        button: TextStyles.button,
      ),
      buttonTheme: ButtonThemeData(
        height: 48.0,
        buttonColor: Palette.primary,
        textTheme: ButtonTextTheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
      ),
      cupertinoOverrideTheme: cupertinoTheme(),
      cardTheme: CardTheme(
        elevation: 1.0,
        color: Palette.white,
        shape: RoundedRectangleBorder(borderRadius: const BorderRadius.all(Radius.circular(4))),
      ),
    );
  }

  static CupertinoThemeData cupertinoTheme() {
    return CupertinoThemeData(
        brightness: Brightness.light,
        primaryColor: Palette.primary,
        primaryContrastingColor: Palette.primary,
        scaffoldBackgroundColor: Palette.obsolete,
        barBackgroundColor: Palette.obsolete,
        textTheme: const CupertinoTextThemeData(
            primaryColor: Palette.black,
            dateTimePickerTextStyle: TextStyle(
                color: Palette.dark_333333,
                fontSize: 23
            )
        )
    );
  }
}