import 'package:equatable/equatable.dart';
import '../../domain/entities/question.dart';
import '../../domain/entities/quiz_category.dart';

abstract class QuizState extends Equatable {
  @override
  List<Object?> get props => [];
}

class QuizInitial extends QuizState {}

class QuizLoading extends QuizState {}

class QuizLoaded extends QuizState {
  final List<Question> questions;
  final int currentIndex;
  final int timeLeft;
  final String? selectedAnswer;
  final bool showFeedback;
  final int score;
  final List<Map<String, dynamic>> answers;
  final QuizCategory category;

  QuizLoaded({
    required this.questions,
    required this.currentIndex,
    required this.timeLeft,
    this.selectedAnswer,
    this.showFeedback = false,
    required this.score,
    required this.answers,
    required this.category,
  });

  QuizLoaded copyWith({
    List<Question>? questions,
    int? currentIndex,
    int? timeLeft,
    String? selectedAnswer,
    bool? showFeedback,
    int? score,
    List<Map<String, dynamic>>? answers,
    QuizCategory? category,
  }) {
    return QuizLoaded(
      questions: questions ?? this.questions,
      currentIndex: currentIndex ?? this.currentIndex,
      timeLeft: timeLeft ?? this.timeLeft,
      selectedAnswer: selectedAnswer,
      showFeedback: showFeedback ?? this.showFeedback,
      score: score ?? this.score,
      answers: answers ?? this.answers,
      category: category ?? this.category,
    );
  }

  @override
  List<Object?> get props => [
    questions,
    currentIndex,
    timeLeft,
    selectedAnswer,
    showFeedback,
    score,
    answers,
    category,
  ];
}

class QuizCompleted extends QuizState {
  final int score;
  final int totalQuestions;
  final List<Map<String, dynamic>> answers;
  final QuizCategory category;

  QuizCompleted({
    required this.score,
    required this.totalQuestions,
    required this.answers,
    required this.category,
  });

  @override
  List<Object?> get props => [score, totalQuestions, answers, category];
}

class QuizError extends QuizState {
  final String message;
  QuizError(this.message);

  @override
  List<Object?> get props => [message];
}
