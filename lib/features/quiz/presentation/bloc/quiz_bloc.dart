import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_learning_app/features/quiz/domain/use_cases/fetch_questions.dart';
import 'quiz_event.dart';
import 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  final FetchQuestions fetchQuestions;
  Timer? _timer;

  QuizBloc({required this.fetchQuestions}) : super(QuizInitial()) {
    on<LoadQuestions>(_onLoadQuestions);
    on<AnswerQuestion>(_onAnswerQuestion);
    on<NextQuestion>(_onNextQuestion);
    on<TimerTick>(_onTimerTick);
    on<ResetQuiz>(_onResetQuiz);
  }

  Future<void> _onLoadQuestions(
    LoadQuestions event,
    Emitter<QuizState> emit,
  ) async {
    emit(QuizLoading());

    final result = await fetchQuestions(event.category.id);

    result.fold((failure) => emit(QuizError(failure.message)), (questions) {
      emit(
        QuizLoaded(
          questions: questions,
          currentIndex: 0,
          timeLeft: 60,
          score: 0,
          answers: [],
          category: event.category,
        ),
      );
      _startTimer();
    });
  }

  void _onAnswerQuestion(AnswerQuestion event, Emitter<QuizState> emit) {
    if (state is! QuizLoaded) return;

    final currentState = state as QuizLoaded;
    _timer?.cancel();

    final currentQuestion = currentState.questions[currentState.currentIndex];
    final isCorrect = event.answer == currentQuestion.correctAnswer;

    final newAnswers = List<Map<String, dynamic>>.from(currentState.answers)
      ..add({
        'question': currentQuestion.question,
        'selectedAnswer': event.answer,
        'correctAnswer': currentQuestion.correctAnswer,
        'isCorrect': isCorrect,
      });

    emit(
      currentState.copyWith(
        selectedAnswer: event.answer,
        showFeedback: true,
        score: isCorrect ? currentState.score + 1 : currentState.score,
        answers: newAnswers,
      ),
    );
  }

  void _onNextQuestion(NextQuestion event, Emitter<QuizState> emit) {
    if (state is! QuizLoaded) return;

    final currentState = state as QuizLoaded;

    if (currentState.currentIndex < currentState.questions.length - 1) {
      emit(
        currentState.copyWith(
          currentIndex: currentState.currentIndex + 1,
          timeLeft: 60,
          selectedAnswer: null,
          showFeedback: false,
        ),
      );
      _startTimer();
    } else {
      emit(
        QuizCompleted(
          score: currentState.score,
          totalQuestions: currentState.questions.length,
          answers: currentState.answers,
          category: currentState.category,
        ),
      );
    }
  }

  void _onTimerTick(TimerTick event, Emitter<QuizState> emit) {
    if (state is! QuizLoaded) return;

    final currentState = state as QuizLoaded;

    if (event.timeLeft <= 0) {
      add(AnswerQuestion(null));
    } else {
      emit(currentState.copyWith(timeLeft: event.timeLeft));
    }
  }

  void _onResetQuiz(ResetQuiz event, Emitter<QuizState> emit) {
    _timer?.cancel();
    emit(QuizInitial());
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state is QuizLoaded) {
        final currentState = state as QuizLoaded;
        if (!currentState.showFeedback) {
          add(TimerTick(currentState.timeLeft - 1));
        }
      }
    });
  }
}
