import 'dart:math';
import '../../domain/entities/question.dart';

class QuestionModel extends Question {
  const QuestionModel({
    required super.question,
    required super.correctAnswer,
    required super.allAnswers,
    required super.type,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    final correctAnswer = _decodeHtml(json['correct_answer'] as String);
    final incorrectAnswers = (json['incorrect_answers'] as List)
        .map((e) => _decodeHtml(e as String))
        .toList();

    final allAnswers = json['type'] == 'boolean'
        ? ['True', 'False']
        : _shuffleList([correctAnswer, ...incorrectAnswers]);

    return QuestionModel(
      question: _decodeHtml(json['question'] as String),
      correctAnswer: correctAnswer,
      allAnswers: allAnswers,
      type: json['type'] as String,
    );
  }

  static String _decodeHtml(String html) {
    return html
        .replaceAll('&quot;', '"')
        .replaceAll('&#039;', "'")
        .replaceAll('&amp;', '&')
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>')
        .replaceAll('&rsquo;', "'")
        .replaceAll('&ldquo;', '"')
        .replaceAll('&rdquo;', '"');
  }

  static List<String> _shuffleList(List<String> list) {
    final random = Random();
    final newList = List<String>.from(list);
    for (int i = newList.length - 1; i > 0; i--) {
      final j = random.nextInt(i + 1);
      final temp = newList[i];
      newList[i] = newList[j];
      newList[j] = temp;
    }
    return newList;
  }
}
