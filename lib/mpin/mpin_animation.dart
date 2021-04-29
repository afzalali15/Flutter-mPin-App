import 'package:flutter/material.dart';

class MPinAnimationController {
  void Function() animate;
}

class MPinAnimation extends StatefulWidget {
  final MPinAnimationController controller;

  const MPinAnimation({Key key, this.controller}) : super(key: key);
  @override
  _MPinAnimationState createState() => _MPinAnimationState(controller);
}

class _MPinAnimationState extends State<MPinAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _sizeAnimation;
  Animation<double> _opacityAnimation;

  void animate() {
    _controller.forward();
  }

  _MPinAnimationState(controller) {
    controller.animate = animate;
  }

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
    _controller.addListener(() {
      if (_controller.status == AnimationStatus.completed)
        _controller.reverse();
      setState(() {});
    });
    _sizeAnimation = Tween<double>(begin: 24, end: 72).animate(_controller);
    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _sizeAnimation.value,
      width: _sizeAnimation.value,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(_sizeAnimation.value / 2),
        color: Colors.white,
      ),
      child: Opacity(
        opacity: _opacityAnimation.value,
        child: Transform.scale(
          scale: _sizeAnimation.value / 48,
          child: Text(
            '1',
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
