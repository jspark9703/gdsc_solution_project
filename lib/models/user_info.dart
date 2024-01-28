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
