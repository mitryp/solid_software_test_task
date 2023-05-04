import 'package:flutter/material.dart';
import 'package:solid_software_test_task/src/color/next_color_selection_strategy.dart';

/// A function that takes a [BuildContext] and a [Color] on top of which it will
/// be displayed and returns a widget that is supposed to have a good contrast
/// to be comfortably seen.
typedef BackgroundAwareBuilder = Widget Function(
  BuildContext context,
  Color backgroundColor,
);

/// A widget that displays its child on a background defined by a
/// [NextColorSelectionStrategy].
///
/// The child of this widget is built using [BackgroundAwareBuilder] to provide
/// it with the information needed to retain contrast.
///
/// This widget changes its background color every time it receives a tap or
/// click according to its [backgroundSelectionStrategy].
/// The color change is animated and its duration must be set using
/// [colorChangeDuration].
class ColoredBackground extends StatefulWidget {
  /// A function that builds the child of this widget.
  /// Must take [BuildContext] and current background [Color] of this
  /// [ColoredBackground] widget.
  final BackgroundAwareBuilder childBuilder;

  /// A [NextColorSelectionStrategy] object that is used to define the next
  /// background color based on the current background color.
  ///
  /// The [NextColorSelectionStrategy.nextColor] method of this object will be
  /// called each time user presses on this widget.
  final NextColorSelectionStrategy backgroundSelectionStrategy;

  /// The alignment of the container of the child of this widget.
  final Alignment alignment;

  /// The [Duration] of the animation of the color change.
  final Duration colorChangeDuration;

  /// Constructs a new [ColoredBackground] widget.
  ///
  /// Can take [Alignment] as an optional [alignment] argument, which defines
  /// the alignment of the child of this widget built with the [childBuilder].
  const ColoredBackground({
    required this.childBuilder,
    required this.backgroundSelectionStrategy,
    required this.colorChangeDuration,
    this.alignment = Alignment.center,
    super.key,
  });

  @override
  State<ColoredBackground> createState() => _ColoredBackgroundState();
}

class _ColoredBackgroundState extends State<ColoredBackground>
    with SingleTickerProviderStateMixin {
  // I have disabled the lint for late variables as it makes no sense for me
  // in the context of their usage in my project.
  // There is no point in making this field nullable, and Flutter team never
  // passes arguments into the State constructors in the standard library.
  late Color _backgroundColor = widget.backgroundSelectionStrategy.nextColor();

  late final AnimationController _animationController =
      AnimationController(vsync: this, duration: widget.colorChangeDuration);
  late final ColorTween _colorTween = ColorTween(end: _backgroundColor);
  late Animation<Color?> _colorAnimation;

  Color _nextColor() =>
      widget.backgroundSelectionStrategy.nextColor(_backgroundColor);

  @override
  void initState() {
    super.initState();
    _updateAnimation();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: _colorAnimation.value,
      child: InkWell(
        onTap: _processTap,
        child: Align(
          alignment: widget.alignment,
          child: widget.childBuilder.call(context, _backgroundColor),
        ),
      ),
    );
  }

  void _processTap() {
    _backgroundColor = _nextColor();

    _colorAnimation.removeListener(_animationUpdateCallback);

    _colorTween.begin = _colorAnimation.value;
    _colorTween.end = _backgroundColor;

    _animationController.reset();

    _updateAnimation();

    _animationController.forward();
  }

  void _updateAnimation() {
    _colorAnimation = _colorTween.animate(_animationController)
      ..addListener(_animationUpdateCallback);
  }

  void _animationUpdateCallback() => setState(() {});
}
