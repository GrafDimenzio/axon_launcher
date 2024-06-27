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
    listTileTheme: ListTileThemeData(
      iconColor: colorScheme.onPrimary,
      titleTextStyle: primaryTextStyle,
      subtitleTextStyle: primaryTextStyle,
      enableFeedback: true,
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
