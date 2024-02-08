import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:waitingnow/src/Get/WaitingGet.dart';

import '../global/global.dart';

final GetStorage _storage = GetStorage();

class WaitingService extends GetConnect {
  final waitingGet = Get.put(WaitingGet());

  Future waitingNowPeople() async{
    Response response = await get('/waiting/now/people');

    Map<String, dynamic> body = response.body;

    if(body['code'] != 200){
      throw Exception(body['message']);
    }else{
      return body['data'];
    }
  }

  Future registWaiting() async{
    int waitingPeople = (waitingGet.adult.value + waitingGet.baby.value);
    String waitingPhone = waitingGet.phone.value.replaceAll(RegExp(r'[^\d]'), '');
    Response response = await post('/waiting', {'waitingPhone' : waitingPhone, 'waitingPeople' : waitingPeople});

    Map<String, dynamic> body = response.body;

    if(body['code'] != 201){
      throw Exception(body['message']);
    } else{
      return body['data'];
    }
  }

  Future waitingStatusPeopleList() async{
    Response response = await get('/waiting/now?waitingStatus=waiting');

    Map<String, dynamic> body = response.body;

    if(body['code'] != 200){
      throw Exception(body['message']);
    } else{
      return body['data'];
    }

  }

  Future endStatusPeopleList() async{
    Response response = await get('/waiting/now?waitingStatus=end');
    Map<String, dynamic> body = response.body;

    if(body['code'] != 200){
      throw Exception(body['message']);
    } else{
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