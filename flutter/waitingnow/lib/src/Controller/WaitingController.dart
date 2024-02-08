import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../Service/WaitingService.dart';
import '../global/global.dart';

final GetStorage _storage = GetStorage();

class WaitingController extends GetConnect {
  final waitingService = Get.put(WaitingService());
  /**
   * 현재 대기 인원 출력하는 메소드
   * return 대기 인원 / 오류 발생 시 : -1
   */
  Future<int> waitingNowPeople() async{
    try{
      int peopleNumber = 0;
      await waitingService.waitingNowPeople().then((data) {
        peopleNumber = data;
      });
      return peopleNumber;
    }catch(e){
      return -1;
    }
  }

  /**
   * 웨이팅 등록하기 API
   */
  Future<int> registWaiting() async{
    try{
      int waitingCustomerNumber = 0;

      await waitingService.registWaiting().then((data) {
        print(data);
        waitingCustomerNumber = data['waitingCustomerNumber'];
      });
      return waitingCustomerNumber;
    }catch(e){
      print("오류 : $e");
      return -1;
    }
  }
}
