import 'package:firebase_database/firebase_database.dart';
import 'package:gdsc_solution_project/models/prod_list.dart';
import '../models/user_url.dart';

class DBService {
  FirebaseDatabase _realtime = FirebaseDatabase.instance;

  setProfile(String uid) async{
    await _realtime.ref().child('users').child(uid).set({
      'UID': uid,
    });
  }

  updateProfile(String uid, User user) async{
    await _realtime.ref().child('users').child(uid).update(user.toJson());
  }

  Future<List<User>> readProfile(String uid) async{
    DataSnapshot _snapshot = await _realtime.ref().child('users').child(uid).get();
    Map<dynamic, dynamic> _value = _snapshot.value as Map<dynamic, dynamic>;
    List<User> data = _value.values.map((e) => User.fromJson(e)).toList();
    return data;
  }

  setLike(String uid, Prod prod) async{
    await _realtime.ref().child('users').child(uid).child('Like').set(prod.toJson());
  }

  deleteLike(String uid, String prodName) async{
    await _realtime.ref().child('users').child(uid).child('Like').child(prodName).remove();
  }

  Future<List<Prod>> readLike(String uid) async{
    DataSnapshot _snapshot = await _realtime.ref().child('users').child(uid).child('Like').get();
    Map<dynamic, dynamic> _value = _snapshot.value as Map<dynamic, dynamic>;
    List<Prod> data = _value.values.map((e) => Prod.fromJson(e)).toList();
    return data;
  }
}
