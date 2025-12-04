import 'package:dartz/dartz.dart';
import 'package:quiz_learning_app/core/error/failures.dart';
import 'package:quiz_learning_app/features/quiz/domain/entities/question.dart';

abstract class QuizRepository {
  Future<Either<Failure, List<Question>>> fetchQuestions(int categoryId);
}
