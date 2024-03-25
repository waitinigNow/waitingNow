import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../Get/DeskGet.dart';
import '../global/global.dart';

final GetStorage _storage = GetStorage();

class DeskService extends GetConnect {
  final deskGet = Get.put(DeskGet());

  /**
   * 테이블 조회
   */
  Future checkDesk() async{
    Response response = await get('/desk');

    Map<String, dynamic> body = response.body;

    if(body['code'] != 200){
      throw Exception(body['message']);
    }else{
      return body['data'];
    }
  }

  /**
   * 웨이팅 고객 테이블 배정
   */
  Future assignDesk(int waitingNumber) async{
    Response response = await post('/desk/sit/waiting', {"deskStoreNumber":deskGet.checkedDesks.value.cast<int>(), "waitingNumber":waitingNumber});

    Map<String, dynamic> body = response.body;

    if(body['code'] != 200){
      throw Exception(body['message']);
    }else{
      return body['data'];
    }
  }

  /**
   * 웨이팅 없이 입장한 고객 테이블 배정
   */
  Future assignDeskNoWaiting(int enterPeople) async{
    Response response = await post('/desk/sit/nowaiting', {"deskStoreNumber":deskGet.checkedDesks.value.cast<int>(), "enterPeople":enterPeople});

    Map<String, dynamic> body = response.body;

    if(body['code'] != 200){
      throw Exception(body['message']);
    }else{
      return body['data'];
    }
  }

  /**
   * 테이블 배정 해제
   */
  Future deskOut(List<int> deskStoreNumber) async{
    Response response = await delete('/desk/out', query: {"deskStoreNumber":deskStoreNumber});

    Map<String, dynamic> body = response.body;

    if(body['code'] != 200){
      throw Exception(body['message']);
    }else{
      return body['data'];
    }
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