import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quiz_learning_app/core/utils/app_utils.dart';

void main() {
  group('isSmalllDevice()', () {
    testWidgets('returns true when screen width is smaller than breakpoint', (
      tester,
    ) async {
      const testWidth = 500.0; // smaller than AppConstants.webAppWidth

      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(size: Size(testWidth, 800)),
          child: Builder(
            builder: (context) {
              final result = isSmalllDevice(context);
              expect(result, true);
              return Container();
            },
          ),
        ),
      );
    });

    testWidgets('returns false when screen width is bigger than breakpoint', (
      tester,
    ) async {
      const testWidth = 1200.0; // larger than AppConstants.webAppWidth

      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(size: Size(testWidth, 800)),
          child: Builder(
            builder: (context) {
              final result = isSmalllDevice(context);
              expect(result, false);
              return Container();
            },
          ),
        ),
      );
    });
  });
}
