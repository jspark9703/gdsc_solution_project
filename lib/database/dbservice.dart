import 'package:firebase_database/firebase_database.dart';
import 'package:gdsc_solution_project/models/prod_list.dart';
import 'package:gdsc_solution_project/provider/Authcontroller.dart';
import '../models/user_url.dart';

class DBService {
  FirebaseDatabase _realtime = FirebaseDatabase.instance;

  setProfile(String uid) async {
    await _realtime.ref().child('users').set({
      'UID': uid,
    });
  }

  updateProfile(String uid, User user) async {
    await _realtime.ref().child('users').child(uid).update(user.toJson());
  }

  Future<User> readProfile(String uid) async {
    DataSnapshot _snapshot =
        await _realtime.ref().child('users').child(uid).get();
    if (_snapshot.value is Map<String, dynamic>) {
      User data = User.fromJson(_snapshot.value as Map<String, dynamic>);
      return data;
    } else {
      throw Exception('Data is not a map');
    }
  }

  Future<String> getUserName() async {
    User user =
        await DBService().readProfile(AuthController().getCurrentUser());
    return user.userName!;
  }

  setLike(String uid, Prod prod, String prodId) async {
    await _realtime
        .ref()
        .child('users')
        .child(uid)
        .child('Like')
        .child(prodId)
        .set(prod.toJson());
  }

  deleteLike(String uid, String prodId) async {
    await _realtime
        .ref()
        .child('users')
        .child(uid)
        .child('Like')
        .child(prodId)
        .remove();
  }

  Future<List<Prod>> readLike(String uid) async {
    DataSnapshot _snapshot =
        await _realtime.ref().child('users').child(uid).child('Like').get();
    Map<dynamic, dynamic> _value = _snapshot.value as Map<dynamic, dynamic>;
    List<Prod> data = _value.values.map((e) => Prod.fromJson(e)).toList();
    return data;
  }

  Future<bool> isLiked(String uid, String prodId) async {
    DataSnapshot _snapshot = (await _realtime.ref().child('users').child(uid).child('Like').child(prodId).once()).snapshot;
    return _snapshot.value != null;
  }
}
