import 'dart:convert';

class UserInfo {
  String user_name;
  int user_class;
  String user_detail;

  UserInfo({
    required this.user_name,
    required this.user_class,
    required this.user_detail,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      user_name: json['user_name'] as String,
      user_class: json['user_class'] as int,
      user_detail: json['user_detail'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_name': user_name,
      'user_class': user_class,
      'user_detail': user_detail,
    };
  }
}

UserInfo parseUserFromJson(String jsonString) {
  final Map<String, dynamic> jsonData = json.decode(jsonString);
  return UserInfo.fromJson(jsonData);
}

String userToJson(UserInfo user) {
  final Map<String, dynamic> jsonData = user.toJson();
  return json.encode(jsonData);
}




// Future<void> uploadUserInfoToFirestore(UserInfo userInfo) async {
//   try {
//     // Get the current user's UID
//     String uid = FirebaseAuth.instance.currentUser!.uid;

//     // Reference to the "user_info" collection with the user's UID as the document name
//     CollectionReference userCollection = FirebaseFirestore.instance.collection('user_info');

//     // Convert UserInfo object to JSON
//     Map<String, dynamic> userData = userInfo.toJson();

//     // Upload the user data to Firestore
//     await userCollection.doc(uid).set(userData);

//     print('UserInfo uploaded to Firestore successfully!');
//   } catch (e) {
//     print('Error uploading UserInfo to Firestore: $e');
//   }
// }

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
  
//   // Initialize Firebase
//   await Firebase.initializeApp();

//   UserInfo userInfo = UserInfo(
//     user_name: 'John Doe',
//     user_class: 10,
//     user_detail: 'Some details about the user.',
//   );

//   // Upload UserInfo to Firestore
//   await uploadUserInfoToFirestore(userInfo);
// }