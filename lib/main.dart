import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:udemy_flutter_chat/screen/auth.dart';

import 'Theme/theme.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Chat',
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: kDarkColorScheme,
        appBarTheme: ThemeData.dark().appBarTheme.copyWith(
              foregroundColor: kDarkColorScheme.onPrimaryContainer,
              backgroundColor: kDarkColorScheme.primaryContainer,
            ),
        cardTheme: ThemeData.dark().cardTheme.copyWith(
              color: kDarkColorScheme.secondaryContainer,
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            ),
        textTheme: ThemeData.dark().textTheme.copyWith(
              titleSmall: GoogleFonts.ubuntuCondensed(
                fontWeight: FontWeight.bold,
              ),
              titleMedium: GoogleFonts.ubuntuCondensed(
                fontWeight: FontWeight.bold,
              ),
              titleLarge: GoogleFonts.ubuntuCondensed(
                fontWeight: FontWeight.bold,
                color: kDarkColorScheme.onSecondaryContainer,
              ),
            ),
      ),
      theme: ThemeData().copyWith(
        colorScheme: kColorScheme,
        appBarTheme: ThemeData().appBarTheme.copyWith(
              foregroundColor: kColorScheme.onPrimaryContainer,
              backgroundColor: kColorScheme.primaryContainer,
            ),
        cardTheme: ThemeData().cardTheme.copyWith(
              color: kColorScheme.secondaryContainer,
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            ),
        textTheme: ThemeData().textTheme.copyWith(
              titleSmall: GoogleFonts.ubuntuCondensed(
                fontWeight: FontWeight.bold,
              ),
              titleMedium: GoogleFonts.ubuntuCondensed(
                fontWeight: FontWeight.bold,
              ),
              titleLarge: GoogleFonts.ubuntuCondensed(
                fontWeight: FontWeight.bold,
                color: kDarkColorScheme.onSecondaryContainer,
              ),
            ),
      ),
      themeMode: ThemeMode.system,
      home: const AuthScreen(),
    );
  }
}
