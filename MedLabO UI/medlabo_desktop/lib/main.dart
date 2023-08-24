import 'package:flutter/material.dart';
import 'src/config/themes/app_theme.dart';
import 'src/utils/constants/strings.dart';

void main() {
  runApp(const MedLabOApp());
}

class MedLabOApp extends StatelessWidget {
  const MedLabOApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      home: Scaffold(),
    );
  }
}
