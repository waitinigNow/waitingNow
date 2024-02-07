import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../Global/global.dart';

final GetStorage _storage = GetStorage();

class MemberService extends GetConnect{
  /**
   * 로그인 API
   */
  Future login(String memberPhone, String memberPassword) async{
    Response response = await post('/login', {'memberPhone': memberPhone, 'memberPassword': memberPassword});

    Map<String, dynamic> body = response.body;

    if (body['code'] != 200) {
      throw Exception(body['message']);
    }
    else{
      _storage.write('token', body['message']);
    }
    return body['data'];
  }

  @override
  void onInit() {
    allowAutoSignedCert = true;
    httpClient.baseUrl = Global.apiRoot;
    httpClient.addRequestModifier<void>((request) async {
      // request.headers['Authorization'] = await getToken;
      request.headers['Accept'] = 'application/json';
      return request;
    });
    super.onInit();
  }


}