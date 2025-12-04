import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../quiz/domain/entities/user.dart';

class UserHeader extends StatelessWidget {
  final User user;

  const UserHeader({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 12.h,
        bottom: 12.h,
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
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.indigo, width: 2),
              image: DecorationImage(
                image: NetworkImage(user.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Quizzes: ${user.quizzesTaken}/${user.totalQuizzes}',
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: Colors.grey.shade600,
                  ),
                ),
                SizedBox(height: 4.h),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: LinearProgressIndicator(
                    value: user.quizzesTaken / user.totalQuizzes,
                    backgroundColor: Colors.grey.shade200,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Colors.indigo,
                    ),
                    minHeight: 8.h,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 12.w),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.amber, Colors.orange],
              ),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.emoji_events, size: 16.sp, color: Colors.white),
                SizedBox(width: 4.w),
                Text(
                  '${user.totalScore}',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
