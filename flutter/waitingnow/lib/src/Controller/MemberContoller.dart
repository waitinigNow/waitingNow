import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:waitingnow/src/Domain/UserVO.dart';
import 'package:waitingnow/src/Service/MemberService.dart';

import '../global/global.dart';

final GetStorage _storage = GetStorage();

class MemberController extends GetConnect {
  final memberService = Get.put(MemberService());

  Future login() async {
    UserVO user = new UserVO();
    await memberService.login(Global.memberPhone, Global.memberPassword).then((map) {
              user = UserVO.fromJson(map); // TODO 추후 입력 방식으로 변경 시 파라미터 변경
              _storage.write("user", user.toJson());
            });
    print("[로그인] ${user.memberName}님 로그인 되었습니다");
  }
}
