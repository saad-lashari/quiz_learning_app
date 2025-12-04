import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quiz_learning_app/features/home/presentation/view/home_page.dart';
import 'package:quiz_learning_app/features/quiz/domain/entities/quiz_category.dart';
import 'package:quiz_learning_app/features/quiz/presentation/view/countdown_page.dart';
import 'package:quiz_learning_app/features/quiz/presentation/view/quiz_page.dart';
import 'package:quiz_learning_app/features/quiz/presentation/view/results_page.dart';

class AppRouter {
  static const String home = '/';
  static const String countdown = '/countdown';
  static const String quiz = '/quiz';
  static const String results = '/results';

  late final GoRouter router = GoRouter(
    initialLocation: home,
    routes: [
      GoRoute(path: home, builder: (context, state) => const HomePage()),
      GoRoute(
        path: countdown,
        builder: (context, state) {
          final category = state.extra as QuizCategory;
          return CountdownPage(category: category);
        },
      ),
      GoRoute(
        path: quiz,
        builder: (context, state) {
          final category = state.extra as QuizCategory;
          return QuizPage(category: category);
        },
      ),
      GoRoute(
        path: results,
        builder: (context, state) {
          final data = state.extra as Map<String, dynamic>;
          return ResultsPage(
            score: data['score'] as int,
            totalQuestions: data['totalQuestions'] as int,
            answers: data['answers'] as List<Map<String, dynamic>>,
            category: data['category'] as QuizCategory,
          );
        },
      ),
    ],
  );
}
