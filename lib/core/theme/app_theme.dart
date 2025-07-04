import 'package:flutter/material.dart';
import 'light_color.dart';

class AppTheme {
  const AppTheme();

  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: LightColor.background,
    primaryColor: LightColor.background,
    colorScheme: const ColorScheme.light().copyWith(
      primary: LightColor.background,
      secondary: LightColor.skyBlue,
    ),
    cardTheme: const CardThemeData(color: LightColor.background),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: LightColor.black),
      bodyMedium: TextStyle(color: LightColor.black),
    ),
    iconTheme: const IconThemeData(color: LightColor.iconColor),
    dividerColor: LightColor.lightGrey,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: LightColor.background,
      iconTheme: IconThemeData(color: LightColor.iconColor),
      titleTextStyle: TextStyle(
        color: LightColor.titleTextColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: LightColor.background,
      selectedItemColor: LightColor.orange,
      unselectedItemColor: LightColor.grey,
    ),
  );

  static TextStyle titleStyle = const TextStyle(
    color: LightColor.titleTextColor,
    fontSize: 16,
  );
  static TextStyle subTitleStyle = const TextStyle(
    color: LightColor.subTitleTextColor,
    fontSize: 12,
  );

  static TextStyle h1Style = const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );
  static TextStyle h2Style = const TextStyle(fontSize: 22);
  static TextStyle h3Style = const TextStyle(fontSize: 20);
  static TextStyle h4Style = const TextStyle(fontSize: 18);
  static TextStyle h5Style = const TextStyle(fontSize: 16);
  static TextStyle h6Style = const TextStyle(fontSize: 14);

  static List<BoxShadow> shadow = <BoxShadow>[
    const BoxShadow(color: Color(0xfff8f8f8), blurRadius: 10, spreadRadius: 15),
  ];

  static EdgeInsets padding = const EdgeInsets.all(
    10,
  );
  static EdgeInsets hPadding = const EdgeInsets.symmetric(horizontal: 10);

  static double fullWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double fullHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
}
