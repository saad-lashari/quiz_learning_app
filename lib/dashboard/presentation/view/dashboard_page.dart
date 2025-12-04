import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz_learning_app/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'package:quiz_learning_app/dashboard/presentation/cubit/dashboard_state.dart';
import 'package:quiz_learning_app/features/home/presentation/view/home_page.dart';

// Assuming you have imported your Cubit and State classes,
// as well as the necessary placeholder screen widgets (HomeScreen, etc.)
// and NavItem widget, and AppImages.

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  // Define the list of screens outside the build method or as a static member
  final List<Widget> screens = const [
    // Placeholder screens from your original code
    HomePage(),
    Text('Leaderboard'),

    Text('Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    // Get the Cubit instance to call methods
    final cubit = context.read<DashboardCubit>();

    return Scaffold(
      // Use BlocBuilder to rebuild the body when the currentIndex changes
      body: BlocBuilder<DashboardCubit, DashboardState>(
        builder: (context, state) {
          return Center(child: screens[state.currentIndex]);
        },
      ),
      bottomNavigationBar: BlocBuilder<DashboardCubit, DashboardState>(
        buildWhen: (previous, current) =>
            previous.currentIndex != current.currentIndex,
        builder: (context, state) {
          final currentIndex = state.currentIndex;
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildNavItem(
                      () {
                        cubit.navigateToScreen(0);
                      },
                      Icons.home,
                      'Home',
                      currentIndex == 0,
                    ),
                    _buildNavItem(
                      () {
                        cubit.navigateToScreen(1);
                      },
                      Icons.emoji_events,
                      'Leaderboard',
                      currentIndex == 1,
                    ),
                    _buildNavItem(
                      () {
                        cubit.navigateToScreen(2);
                      },
                      Icons.person,
                      'Profile',
                      currentIndex == 2,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNavItem(
    Function() onTap,
    IconData icon,
    String label,
    bool isActive,
  ) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: isActive ? Colors.indigo : Colors.grey, size: 24.w),
          SizedBox(height: 4.h),
          Text(
            label,
            style: TextStyle(
              color: isActive ? Colors.indigo : Colors.grey,
              fontSize: 12.sp,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
