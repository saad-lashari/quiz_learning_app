import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState.initial()) {
    on<UpdateCategoryProgress>(_onUpdateCategoryProgress);
    on<UpdateUserScore>(_onUpdateUserScore);
  }

  void _onUpdateCategoryProgress(
    UpdateCategoryProgress event,
    Emitter<HomeState> emit,
  ) {
    final updatedCategories = state.categories.map((cat) {
      if (cat.id == event.category.id) {
        return cat.copyWith(completed: (cat.completed + 1).clamp(0, cat.total));
      }
      return cat;
    }).toList();

    emit(state.copyWith(categories: updatedCategories));
  }

  void _onUpdateUserScore(UpdateUserScore event, Emitter<HomeState> emit) {
    final updatedUser = state.user.copyWith(
      totalScore: state.user.totalScore + event.score,
      quizzesTaken: state.user.quizzesTaken + 1,
    );

    emit(state.copyWith(user: updatedUser));
  }
}
