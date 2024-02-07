import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../global/global.dart';

final GetStorage _storage = GetStorage();

class WaitingService extends GetConnect {
  @override
  void onInit() {
    allowAutoSignedCert = true;
    httpClient.baseUrl = Global.apiRoot;
    httpClient.addRequestModifier<void>((request) async {
      request.headers['Authorization'] = await getToken;
      // Feed는 어차피 token 다 씀
      request.headers['Accept'] = 'application/json';
      return request;
    });
    super.onInit();
  }

  get getToken async {
    return _storage.read("token");
  }
}