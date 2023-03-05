import 'package:flutter/material.dart';

class Palette {
  static var primary = const Color(0xff000000);
  static const primaryLight = Color(0xff000000);
  static const primaryDark = Color(0xff000000);
  static var secondary = const Color(0xff172983);
  static const secondaryLight = Color(0xff172983);
  static const secondaryDark = Color(0xff172983);
  static const error = Color(0xffE2001A);
  static const errorLight = Color(0xff);
  static const errorDark = Color(0xffE2001A);
  static const success = Color(0xff17B9A0);
  static const successLight = Color(0xff17B9A0);
  static const successDark = Color(0xff17B9A0);
  static const warning = Color(0xfff3a51b);
  static const warningLight = Color(0xfff6bb54);
  static const warningDark = Color(0xffb67b14);
  static const button = Color(0xff172983);

  static const whiteThree = Color(0xfff6f6f6);
  static const grey_05_f6f6f6 = Color(0x05f6f6f6);
  static const greyF6F6F6 = Color(0xfff6f6f6);
  static const brownGrey = Color(0xff7a7a7a);
  static const veryLightPink = Color(0xffe2e2e2);

  static const grey_80_797979 = Color(0xff797979);
  static const grey_60_9a9a9a = Color(0xff9a9a9a);
  static const dark_333333 = Color(0xff333333);

  // ignore: constant_identifier_names
  static const grey_main_575757 = Color(0xff575757);

  // ignore: constant_identifier_names
  static const grey_40_bcbcbc = Color(0xffbcbcbc);

  // ignore: constant_identifier_names
  static const grey_20_dddddd = Color(0xffdddddd);

  // ignore: constant_identifier_names
  static const lightgrey_f3f3f2 = Color(0xfff3f3f2);
  static const white = Color(0xffffffff);

  // ignore: constant_identifier_names
  static const grey_50_ababab = Color(0xffababab);
  static const black = Color(0xff000000);

  static const obsolete = Color(0xfff5f5f5);

  // ignore: constant_identifier_names
  static const obsolete_d7d7d7_obsolete = Color(0xffd7d7d7);

  // ignore: constant_identifier_names
  static const obsolete_595959_obsolete = Color(0xff595959);

  // ignore: constant_identifier_names
  static const obsolete_aaaaaa_obsolete = Color(0xffaaaaaa);

  // ignore: constant_identifier_names
  static const grey_10_eeeeee = Color(0xffeeeeee);

  // ignore: constant_identifier_names
  static const grey_979797 = Color(0xff979797);

  // ignore: constant_identifier_names
  static const violet_ab517c = Color(0xffab517c);

  // ignore: constant_identifier_names
  static const orange_ef7844 = Color(0xffef7844);

  // ignore: constant_identifier_names
  static const light_blue_5995ed = Color(0xff5995ed);

  static const messageDetailsColor = Color(0xffd8d8d8);

  static const opacity18 = 0x2F;
  static const opacity20 = 0x33;
  static const opacity34 = 0x57;
  static const opacity83 = 0xD4;
  static const opacity90 = 0xE6;

  static void changePrimaryColors(
      {String? primaryColor, String? secondaryColor}) {
    if (primaryColor!.isNotEmpty) {
      Color colorPrimary = HexColor(primaryColor!);
      primary = colorPrimary;
    }

    if (secondaryColor != null && secondaryColor.isNotEmpty) {
      Color colorSecondary = HexColor(secondaryColor);
      secondary = colorSecondary;
    }
  }

  static void resetPrimaryColors() {
    primary = primary = const Color(0xff000000);
    secondary = const Color(0xff172983);
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    String color = hexColor.toUpperCase().replaceAll('#', '');
    if (color.length == 6) {
      color = 'FF$hexColor';
    }
    return int.parse(color, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

}