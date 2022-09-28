import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/models/habit.dart';
import 'package:firebase_app/models/user.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ required this.uid });

  // collection reference
  final CollectionReference habitCollection = FirebaseFirestore.instance.collection('Habit');

  Future updateUserData(String habits, String name, int happiness, String days) async {
    return await habitCollection.doc(uid).set({
      'habits': habits,
      'name': name,
      'happiness': happiness,
      'days': days
    });
  }

  // list from snapshot
  List<Habit> _habitListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Habit(
        name: (doc.data() as dynamic)['name'] ?? '',
        happiness: (doc.data() as dynamic)['happiness'] ?? 0,
        habits: (doc.data() as dynamic)['habits'] ?? '0',
        days: (doc.data() as dynamic)['days'] ?? '0',
      );
    }).toList();
  }

  // userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid, 
      name: snapshot['name'], 
      habits: snapshot['habits'], 
      happiness: snapshot['happiness'],
      days: snapshot['days']
    );
  }

  // get collection sream
  Stream<List<Habit>> get habits {
    return habitCollection.snapshots()
    .map(_habitListFromSnapshot);
  }

  // get user doc stream
  Stream<UserData> get userData {
    return habitCollection.doc(uid).snapshots()
    .map(_userDataFromSnapshot);
  }

}