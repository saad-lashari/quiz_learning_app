import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:quiz_learning_app/core/di/injection.dart';
import '../../../../core/router/app_router.dart';
import '../../domain/entities/quiz_category.dart';
import '../bloc/quiz_bloc.dart';
import '../bloc/quiz_event.dart';
import '../bloc/quiz_state.dart';

class QuizPage extends StatelessWidget {
  final QuizCategory category;

  const QuizPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<QuizBloc>()..add(LoadQuestions(category)),
      child: const QuizView(),
    );
  }
}

class QuizView extends StatelessWidget {
  const QuizView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F3FF),
      body: BlocConsumer<QuizBloc, QuizState>(
        listener: (context, state) {
          if (state is QuizCompleted) {
            Future.delayed(const Duration(milliseconds: 100), () {
              if (context.mounted) {
                context.pushReplacement(
                  AppRouter.results,
                  extra: {
                    'score': state.score,
                    'totalQuestions': state.totalQuestions,
                    'answers': state.answers,
                    'category': state.category,
                  },
                );
              }
            });
          }
        },
        builder: (context, state) {
          if (state is QuizLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is QuizError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error, size: 64.sp, color: Colors.red),
                  SizedBox(height: 16.h),
                  Text(
                    'Error: ${state.message}',
                    style: TextStyle(fontSize: 16.sp),
                  ),
                  SizedBox(height: 24.h),
                  ElevatedButton(
                    onPressed: () => context.pop(),
                    child: const Text('Go Back'),
                  ),
                ],
              ),
            );
          }

          if (state is QuizLoaded) {
            final question = state.questions[state.currentIndex];
            final progress =
                ((state.currentIndex + 1) / state.questions.length) * 100;

            if (state.showFeedback) {
              Future.delayed(const Duration(seconds: 1), () {
                if (context.mounted && state.showFeedback) {
                  context.read<QuizBloc>().add(NextQuestion());
                }
              });
            }

            return Column(
              children: [
                _buildHeader(context, state, progress),
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(20.w),
                      child: _buildQuestionCard(context, state, question),
                    ),
                  ),
                ),
                _buildTimer(state),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context, QuizLoaded state, double progress) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 16.h,
        bottom: 16.h,
        left: 16.w,
        right: 16.w,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Question ${state.currentIndex + 1}/${state.questions.length}',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
              ),
              Text(
                '${progress.round()}% Complete',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: LinearProgressIndicator(
              value: progress / 100,
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.indigo.shade400),
              minHeight: 12.h,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionCard(BuildContext context, QuizLoaded state, question) {
    return Container(
      constraints: BoxConstraints(maxWidth: 600.w),
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Q${state.currentIndex + 1}.',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  question.question,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          ...List.generate(
            question.allAnswers.length,
            (index) => _buildAnswerButton(
              context,
              state,
              question.allAnswers[index],
              index,
              question.correctAnswer,
            ),
          ),
          if (state.showFeedback) ...[
            SizedBox(height: 20.h),
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color:
                    (state.selectedAnswer == question.correctAnswer
                            ? Colors.green
                            : Colors.red)
                        .shade50,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                state.selectedAnswer == question.correctAnswer
                    ? '✓ Correct!'
                    : state.selectedAnswer == null
                    ? '⏱ Time\'s Up!'
                    : '✗ Incorrect!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: state.selectedAnswer == question.correctAnswer
                      ? Colors.green.shade700
                      : Colors.red.shade700,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildAnswerButton(
    BuildContext context,
    QuizLoaded state,
    String answer,
    int index,
    String correctAnswer,
  ) {
    final isSelected = state.selectedAnswer == answer;
    final isCorrect = answer == correctAnswer;
    final showCorrect = state.showFeedback && isCorrect;
    final showIncorrect = state.showFeedback && isSelected && !isCorrect;

    Color backgroundColor;
    Color borderColor;
    Color textColor;

    if (showCorrect) {
      backgroundColor = Colors.green.shade500;
      borderColor = Colors.green.shade700;
      textColor = Colors.white;
    } else if (showIncorrect) {
      backgroundColor = Colors.red.shade500;
      borderColor = Colors.red.shade700;
      textColor = Colors.white;
    } else if (isSelected) {
      backgroundColor = Colors.indigo.shade500;
      borderColor = Colors.indigo.shade700;
      textColor = Colors.white;
    } else {
      backgroundColor = Colors.grey.shade100;
      borderColor = Colors.grey.shade300;
      textColor = Colors.black87;
    }

    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: GestureDetector(
        onTap: state.showFeedback
            ? null
            : () {
                context.read<QuizBloc>().add(AnswerQuestion(answer));
              },
        child: Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: borderColor, width: 3),
          ),
          child: Row(
            children: [
              Text(
                '${String.fromCharCode(65 + index)}.',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  answer,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: textColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimer(QuizLoaded state) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.timer, color: Colors.indigo, size: 20.sp),
          SizedBox(width: 8.w),
          Text(
            'Time Left: ${state.timeLeft}s',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Colors.indigo,
            ),
          ),
        ],
      ),
    );
  }
}
