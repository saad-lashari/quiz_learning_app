import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String name;
  final String image;
  final String rank;
  final int totalScore;
  final int quizzesTaken;
  final int totalQuizzes;

  const User({
    required this.name,
    required this.image,
    required this.rank,
    required this.totalScore,
    required this.quizzesTaken,
    required this.totalQuizzes,
  });

  User copyWith({
    String? name,
    String? image,
    String? rank,
    int? totalScore,
    int? quizzesTaken,
    int? totalQuizzes,
  }) {
    return User(
      name: name ?? this.name,
      image: image ?? this.image,
      rank: rank ?? this.rank,
      totalScore: totalScore ?? this.totalScore,
      quizzesTaken: quizzesTaken ?? this.quizzesTaken,
      totalQuizzes: totalQuizzes ?? this.totalQuizzes,
    );
  }

  @override
  List<Object?> get props => [
    name,
    image,
    rank,
    totalScore,
    quizzesTaken,
    totalQuizzes,
  ];
}
