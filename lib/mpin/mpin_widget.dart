import 'package:flutter/material.dart';
import 'package:mpin_app/mpin/mpin_animation.dart';

class MPinController {
  void Function(String) addInput;
  void Function() delete;
}

class MPinWidget extends StatefulWidget {
  final int pinLegth;
  final MPinController controller;

  const MPinWidget({Key key, @required this.pinLegth, this.controller})
      : assert(pinLegth <= 6 && pinLegth > 0),
        super(key: key);
  @override
  _MPinWidgetState createState() => _MPinWidgetState(controller);
}

class _MPinWidgetState extends State<MPinWidget> {
  List<MPinAnimationController> _animationControllers;
  String mPin = '';

  _MPinWidgetState(MPinController controller) {
    controller.addInput = addInput;
    controller.delete = delete;
  }

  void addInput(String input) {
    mPin += input;
    if (mPin.length <= widget.pinLegth) {
      _animationControllers[mPin.length - 1].animate(input);
    }
  }

  void delete() {
    mPin = mPin.substring(0, mPin.length - 1);
    if (mPin.length >= 0) _animationControllers[mPin.length].animate('');
  }

  @override
  void initState() {
    super.initState();
    _animationControllers = List.generate(widget.pinLegth, (index) {
      return MPinAnimationController();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.pinLegth, (index) {
        return MPinAnimation(
          controller: _animationControllers[index],
        );
      }),
    );
  }
}
