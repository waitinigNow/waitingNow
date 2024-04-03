import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../global/global.dart';

final GetStorage _storage = GetStorage();

class PreorderService extends GetConnect {

  /**
   * 고객의 선주문 내역을 출력
   */
  Future preorderList(int deskStoreNumber) async{
    Response response = await get('/preorder?deskStoreNumber=${deskStoreNumber}');

    Map<String, dynamic> body = response.body;

    return body;
  }

  @override
  void onInit() {
    allowAutoSignedCert = true;
    httpClient.baseUrl = Global.apiRoot;
    httpClient.addRequestModifier<void>((request) async {
      request.headers['Authorization'] = await getToken;
      request.headers['Accept'] = 'application/json';
      return request;
    });
    super.onInit();
  }

  get getToken async {
    return _storage.read("token");
  }
}