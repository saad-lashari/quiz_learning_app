import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz_learning_app/core/di/injection.dart';
import 'package:quiz_learning_app/core/router/app_router.dart';
import 'package:quiz_learning_app/core/utils/app_utils.dart';
import 'package:quiz_learning_app/dashboard/presentation/cubit/dashboard_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashboardCubit(),
      child: ScreenUtilInit(
        designSize: isSmalllDevice(context)
            ? const Size(375, 812)
            : Size(1032, 1900),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp.router(
            title: 'Quiz App',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
            ),
            routerConfig: getIt<AppRouter>().router,
          );
        },
      ),
    );
  }
}
