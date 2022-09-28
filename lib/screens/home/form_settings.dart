import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/models/user.dart';
import 'package:firebase_app/services/database.dart';
import 'package:firebase_app/shared/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_app/shared/constants.dart';
import 'package:provider/provider.dart';

class FormSettings extends StatefulWidget {
  const FormSettings({super.key});

  @override
  State<FormSettings> createState() => _FormSettingsState();
}

class _FormSettingsState extends State<FormSettings> {

  final _formKey = GlobalKey<FormState>();
  final List<String> habits = ['Choose habit', 'Nicotine', 'Alcohol', 'Diet', 'Exercise', 'Caffeine', 'Sleep', 'Multiple'];

  String? _currentName;
  String? _currentHabits;
  int? _currentHappiness;
  String? _currentDays;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<MyUser>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid!).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData) {

          UserData? userData = snapshot.data;

          return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text('Update habit settings',
                style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  initialValue: userData!.name,
                  decoration: textInputDecoration,
                  validator: (value) => value!.isEmpty ? 'Please enter a name' : null,
                  onChanged: (value) => setState(() => _currentName = value,
                    )
                ),
                SizedBox(height: 15.0),
                // dropdown
                DropdownButtonFormField(
                  decoration: textInputDecoration,
                  value: _currentHabits ?? userData.habits,
                  items: habits.map((habit){
                    return DropdownMenuItem(
                      value: habit,
                      child: Text(habit));
                  }).toList(),
                  onChanged: (value) {
                    setState( () => _currentHabits = value );
                  },
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  keyboardType: TextInputType.number,
                  initialValue: userData.days,
                  decoration: textInputDecoration,
                  validator: (value) => value!.isEmpty ? 'Please enter amount of days' : null,
                  onChanged: (value) => setState(() => _currentDays = value,
                    )
                ),
                SizedBox(height: 15.0),
                // slider
                Slider(
                  label: 'Current happiness conquering habit',
                  value: (_currentHappiness ?? userData.happiness).toDouble(),
                  activeColor: Colors.green[_currentHappiness ?? userData.happiness],
                  inactiveColor: Colors.green[_currentHappiness ?? userData.happiness],
                  min: 100,
                  max: 900,
                  divisions: 8,
                  onChanged: (value) => setState(() => _currentHappiness = value.round()),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.amber),
                    child: Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if(_formKey.currentState!.validate()) {
                        await DatabaseService(uid: user.uid!).updateUserData(
                          _currentHabits ?? userData.habits,
                          _currentName ?? userData.name,
                          _currentHappiness ?? userData.happiness,
                          _currentDays ?? userData.days
                        );
                        Navigator.pop(context);
                      }
                    }, 
                  ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red),
                  child: Text(
                    'Delete Account',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if(_formKey.currentState!.validate()) {
                      Navigator.pop(context);
                      final currUser = await FirebaseAuth.instance.currentUser;
                      await FirebaseFirestore.instance.collection('Habit').doc(user.uid).delete();                   
                      await currUser!.delete();
                      FirebaseAuth.instance.signOut();
                    }
                  }, 
                ),
              ],
            ),
          );
        } else {
          return Loading();
        }
        
      }
    );
  }
}
