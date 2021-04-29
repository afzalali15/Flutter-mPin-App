import 'package:flutter/material.dart';
import 'mpin_animation.dart';

class MPinPage extends StatefulWidget {
  @override
  _MPinPageState createState() => _MPinPageState();
}

class _MPinPageState extends State<MPinPage> {
  MPinAnimationController animationController = MPinAnimationController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [Colors.blue, Colors.purple, Colors.pink],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )),
          ),
          SafeArea(
            child: Center(
              child: Column(
                children: [
                  MPinAnimation(
                    controller: animationController,
                  ),
                  MaterialButton(
                    onPressed: () {
                      animationController.animate();
                    },
                    color: Colors.white,
                    child: Text(
                      'Animate',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
