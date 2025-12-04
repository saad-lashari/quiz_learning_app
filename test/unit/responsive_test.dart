import 'package:flutter_test/flutter_test.dart';
import 'package:quiz_learning_app/core/utils/responsive.dart';

void main() {
  test('gridCountFromWidth returns correct breakpoints', () {
    expect(gridCountFromWidth(1300), 4);
    expect(gridCountFromWidth(1000), 3);
    expect(gridCountFromWidth(700), 2);
    expect(gridCountFromWidth(400), 2);
  });

  test('isWideLayout works', () {
    expect(isWideLayout(900), true);
    expect(isWideLayout(899.9), false);
  });
}
