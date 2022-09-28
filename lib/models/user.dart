class MyUser {

  final String? uid;

  MyUser({ this.uid });

}

class UserData {

  final String uid;
  final String name;
  final String habits;
  final int happiness;
  final String days;

  UserData({ required this.uid, required this.name, required this.habits, required this.happiness, required this.days });

}