import 'package:animation_practice/page/another_screen.dart';
import 'package:animation_practice/widgets/animated_container_widget.dart';
import 'package:animation_practice/widgets/animated_opacity_widget.dart';
import 'package:animation_practice/widgets/animation_controller_widget.dart';
import 'package:flutter/material.dart';

class AnimationScreen extends StatefulWidget {
  const AnimationScreen({super.key});

  @override
  State<AnimationScreen> createState() => _AnimationScreenState();
}

class _AnimationScreenState extends State<AnimationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Animation Practice')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              AnimatedContainerWidget(),
              Divider(height: 40),
              AnimatedOpacityWidget(),
              Divider(height: 40),
              AnimationControllerWidget(),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(_createAnimationForNavigation());
        },
        child: Icon(Icons.arrow_back_ios_new_sharp),
      ),
    );
  }

  Route<dynamic> _createAnimationForNavigation() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const AnotherScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0, 1);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        final tween = Tween(begin: begin, end: end);
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: curve,
        );

        return SlideTransition(
          position: tween.animate(curvedAnimation),
          child: child,
        );
      },
    );
  }
}
