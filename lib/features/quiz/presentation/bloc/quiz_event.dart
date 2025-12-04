import 'package:equatable/equatable.dart';
import '../../domain/entities/quiz_category.dart';

abstract class QuizEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadQuestions extends QuizEvent {
  final QuizCategory category;
  LoadQuestions(this.category);

  @override
  List<Object?> get props => [category];
}

class AnswerQuestion extends QuizEvent {
  final String? answer;
  AnswerQuestion(this.answer);

  @override
  List<Object?> get props => [answer];
}

class NextQuestion extends QuizEvent {}

class TimerTick extends QuizEvent {
  final int timeLeft;
  TimerTick(this.timeLeft);

  @override
  List<Object?> get props => [timeLeft];
}

class ResetQuiz extends QuizEvent {}
