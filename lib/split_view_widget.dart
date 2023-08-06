// By: Dai Dinh
// 8/4/2023
import 'package:flutter/material.dart';

class SplitView extends StatefulWidget {
  final double initialWeight;
  final Widget leftChild;
  final Widget rightChild;

  SplitView({
    required this.initialWeight,
    required this.leftChild,
    required this.rightChild,
  });

  @override
  _SplitViewState createState() => _SplitViewState();
}

class _SplitViewState extends State<SplitView> {
  double _weight = 0.3;
  static const double _minWeight = 0.2;
  static const double _maxWeight = 0.5;

  @override
  void initState() {
    super.initState();
    _weight = widget.initialWeight;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final leftWidth = width * _weight;

        return Row(
          children: [
            Expanded(
              flex: (_weight * 100).toInt(),
              child: widget.leftChild,
            ),
            GestureDetector(
              onHorizontalDragUpdate: (details) {
                setState(() {
                  _weight += details.delta.dx / width;
                  if (_weight < _minWeight) _weight = _minWeight;
                  if (_weight > _maxWeight) _weight = _maxWeight;
                });
              },
              child: Container(
                height: constraints.maxHeight,
                width: 5,
                color: Colors.grey,
              ),
            ),
            Expanded(
              flex: (100 - (_weight * 100)).toInt(),
              child: widget.rightChild,
            ),
          ],
        );
      },
    );
  }
}
