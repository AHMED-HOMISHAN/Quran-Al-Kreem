// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:islamic/constant.dart';
import 'package:islamic/screens/SplashScreen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'اّيات القراّن الكريم',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        textTheme: GoogleFonts.cairoTextTheme(Theme.of(context).textTheme),
        colorScheme:
            ColorScheme.fromSwatch().copyWith(secondary: kPrimaryColor),
        canvasColor: kBackgroundColor,
        cardColor: kBackgroundColor,
        textSelectionTheme:
            const TextSelectionThemeData(cursorColor: kPrimaryColor),
      ),
      // Arabic RTL
      localizationsDelegates: const [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [Locale("ar", "AE")],
      locale: const Locale("ar", "AE"),

      home: const SplashScreen(),
    );
  }
}
