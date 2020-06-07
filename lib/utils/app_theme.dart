import 'package:flutter/material.dart';

class AppTheme {
  static bool isLightTheme = true;
  static Color primaryColors = HexColor("#223FA1");
  static Color secondaryColors = Colors.purpleAccent[100];

  static TextTheme _buildTextTheme(TextTheme base) {
    var fontName = "WorkSans";
    return base.copyWith(
      headline1: base.headline1.copyWith(fontFamily: fontName),
      headline2: base.headline2.copyWith(fontFamily: fontName),
      headline3: base.headline3.copyWith(fontFamily: fontName),
      headline4: base.headline4.copyWith(fontFamily: fontName),
      headline5: base.headline5.copyWith(fontFamily: fontName),
      headline6: base.headline6.copyWith(fontFamily: fontName),
      bodyText1: base.bodyText1.copyWith(fontFamily: fontName),
      bodyText2: base.bodyText2.copyWith(fontFamily: fontName),
      button: base.button.copyWith(fontFamily: fontName),
      caption: base.caption.copyWith(fontFamily: fontName),
      subtitle1: base.subtitle1.copyWith(fontFamily: fontName),
      subtitle2: base.subtitle2.copyWith(fontFamily: fontName),
      overline: base.overline.copyWith(fontFamily: fontName),
    );
  }

  static ThemeData getTheme() {
    if (isLightTheme) {
      return newLightTheme();
    } else {
      return newDarkTheme();
    }
  }

  static ThemeData newLightTheme() {
    Color primaryColor = primaryColors;
    Color secondaryColor = secondaryColors;
    final ColorScheme designScheme = const ColorScheme.light().copyWith(
      primary: HexColor('#653ed6'),
      secondary: HexColor('#2c0996'),
    );
    final ThemeData base = ThemeData.light();
    return base.copyWith(
      colorScheme: designScheme,
      primaryColor: primaryColor,
      primaryColorDark: Colors.black.withOpacity(0.4),
      disabledColor: Colors.black,
      buttonColor: primaryColor,
      secondaryHeaderColor: Colors.black,
      indicatorColor: Colors.white,
      splashColor: Colors.white24,
      splashFactory: InkRipple.splashFactory,
      accentColor: secondaryColor,
      canvasColor: Colors.white,
      backgroundColor: const Color(0xFFFFFFFF),
      scaffoldBackgroundColor: const Color(0xFFF6F6F6),
      errorColor: const Color(0xFFB00020),
      buttonTheme: ButtonThemeData(
        colorScheme: designScheme,
        textTheme: ButtonTextTheme.primary,
      ),
      textTheme: _buildTextTheme(base.textTheme),
      primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
      accentTextTheme: _buildTextTheme(base.accentTextTheme),
      platform: TargetPlatform.iOS,
    );
  }

  static ThemeData newDarkTheme() {
    Color primaryColor = primaryColors;
    Color secondaryColor = primaryColors;
    final ColorScheme colorScheme = const ColorScheme.light().copyWith(
      primary: primaryColor,
      secondary: secondaryColor,
    );
    final ThemeData base = ThemeData.dark();
    return base.copyWith(
      colorScheme: colorScheme,
      primaryColor: primaryColor,
      buttonColor: primaryColor,
      indicatorColor: Colors.white,
      splashColor: Colors.white24,
      splashFactory: InkRipple.splashFactory,
      accentColor: secondaryColor,
      canvasColor: Colors.white,
      backgroundColor: Colors.black,
      scaffoldBackgroundColor: const Color(0xFF0F0F0F),
      buttonTheme: ButtonThemeData(
        colorScheme: colorScheme,
        textTheme: ButtonTextTheme.primary,
      ),
      textTheme: _buildTextTheme(base.textTheme),
      primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
      accentTextTheme: _buildTextTheme(base.accentTextTheme),
      platform: TargetPlatform.iOS,
    );
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
