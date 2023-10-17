import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:imc_app/pages/imc_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: const CreateIMCPage(),
        theme: ThemeData(
            textTheme: GoogleFonts.robotoTextTheme(),
            primarySwatch: Colors.red));
  }
}
