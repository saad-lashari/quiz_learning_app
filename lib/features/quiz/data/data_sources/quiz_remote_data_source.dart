import 'package:dio/dio.dart';
import '../models/question_model.dart';

abstract class QuizRemoteDataSource {
  Future<List<QuestionModel>> fetchQuestions(int categoryId);
}

class QuizRemoteDataSourceImpl implements QuizRemoteDataSource {
  final Dio dio;

  QuizRemoteDataSourceImpl(this.dio);

  @override
  Future<List<QuestionModel>> fetchQuestions(int categoryId) async {
    try {
      final response = await dio.get(
        '/api.php',
        queryParameters: {'amount': 10, 'category': categoryId},
      );

      if (response.statusCode == 200) {
        final results = response.data['results'] as List;
        return results.map((json) => QuestionModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load questions');
      }
    } catch (e) {
      throw Exception('Error fetching questions: $e');
    }
  }
}
