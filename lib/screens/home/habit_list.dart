import 'package:firebase_app/models/habit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_app/models/habit.dart';
import 'package:firebase_app/screens/home/Habit_tile.dart';

class HabitList extends StatefulWidget {
  const HabitList({super.key});

  @override
  State<HabitList> createState() => _HabitListState();
}

class _HabitListState extends State<HabitList> {
  @override
  Widget build(BuildContext context) {

    final habits = Provider.of<List<Habit>>(context);

    return ListView.builder(
      itemCount: habits.length,
      itemBuilder: (context, index) {
        return HabitTile(habit: habits[index]);
      },
    );
  }
}