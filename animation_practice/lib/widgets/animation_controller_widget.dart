import 'package:flutter/material.dart';

class AnimationControllerWidget extends StatefulWidget {
  const AnimationControllerWidget({super.key});

  @override
  State<AnimationControllerWidget> createState() =>
      _AnimationControllerWidgetState();
}

// class A extends B with C {}

class _AnimationControllerWidgetState extends State<AnimationControllerWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  late Animation<AlignmentGeometry> alignAnimation;
  late Animation<Offset> offsetAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    alignAnimation =
        Tween<AlignmentGeometry>(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ).animate(controller)..addListener(() {
          setState(() {});
        });
    offsetAnimation =
        Tween<Offset>(
          begin: const Offset(0, 1),
          end: const Offset(0, 0),
        ).animate(controller)..addListener(() {
          setState(() {});
        });

    animation = Tween<double>(begin: 0, end: 1).animate(controller)
      ..addListener(() {
        setState(() {});
      });
    // ..addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {
    //     controller.reverse();
    //   } else if (status == AnimationStatus.dismissed) {
    //     controller.forward();
    //   }
    // });

    controller.forward();

    // // add callback function
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   showBottomSheet(context: context, builder: (context) => Container());
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SlideTransition(
          position: offsetAnimation,
          // child: RotationTransition(
          //   turns: animation,
            child: FadeTransition(
              opacity: animation,
              child: Column(
                children: [],
              ),
            ),
          ),
        // ),

        ElevatedButton(child: const Text('Animate'), onPressed: () {}),
      ],
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
