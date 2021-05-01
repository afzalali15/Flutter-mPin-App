import 'package:flutter/material.dart';
import 'package:mpin_app/mpin/mpin_widget.dart';

class MPinPage extends StatefulWidget {
  @override
  _MPinPageState createState() => _MPinPageState();
}

class _MPinPageState extends State<MPinPage> {
  MPinController mPinController = MPinController();
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // MPinAnimation(
                  //   controller: animationController,
                  // ),
                  MPinWidget(
                    pinLegth: 5,
                    controller: mPinController,
                  ),
                  MaterialButton(
                    onPressed: () {
                      mPinController.addInput('1');
                    },
                    color: Colors.white,
                    child: Text(
                      '1',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      mPinController.addInput('2');
                    },
                    color: Colors.white,
                    child: Text(
                      '2',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      mPinController.delete();
                    },
                    color: Colors.white,
                    child: Text(
                      '<',
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
