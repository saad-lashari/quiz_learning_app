import 'package:equatable/equatable.dart';

class Question extends Equatable {
  final String question;
  final String correctAnswer;
  final List<String> allAnswers;
  final String type;

  const Question({
    required this.question,
    required this.correctAnswer,
    required this.allAnswers,
    required this.type,
  });

  @override
  List<Object?> get props => [question, correctAnswer, allAnswers, type];
}
