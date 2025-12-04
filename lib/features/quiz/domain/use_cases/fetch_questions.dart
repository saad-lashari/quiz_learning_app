import 'package:dartz/dartz.dart';
import 'package:quiz_learning_app/core/error/failures.dart';
import 'package:quiz_learning_app/features/quiz/domain/entities/question.dart';
import 'package:quiz_learning_app/features/quiz/domain/repositories/question_repository.dart';

class FetchQuestions {
  final QuizRepository repository;

  FetchQuestions(this.repository);

  Future<Either<Failure, List<Question>>> call(int categoryId) async {
    return await repository.fetchQuestions(categoryId);
  }
}
