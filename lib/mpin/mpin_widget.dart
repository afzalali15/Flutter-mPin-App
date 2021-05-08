import 'package:flutter/material.dart';
import 'package:mpin_app/mpin/mpin_animation.dart';

class MPinController {
  void Function(String) addInput;
  void Function() delete;
  void Function() notifyWrongInput;
}

class MPinWidget extends StatefulWidget {
  final int pinLegth;
  final MPinController controller;
  final Function(String) onCompleted;

  const MPinWidget(
      {Key key, @required this.pinLegth, this.controller, this.onCompleted})
      : assert(pinLegth <= 6 && pinLegth > 0),
        super(key: key);
  @override
  _MPinWidgetState createState() => _MPinWidgetState(controller);
}

class _MPinWidgetState extends State<MPinWidget>
    with SingleTickerProviderStateMixin {
  List<MPinAnimationController> _animationControllers;
  AnimationController _wrongInputAnimationController;
  Animation<double> _wiggleAnimation;
  String mPin = '';

  _MPinWidgetState(MPinController controller) {
    controller?.addInput = addInput;
    controller?.delete = delete;
    controller?.notifyWrongInput = notifyWrongInput;
  }

  void addInput(String input) async {
    mPin += input;
    if (mPin.length < widget.pinLegth) {
      _animationControllers[mPin.length - 1].animate(input);
    } else if (mPin.length == widget.pinLegth) {
      _animationControllers[mPin.length - 1].animate(input);
      await Future.delayed(Duration(milliseconds: 300));
      widget.onCompleted?.call(mPin);
      mPin = '';
    }
  }

  void delete() {
    if (mPin.isNotEmpty) {
      mPin = mPin.substring(0, mPin.length - 1);
      _animationControllers[mPin.length].animate('');
    }
  }

  void notifyWrongInput() {
    _wrongInputAnimationController.forward();
    _animationControllers.forEach((controller) {
      controller.clear();
    });
  }

  @override
  void initState() {
    super.initState();
    _animationControllers = List.generate(widget.pinLegth, (index) {
      return MPinAnimationController();
    });

    _wrongInputAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed)
          _wrongInputAnimationController.reverse();
      });

    _wiggleAnimation = Tween<double>(begin: 0.0, end: 24.0).animate(
      CurvedAnimation(
          parent: _wrongInputAnimationController, curve: Curves.elasticIn),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(_wiggleAnimation.value, 0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(widget.pinLegth, (index) {
          return MPinAnimation(
            controller: _animationControllers[index],
          );
        }),
      ),
    );
  }
}
