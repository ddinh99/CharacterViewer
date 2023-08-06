// By: Dai Dinh
// 8/4/2023

import 'package:flutter/material.dart';
import 'package:simpsonsviewer/character_data_class.dart';
import 'package:simpsonsviewer/character_icon_widget.dart';


void showCharacterDialogBox(BuildContext context, SimpsonCharacter theChar) async {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return ZoomDialog(theChar:theChar);
    },
  );
}

class ZoomDialog extends StatefulWidget
{

  SimpsonCharacter theChar;
  ZoomDialog({required this.theChar});

  @override
  _ZoomDialogState createState() => _ZoomDialogState();
}

class _ZoomDialogState extends State<ZoomDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    _scaleAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width * 0.80;
    double screenHeight = MediaQuery.of(context).size.height * 0.80;
    bool _isPressed = false;

    return WillPopScope(
      onWillPop: () async {
        _controller.reverse().then((value) {
          Navigator.of(context).pop();
        });
        return true;
      },
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child1) => Transform.scale(
          scale: _scaleAnimation.value,
          child: Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0)),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.blue[400]!,
                    Colors.blue[300]!,
                    Colors.blue[400]!,
                    Colors.blue[600]!,
                    Colors.blue[700]!,
                    Colors.blue[600]!,
                    Colors.blue[400]!,
                    Colors.blue[300]!,
                    Colors.blue[400]!,
                  ],
                  stops: const [
                    0.0,
                    0.05,
                    0.1,
                    0.5,
                    0.9,
                    0.95,
                    1.0,
                    1.0,
                    1.0,
                  ],
                ),
                color: Colors.teal,
                borderRadius: BorderRadius.circular(10.0),
              ),
              width: screenWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    height: 50.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.blue[400]!,
                          Colors.blue[300]!,
                          Colors.blue[400]!,
                          Colors.blue[600]!,
                          Colors.blue[700]!,
                          Colors.blue[600]!,
                          Colors.blue[400]!,
                          Colors.blue[300]!,
                          Colors.blue[400]!,
                        ],
                        stops: const [
                          0.0,
                          0.05,
                          0.1,
                          0.5,
                          0.9,
                          0.95,
                          1.0,
                          1.0,
                          1.0,
                        ],
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const SizedBox(width: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                            SizedBox(width:screenWidth-90,
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  widget.theChar.charName,
                                  style: const TextStyle(
                                    fontSize: 28.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                            // _controller.reverse().then((value) {
                            //   if (mounted)
                            //   {
                            //     Navigator.of(context).pop();
                            //   }
                            // });
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: Icon(
                              Icons.close,
                              size: 30.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    width:(screenWidth<screenHeight)?200:100,
                      height:(screenWidth<screenHeight)?200:100,
                      child: ImageWithPlaceholder(imageUrl: 'https://duckduckgo.com${widget.theChar.iconURL}')),
                  Expanded(
                    child: FractionallySizedBox(
                      heightFactor: 0.95,
                      child: Padding(
                        padding: const EdgeInsets.only(top:0.0,left:10,right:10),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.grey,
                            border: Border.all(width: 1.0, color: Colors.grey),
                          ),

                          // child: MyListView()
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(widget.theChar.text),
                          )
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
