import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/app_router.dart';
import '../../domain/entities/quiz_category.dart';

class CountdownPage extends StatefulWidget {
  final QuizCategory category;

  const CountdownPage({super.key, required this.category});

  @override
  State<CountdownPage> createState() => _CountdownPageState();
}

class _CountdownPageState extends State<CountdownPage> {
  int countdown = 3;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdown > 1) {
        setState(() => countdown--);
      } else {
        timer.cancel();
        if (mounted) {
          context.pushReplacement(AppRouter.quiz, extra: widget.category);
        }
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.indigo.shade600,
              Colors.purple.shade600,
              Colors.pink.shade600,
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Get Ready!',
                style: TextStyle(
                  fontSize: 40.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 40.h),
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 500),
                builder: (context, value, child) {
                  return Transform.scale(
                    scale: value,
                    child: Text(
                      '$countdown',
                      style: TextStyle(
                        fontSize: 120.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 40.h),
              Text(
                widget.category.name,
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
