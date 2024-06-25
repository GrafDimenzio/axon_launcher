import 'package:flutter/material.dart';

ThemeData theme = ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        textStyle: primaryTextStyle,
      ),
    ),
    cardTheme: CardTheme(
      color: colorScheme.tertiary,
    ),
    drawerTheme:
        DrawerThemeData(backgroundColor: colorScheme.primary, elevation: 10),
    listTileTheme: ListTileThemeData(
      iconColor: colorScheme.onPrimary,
      titleTextStyle: primaryTextStyle,
      subtitleTextStyle: primaryTextStyle,
    ),
    textTheme: TextTheme(labelMedium: surfaceTextStyle));

TextStyle surfaceTextStyle = TextStyle(
  color: colorScheme.onSurface,
);

TextStyle primaryTextStyle = TextStyle(
  color: colorScheme.onPrimary,
);

TextStyle secondaryTextStyle = TextStyle(
  color: colorScheme.onSecondary,
);

ColorScheme darkcolorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xff92d2d9),
  onPrimary: Color(0xff04090a),
  secondary: Color(0xff2b3c7a),
  onSecondary: Color(0xffddf2f3),
  error: Color.fromARGB(255, 252, 56, 56),
  onError: Color(0xffddf2f3),
  tertiary: Color(0xff655cc6),
  onTertiary: Color(0xffddf2f3),
  surface: Color(0xff04090a),
  onSurface: Color(0xffddf2f3),
  surfaceContainer: Color(0xff0b1414),
);

ColorScheme lightScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xff26666d),
  onPrimary: Color(0xfff4fafb),
  secondary: Color(0xff8697d5),
  onSecondary: Color(0xff0c2122),
  error: Color.fromARGB(255, 252, 56, 56),
  onError: Color(0xffddf2f3),
  tertiary: Color(0xff655cc6),
  onTertiary: Color(0xfff4fafb),
  surface: Color(0xfff4fafb),
  onSurface: Color(0xff0c2122),
  surfaceContainer: Color(0xff0b1414),
);

ColorScheme colorScheme = ColorScheme(
  brightness: Brightness.dark,

  primary: Color(0xff2e3440),
  onPrimary: Color(0xffffffff),

  secondary: Color(0xff3b4252),
  onSecondary: Color(0xffffffff),

  error: Color.fromARGB(255, 252, 56, 56),
  onError: Color(0xffddf2f3),

  tertiary: Color(0xff434c5e),
  onTertiary: Color(0xffffffff),

  surface: Color(0xff242933),
  onSurface: Color(0xffffffff),

  surfaceContainer: Color(0xff4c566a),
);
