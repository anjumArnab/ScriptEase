import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:script_ease/views/homepage.dart';

void main() => runApp(ScriptEase());

class ScriptEase extends StatelessWidget {
  const ScriptEase({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ScriptEase',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: HomePage(title: 'ScriptEase'),
    );
  }
}
