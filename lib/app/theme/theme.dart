import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final theme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorSchemeSeed: Colors.deepPurple,
  textTheme: GoogleFonts.robotoTextTheme(ThemeData.dark().textTheme),

  scaffoldBackgroundColor: const Color(0XFF0F0F0F),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF1F1F1F),
    elevation: 0,
  ),
);
