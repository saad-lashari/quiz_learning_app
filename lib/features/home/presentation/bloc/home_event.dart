import 'package:equatable/equatable.dart';
import '../../../quiz/domain/entities/quiz_category.dart';

abstract class HomeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class UpdateCategoryProgress extends HomeEvent {
  final QuizCategory category;
  UpdateCategoryProgress(this.category);

  @override
  List<Object?> get props => [category];
}

class UpdateUserScore extends HomeEvent {
  final int score;
  UpdateUserScore(this.score);

  @override
  List<Object?> get props => [score];
}
