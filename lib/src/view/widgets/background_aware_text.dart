import 'package:flutter/material.dart';
import 'package:solid_software_test_task/src/color/util/contrast_shade.dart';

/// A text widget that selects its color between [Colors.white] and
/// [Colors.black] for [text] to retain the most contrast when placed on the
/// [backgroundColor].
/// The color of the
class BackgroundAwareText extends StatelessWidget {
  /// A text to be displayed.
  final String text;

  /// A color to which the text should be contrast.
  final Color backgroundColor;

  /// A [TextStyle] to be applied to the text widget.
  /// The color will be overridden by this widget.
  final TextStyle? style;

  /// The duration of the color change animation of this widget.
  final Duration colorChangeDuration;

  TextStyle get _contrastColorTextStyle =>
      TextStyle(color: computeContrastShade(backgroundColor));

  /// Constructs a new [BackgroundAwareText] widget with the given [text] value.
  /// The color of the text will be adjusted to be readable on the given
  /// [backgroundColor] color.
  /// Can take a [TextStyle] as an optional [style] argument.
  const BackgroundAwareText(
    this.text, {
    required this.backgroundColor,
    required this.colorChangeDuration,
    this.style,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedDefaultTextStyle(
      duration: colorChangeDuration,
      style: _contrastColorTextStyle.merge(style),
      child: Text(text),
    );
  }
}
