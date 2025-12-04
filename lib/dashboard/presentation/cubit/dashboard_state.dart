class DashboardState {
  final int currentIndex;

  const DashboardState(this.currentIndex);

  // Use copyWith for easy state updates
  DashboardState copyWith({int? currentIndex}) {
    return DashboardState(currentIndex ?? this.currentIndex);
  }
}
