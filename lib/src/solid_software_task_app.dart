import 'package:flutter/material.dart';
import 'package:solid_software_test_task/src/view/pages/main_page.dart';

/// The main widget of this application.
class SolidSoftwareTaskApp extends StatelessWidget {
  /// Constructs a new [SolidSoftwareTaskApp] widget.
  const SolidSoftwareTaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}
