import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class QuizCategory extends Equatable {
  final int id;
  final String name;
  final Color color;
  final int completed;
  final int total;

  const QuizCategory({
    required this.id,
    required this.name,
    required this.color,
    this.completed = 0,
    this.total = 10,
  });

  QuizCategory copyWith({
    int? id,
    String? name,
    Color? color,
    int? completed,
    int? total,
  }) {
    return QuizCategory(
      id: id ?? this.id,
      name: name ?? this.name,
      color: color ?? this.color,
      completed: completed ?? this.completed,
      total: total ?? this.total,
    );
  }

  @override
  List<Object?> get props => [id, name, color, completed, total];
}
