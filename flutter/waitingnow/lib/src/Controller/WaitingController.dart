import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:waitingnow/src/Domain/UserVO.dart';

import '../global/global.dart';
import '../service/WaitingService.dart';

final GetStorage _storage = GetStorage();

class WaitingController extends GetConnect {
  final waitingService = Get.put(WaitingService());

}
