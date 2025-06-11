import 'package:flutter/material.dart';

enum ECategory { food, workout, travel, leisure, work, learning, aesthetic }

const Map<ECategory, IconData> categoryIcons = {
  ECategory.food: Icons.lunch_dining,
  ECategory.workout: Icons.fitness_center_rounded,
  ECategory.travel: Icons.flight_takeoff,
  ECategory.leisure: Icons.movie,
  ECategory.work: Icons.work,
  ECategory.learning: Icons.school,
  ECategory.aesthetic: Icons.face_retouching_natural,
};
