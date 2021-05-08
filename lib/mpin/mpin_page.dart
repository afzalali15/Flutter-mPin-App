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
                  MPinWidget(
                    pinLegth: 5,
                    controller: mPinController,
                    onCompleted: (mPin) {
                      print('You entered -> $mPin');
                      if (mPin == '12345') {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Success'),
                                content: Text('Go to next page'),
                              );
                            });
                      } else {
                        //animate wrong input
                        mPinController.notifyWrongInput();
                      }
                    },
                  ),
                  SizedBox(height: 32),
                  GridView.count(
                    crossAxisCount: 3,
                    shrinkWrap: true,
                    childAspectRatio: 1.6,
                    children: List.generate(
                        9, (index) => buildMaterialButton(index + 1)),
                  ),
                  GridView.count(
                    crossAxisCount: 3,
                    shrinkWrap: true,
                    childAspectRatio: 1.6,
                    children: [
                      MaterialButton(
                        onPressed: () {
                          // mPinController.addInput('$input');
                        },
                        textColor: Colors.white,
                        child: Icon(Icons.fingerprint),
                      ),
                      buildMaterialButton(0),
                      MaterialButton(
                        onPressed: () {
                          mPinController.delete();
                        },
                        textColor: Colors.white,
                        child: Icon(Icons.backspace_rounded),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  MaterialButton buildMaterialButton(int input) {
    return MaterialButton(
      onPressed: () {
        mPinController.addInput('$input');
      },
      textColor: Colors.white,
      child: Text(
        '$input',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}
