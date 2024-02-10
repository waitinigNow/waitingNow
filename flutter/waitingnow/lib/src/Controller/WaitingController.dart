import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../Domain/WaitingVO.dart';
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

  /**
   * 현재 대기중인 사람들 출력
   */
  Future waitingStatusPeopleList() async{
    try{
      List<WaitingVO> waitings = [];
      await waitingService.waitingStatusPeopleList().then((data){
        Iterator<dynamic> iterator = data.iterator;
        while (iterator.moveNext()) {
          waitings.add(WaitingVO.fromJson(iterator.current));
        }
      });
      return waitings;
    }
    catch(e){
      print("오류 : $e");
      return -1;
    }
  }

  /**
   * 현재 대기중인 사람들 출력
   */
  Future endStatusPeopleList() async{
    try{
      List<WaitingVO> waitings = [];
      await waitingService.endStatusPeopleList().then((data){
        Iterator<dynamic> iterator = data.iterator;
        while (iterator.moveNext()) {
          waitings.add(WaitingVO.fromJson(iterator.current));
        }
      });
      return waitings;
    }
    catch(e){
      print("오류 : $e");
      return -1;
    }
  }

  /**
   * 현재 대기중인 사람들 출력
   */
  Future<bool> waitingCall(int? waitingCustomerNumber) async{
    try{
      await waitingService.waitingCall(waitingCustomerNumber).then((data){
      });
      return true;
    }
    catch(e){
      print("오류 : $e");
      return false;
    }
  }
}
