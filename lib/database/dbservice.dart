import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:gdsc_solution_project/models/prod_list.dart';
import 'package:gdsc_solution_project/provider/Authcontroller.dart';
import 'package:logger/logger.dart';
import '../models/user_url.dart';

class DBService {
  final FirebaseDatabase _realtime = FirebaseDatabase.instance;




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
  setProfile(String uid) async{

    await _realtime.ref().child('users').set({
      'UID': uid,
    });
  }

  updateProfile(String uid, User user) async {
    await _realtime.ref().child('users').child(uid).update(user.toJson());
  }

  Future<User> readProfile(String uid) async {
    DataSnapshot snapshot =
        await _realtime.ref().child('users').child(uid).get();
    if (snapshot.value is Map<String, dynamic>) {
      User data = User.fromJson(snapshot.value as Map<String, dynamic>);
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
  DataSnapshot snapshot =
      await _realtime.ref().child('users').child(uid).child('Like').get();

  // snapshot.value가 null이 아닌지 확인하고, Map<dynamic, dynamic> 타입으로 캐스팅합니다.
  if (snapshot.value == null) {
    return []; // 또는 적절한 기본값 반환
  }

  Map<dynamic, dynamic> value = snapshot.value as Map<dynamic, dynamic>;
  Logger().d(value);

  // value.values에서 각 요소를 Prod 객체로 변환하기 전에 Map<String, dynamic> 타입으로 캐스팅합니다.
  List<Prod> data = value.values.map((e) {
    // Map<dynamic, dynamic>에서 Map<String, dynamic>으로 타입 캐스팅
    Map<String, dynamic> json = Map<String, dynamic>.from(e as Map);
    return Prod.fromJson(json);
  }).toList();

  return data;
}

  Future<bool> isLiked(String uid, String prodId) async {
    DataSnapshot snapshot = (await _realtime.ref().child('users').child(uid).child('Like').child(prodId).once()).snapshot;
    return snapshot.value != null;
  }

}
