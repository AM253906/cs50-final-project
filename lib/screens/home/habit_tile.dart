import 'package:flutter/material.dart';
import 'package:firebase_app/models/habit.dart';

class HabitTile extends StatelessWidget {

  final Habit? habit;
  HabitTile({ this.habit });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        color: Colors.brown[400],
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.green[habit!.happiness],
          ),
          title: Text(habit!.name),
          subtitle: Text('Conquered ${habit!.habits} for ${habit!.days} day(s)'),
          isThreeLine: true,
        ),
      ),
    );
  }
}