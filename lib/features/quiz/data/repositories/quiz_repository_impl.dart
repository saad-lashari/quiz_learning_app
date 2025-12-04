import 'package:dartz/dartz.dart';
import 'package:quiz_learning_app/core/error/failures.dart';
import 'package:quiz_learning_app/features/quiz/data/data_sources/quiz_remote_data_source.dart';
import 'package:quiz_learning_app/features/quiz/domain/entities/question.dart';
import 'package:quiz_learning_app/features/quiz/domain/repositories/question_repository.dart';

class QuizRepositoryImpl implements QuizRepository {
  final QuizRemoteDataSource remoteDataSource;

  QuizRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<Question>>> fetchQuestions(int categoryId) async {
    try {
      final questions = await remoteDataSource.fetchQuestions(categoryId);
      return Right(questions);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
