import 'package:firebase_app/screens/home/form_settings.dart';
import 'package:firebase_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_app/services/database.dart';
import 'package:provider/provider.dart';
import 'package:firebase_app/screens/home/habit_list.dart';
import 'package:firebase_app/models/habit.dart';
import 'package:firebase_app/models/user.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<MyUser>(context);

    void _showSettingsPanel() {
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: FormSettings(),
        );
      });
    }

    return StreamProvider<List<Habit>>.value(
      initialData: [],
      value: DatabaseService(uid: user.uid!).habits,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Better Habits'),
          foregroundColor: Colors.brown[100],
          backgroundColor: Colors.brown[500],
          elevation: 0.0,
          actions: <Widget>[
            TextButton.icon(
              style: TextButton.styleFrom(
                foregroundColor: Colors.amber
              ),
              icon: Icon(Icons.settings),
              label: Text('Settings'),
              onPressed: () => _showSettingsPanel(),
            ),
            TextButton.icon(
              style: TextButton.styleFrom(
                foregroundColor: Colors.amber
              ),
              icon: Icon(Icons.person),
              onPressed: () async {
                await _auth.signOut();
              },
              label: Text('Logout'),
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/zen.jpg'),
              fit: BoxFit.cover,
            )
          ),
          child: HabitList()
        ),
      ),
    );
  }
}