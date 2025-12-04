import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:quiz_learning_app/core/di/injection.dart';
import '../../../home/presentation/bloc/home_bloc.dart';
import '../../../home/presentation/bloc/home_event.dart';
import '../../domain/entities/quiz_category.dart';

class ResultsPage extends StatelessWidget {
  final int score;
  final int totalQuestions;
  final List<Map<String, dynamic>> answers;
  final QuizCategory category;

  const ResultsPage({
    super.key,
    required this.score,
    required this.totalQuestions,
    required this.answers,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<HomeBloc>()
        ..add(UpdateUserScore(score))
        ..add(UpdateCategoryProgress(category)),
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F3FF),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20.w),
            child: Column(
              children: [
                _buildHeader(),
                SizedBox(height: 24.h),
                _buildScoreCards(),
                SizedBox(height: 24.h),
                _buildAnswersReview(),
                SizedBox(height: 24.h),
                _buildBackButton(context),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
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
        children: [
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: const Duration(milliseconds: 800),
            builder: (context, value, child) {
              return Transform.scale(
                scale: value,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(Icons.emoji_events, size: 100.sp, color: Colors.amber),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(8.w),
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '$score',
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          SizedBox(height: 16.h),
          Text(
            'Quiz Complete!',
            style: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.h),
          Text(
            category.name,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScoreCards() {
    final percentage = (score / totalQuestions * 100).round();

    return Row(
      children: [
        Expanded(
          child: _buildScoreCard(
            'Correct',
            score.toString(),
            Colors.green.shade50,
            Colors.green.shade500,
            Icons.check_circle,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: _buildScoreCard(
            'Incorrect',
            '${totalQuestions - score}',
            Colors.red.shade50,
            Colors.red.shade500,
            Icons.cancel,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: _buildScoreCard(
            'Score',
            '$percentage%',
            Colors.blue.shade50,
            Colors.blue.shade500,
            Icons.star,
          ),
        ),
      ],
    );
  }

  Widget _buildScoreCard(
    String label,
    String value,
    Color bgColor,
    Color textColor,
    IconData icon,
  ) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, size: 32.sp, color: textColor),
          SizedBox(height: 8.h),
          Text(
            value,
            style: TextStyle(
              fontSize: 28.sp,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: TextStyle(fontSize: 12.sp, color: textColor),
          ),
        ],
      ),
    );
  }

  Widget _buildAnswersReview() {
    return Container(
      padding: EdgeInsets.all(20.w),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.assignment, size: 24.sp, color: Colors.indigo),
              SizedBox(width: 8.w),
              Text(
                'Review Your Answers',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Container(
            constraints: BoxConstraints(maxHeight: 400.h),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: answers.length,
              itemBuilder: (context, index) {
                final answer = answers[index];
                final isCorrect = answer['isCorrect'] as bool;

                return Container(
                  margin: EdgeInsets.only(bottom: 12.h),
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: isCorrect
                        ? Colors.green.shade50
                        : Colors.red.shade50,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: isCorrect
                          ? Colors.green.shade300
                          : Colors.red.shade300,
                      width: 2,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.indigo,
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Text(
                              'Q${index + 1}',
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Text(
                              answer['question'] as String,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            isCorrect ? Icons.check_circle : Icons.cancel,
                            size: 16.sp,
                            color: isCorrect ? Colors.green : Colors.red,
                          ),
                          SizedBox(width: 6.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Your answer: ${answer['selectedAnswer'] ?? 'No answer'}',
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: isCorrect
                                        ? Colors.green.shade700
                                        : Colors.red.shade700,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                if (!isCorrect) ...[
                                  SizedBox(height: 4.h),
                                  Text(
                                    'Correct answer: ${answer['correctAnswer']}',
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      color: Colors.green.shade700,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => context.go('/'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.indigo,
          padding: EdgeInsets.symmetric(vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          elevation: 4,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.home, size: 24.sp, color: Colors.white),
            SizedBox(width: 8.w),
            Text(
              'Back to Home',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
