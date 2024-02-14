import 'package:gdsc_solution_project/database/dbservice.dart';
import 'package:gdsc_solution_project/models/user_url.dart';
import 'package:gdsc_solution_project/provider/Authcontroller.dart';
import 'package:get/get.dart';

class UserInfoController extends GetxController {
  static UserInfoController instance = Get.find();
  var user = Rxn<User>(); // 사용자 정보를 저장하는 Rxn 타입의 변수

  @override
  void onInit() {
    super.onInit();
    fetchUserProfile();
  }

  void fetchUserProfile() async {
    final String uid = AuthController().getCurrentUser();
    User? userProfile = await DBService().readProfile(uid); // 비동기 호출 수정
    if (userProfile != null) {
      user.value = userProfile;
    }
  }

  // showMessage 값을 업데이트하는 함수
  void updateShowMessage(bool newValue) async {
    final String uid = AuthController().getCurrentUser();

    // 현재 user 객체의 showMessage 값을 업데이트
    if (user.value != null) {
      user.value!.showMessage = newValue;

      // 변경된 user 객체를 데이터베이스에 업데이트

      // GetX 상태 관리를 통해 UI에 변경사항 반영
      user.refresh();
    }
  }
}

// Obx(() {
//   // UserController 인스턴스를 찾아 사용자 이름을 표시
//   String userName = UserController().user.value?.userName ?? 'Guest';
//   return Text(userName);
// });
