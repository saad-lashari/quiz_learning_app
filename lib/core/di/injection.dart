import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:quiz_learning_app/core/router/app_router.dart';
import 'package:quiz_learning_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:quiz_learning_app/features/quiz/data/data_sources/quiz_remote_data_source.dart';
import 'package:quiz_learning_app/features/quiz/data/repositories/quiz_repository_impl.dart';
import 'package:quiz_learning_app/features/quiz/domain/repositories/question_repository.dart';
import 'package:quiz_learning_app/features/quiz/domain/use_cases/fetch_questions.dart';
import 'package:quiz_learning_app/features/quiz/presentation/bloc/quiz_bloc.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  // External
  getIt.registerLazySingleton(
    () => Dio(
      BaseOptions(
        baseUrl: 'https://opentdb.com',
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    ),
  );

  // Data Sources
  getIt.registerLazySingleton<QuizRemoteDataSource>(
    () => QuizRemoteDataSourceImpl(getIt()),
  );

  // Repositories
  getIt.registerLazySingleton<QuizRepository>(
    () => QuizRepositoryImpl(getIt()),
  );

  // Use Cases
  getIt.registerLazySingleton(() => FetchQuestions(getIt()));

  // BLoCs
  getIt.registerFactory(() => HomeBloc());
  getIt.registerFactory(() => QuizBloc(fetchQuestions: getIt()));

  // Router
  getIt.registerSingleton(AppRouter());
}
