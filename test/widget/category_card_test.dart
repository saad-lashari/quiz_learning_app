import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz_learning_app/features/home/presentation/widgets/category_card.dart';
import 'package:quiz_learning_app/features/quiz/domain/entities/quiz_category.dart';

void main() {
  testWidgets('CategoryCard displays name and Start Quiz', (tester) async {
    final category = QuizCategory(
      id: 1,
      name: 'Science',
      color: Colors.blue,
      completed: 2,
      total: 10,
    );

    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(360, 690),
        builder: (_, __) => MaterialApp(
          home: Scaffold(
            body: CategoryCard(category: category, onTap: () {}),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Science'), findsOneWidget);
    expect(find.text('Start Quiz'), findsOneWidget);
  });
}
