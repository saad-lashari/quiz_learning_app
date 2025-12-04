import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_learning_app/dashboard/presentation/cubit/dashboard_state.dart';

// Assuming DashboardState is defined as above
class DashboardCubit extends Cubit<DashboardState> {
  // Initial state is index 0
  DashboardCubit() : super(const DashboardState(0));

  /// Emits a new state with the given index if it's different from the current one.
  void navigateToScreen(int index) {
    if (index == state.currentIndex) {
      return;
    }
    emit(state.copyWith(currentIndex: index));
  }
}
