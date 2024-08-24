import 'package:app_pragma_prueba/config/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CustomPetLoadingIndicator extends StatefulWidget {
  const CustomPetLoadingIndicator({super.key});

  @override
  State<CustomPetLoadingIndicator> createState() =>
      _CustomPetLoadingIndicatorState();
}

class _CustomPetLoadingIndicatorState extends State<CustomPetLoadingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0, end: 20).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _opacityAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double maxSize = constraints.biggest.shortestSide;

        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, _animation.value),
              child: Opacity(
                opacity: _opacityAnimation.value,
                child: Icon(
                  Icons.pets,
                  size: maxSize * 0.8,
                  color: appTheme.colorSeed,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
