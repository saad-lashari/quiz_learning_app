import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:quiz_learning_app/core/di/injection.dart';
import 'package:quiz_learning_app/core/utils/app_utils.dart';
import 'package:quiz_learning_app/features/home/presentation/widgets/category_card.dart';
import 'package:quiz_learning_app/features/home/presentation/widgets/user_header.dart';
import '../../../../core/router/app_router.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HomeBloc>(),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F3FF),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return Column(
            children: [
              UserHeader(user: state.user),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildUserCard(state),
                      SizedBox(height: 24.h),
                      _buildSectionTitle(),
                      SizedBox(height: 16.h),
                      _buildCategoryGrid(context, state),
                      SizedBox(height: 80.h),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildUserCard(HomeState state) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 80.w,
            height: 80.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.indigo, width: 3),
              image: DecorationImage(
                image: NetworkImage(
                  "https://corsproxy.io/?${state.user.image}",
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  state.user.name,
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    _buildBadge(
                      Icons.emoji_events,
                      state.user.rank,
                      Colors.purple.shade50,
                      Colors.purple.shade700,
                    ),
                    SizedBox(width: 8.w),
                    _buildBadge(
                      Icons.star,
                      '${state.user.totalScore} pts',
                      Colors.orange.shade50,
                      Colors.orange.shade700,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(IconData icon, String text, Color bg, Color fg) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16.sp, color: fg),
          SizedBox(width: 4.w),
          Text(
            text,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
              color: fg,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle() {
    return Row(
      children: [
        Icon(Icons.category, size: 24.sp, color: Colors.amber),
        SizedBox(width: 8.w),
        Text(
          'Choose a Category',
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildCategoryGrid(BuildContext context, HomeState state) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
        childAspectRatio: isSmalllDevice(context) ? 0.85 : 2,
        crossAxisSpacing: 16.w,
        mainAxisSpacing: 16.h,
      ),
      itemCount: state.categories.length,
      itemBuilder: (context, index) {
        final category = state.categories[index];
        return CategoryCard(
          category: category,
          onTap: () {
            context.push(AppRouter.countdown, extra: category);
          },
        );
      },
    );
  }
}
