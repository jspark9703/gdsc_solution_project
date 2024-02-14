import 'package:firebase_database/firebase_database.dart';
import 'package:gdsc_solution_project/models/prod_list.dart';
import 'package:gdsc_solution_project/provider/Authcontroller.dart';
import 'package:logger/logger.dart';
import '../models/user_url.dart';

class DBService {
  FirebaseDatabase _realtime = FirebaseDatabase.instance;

  // 데이터베이스에서 특정 사용자의 데이터 변화를 감지하는 리스너를 설정하는 함수
  void subscribeToUserProfile(String uid, void Function(User) onDataChanged) {
    _realtime.ref('users/$uid').onValue.listen((event) {
      final userMap = event.snapshot.value as Map<String, dynamic>?;
      if (userMap != null) {
        final user = User.fromJson(userMap);
        onDataChanged(user);
      }
    });
  }

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
    if (_snapshot.value != null && _snapshot.value is Map) {
      Map<Object?, Object?> valueMap = _snapshot.value as Map<Object?, Object?>;
      if (valueMap['user_name'] is String &&
          valueMap['user_class'] is String &&
          valueMap['user_info'] is String &&
          valueMap['show_message'] is bool) {
        Map<String, dynamic> castedMap = {};
        for (var key in valueMap.keys) {
          if (key is String) {
            castedMap[key] = valueMap[key];
          }
        }
        User data = User.fromJson(castedMap);
        return data;
      }
    }
    throw Exception('Unable to read profile');
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

    if (_snapshot.value is! Map) {
      throw Exception('Data is not a map');
    }

    Map<dynamic, dynamic> _value = _snapshot.value as Map<dynamic, dynamic>;
    Logger().d(_value);

    List<Prod> data = _value.values.map((e) {
      if (e is Map) {
        Map<String, dynamic> castedMap = {};
        for (var key in e.keys) {
          if (key is String) {
            castedMap[key] = e[key];
          }
        }
        return Prod.fromJson(castedMap);
      } else {
        throw Exception('Data is not a map');
      }
    }).toList();

    return data;
  }

  Future<bool> isLiked(String uid, String prodId) async {
    DataSnapshot _snapshot = (await _realtime
            .ref()
            .child('users')
            .child(uid)
            .child('Like')
            .child(prodId)
            .once())
        .snapshot;
    return _snapshot.value != null;
  }
}
