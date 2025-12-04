import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../../quiz/domain/entities/user.dart';
import '../../../quiz/domain/entities/quiz_category.dart';

class HomeState extends Equatable {
  final User user;
  final List<QuizCategory> categories;

  const HomeState({required this.user, required this.categories});

  factory HomeState.initial() {
    return HomeState(
      user: const User(
        name: 'Alex Johnson',
        image: 'https://i.pravatar.cc/150?img=12',
        rank: 'Expert',
        totalScore: 0,
        quizzesTaken: 0,
        totalQuizzes: 50,
      ),
      categories: [
        const QuizCategory(
          id: 9,
          name: 'General Knowledge',
          color: Colors.blue,
        ),
        const QuizCategory(id: 19, name: 'Mathematics', color: Colors.purple),
        const QuizCategory(
          id: 17,
          name: 'Science & Nature',
          color: Colors.green,
        ),
        const QuizCategory(id: 23, name: 'History', color: Colors.orange),
        const QuizCategory(id: 21, name: 'Sports', color: Colors.red),
      ],
    );
  }

  HomeState copyWith({User? user, List<QuizCategory>? categories}) {
    return HomeState(
      user: user ?? this.user,
      categories: categories ?? this.categories,
    );
  }

  @override
  List<Object?> get props => [user, categories];
}
