import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simpsonsviewer/split_view_widget.dart';

void main() {
  testWidgets('SplitView handles drag event correctly', (WidgetTester tester) async {
    final leftChild = Container(color: Colors.red);
    final rightChild = Container(color: Colors.blue);

    await tester.pumpWidget(
      MaterialApp(
        home: SplitView(
          initialWeight: 0.3,
          leftChild: leftChild,
          rightChild: rightChild,
        ),
      ),
    );

    // Simulate a drag event to the right
    await tester.drag(find.byType(GestureDetector), const Offset(100.0, 0.0));
    await tester.pump();

    // Validate that the widgets are updated as expected
    expect(find.byWidget(leftChild), findsOneWidget);
    expect(find.byWidget(rightChild), findsOneWidget);
  });
}