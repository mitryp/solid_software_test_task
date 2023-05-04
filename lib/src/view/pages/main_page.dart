import 'package:flutter/material.dart';
import 'package:solid_software_test_task/src/color/next_color_selection_strategy.dart';
import 'package:solid_software_test_task/src/view/widgets/background_aware_text.dart';
import 'package:solid_software_test_task/src/view/widgets/colored_background.dart';

/// A main page of this application. It takes all the available space and
/// contains a [ColoredBackground] widget with 'Hello world' text.
/// The content of the page changes color each time user clicks or taps the
/// screen.
class MainPage extends StatelessWidget {
  /// The font size of the 'Hello world' text widget.
  static const int fontSize = 20;

  /// The duration of color change animation.
  static const Duration colorChangeDuration = Duration(milliseconds: 250);

  /// Constructs a new [MainPage].
  /// Takes an optional [key] argument.
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: ColoredBackground(
          colorChangeDuration: colorChangeDuration,
          backgroundSelectionStrategy: const RandomNextColorStrategy(
            initialColor: Colors.white,
          ),
          childBuilder: _buildContent,
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, Color backgroundColor) {
    final textFontSize = MediaQuery.of(context).textScaleFactor * fontSize;

    return BackgroundAwareText(
      'Hello world',
      backgroundColor: backgroundColor,
      colorChangeDuration: colorChangeDuration,
      style: TextStyle(fontSize: textFontSize),
    );
  }
}
