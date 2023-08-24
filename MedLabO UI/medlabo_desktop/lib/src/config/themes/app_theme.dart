import 'package:flutter/material.dart';

abstract class AppTheme {
  static ThemeData get light {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        color: Color.fromARGB(255, 5, 62, 108),
      ),
      scaffoldBackgroundColor: Colors.white,
      primaryColor: const Color.fromARGB(255, 5, 62, 108),
      splashColor: Colors.pink,
      fontFamily: 'IBM',
      colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.black),
    );
  }

  static ThemeData get dark {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        color: Color.fromARGB(255, 5, 62, 108),
      ),
      scaffoldBackgroundColor: const Color.fromARGB(255, 69, 69, 69),
      primaryColor: const Color.fromARGB(255, 5, 62, 108),
      splashColor: Colors.pink,
      fontFamily: 'IBM',
      colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.black),
    );
  }
}
