import 'package:flutter/material.dart';

class AnimatedOpacityWidget extends StatefulWidget {
  const AnimatedOpacityWidget({super.key});

  @override
  State<AnimatedOpacityWidget> createState() => _AnimatedOpacityWidgetState();
}

class _AnimatedOpacityWidgetState extends State<AnimatedOpacityWidget> {
  bool _visible = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedOpacity(
          opacity: _visible ? 1 : 0,
          duration: const Duration(milliseconds: 500),
          child: Container(width: 100, height: 100, color: Colors.green),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          child: const Text('Animate'),
          onPressed: () {
            setState(() {
              _visible = !_visible;
            });
          },
        ),
      ],
    );
  }
}
