import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:waitingnow/src/Get/DeskGet.dart';

import '../Domain/DeskVO.dart';
import '../Service/DeskService.dart';

final GetStorage _storage = GetStorage();

class DeskController extends GetConnect {

  final deskService = Get.put(DeskService());
  final deskGet = Get.put(DeskGet());

  /**
   * 현재 테이블 상태 확인하기
   */
  Future<Object> checkDesk() async{
    DeskVO deskVO = new DeskVO();
    try{
      List<DeskVO> desks = [];
      await deskService.checkDesk().then((data) {
        Iterator<dynamic> iterator = data.iterator;
        while (iterator.moveNext()) {
          desks.add(DeskVO.fromJson(iterator.current));
        }
        deskGet.Desks.value = desks;
      });
      return "True";
    }catch(e){
      print("데스크 조회 오류 : " + e.toString());
      return "False";
    }
  }

  /**
   * 웨이팅 한 손님 데스크 할당
   */
  Future<String> assignDesk(int waitingNumber) async{
    try{
      await deskService.assignDesk(waitingNumber).then((data) {
        checkDesk(); // 배정 했으면 상태관리
        if(data != null){
          deskGet.checkedDesks.value = []; // 체크 된 리스트 비워주어야함
          if(data['preorderExist'] == true){
            return "preorder";
          }
        }
      });
      return "True";
    }catch(e){
      print("데스크 할당 오류 : " + e.toString());
      return "False";
    }
  }

  /**
   * 웨이팅 없이 테이블 할당
   */
  Future<String> assignDeskNoWaiting(int waitingPeople) async{
    try{
      await deskService.assignDeskNoWaiting(waitingPeople).then((data) {
        checkDesk(); // 배정 했으면 상태관리
        if(data != null){
          deskGet.checkedDesks.value = []; // 체크 된 리스트 비워주어야함
          if(data['preorderExist'] == true){
            return "preorder";
          }
        }
      });
      return "True";
    }catch(e){
      print("데스크 할당 오류 : " + e.toString());
      return "False";
    }
  }

  /**
   * 테이블 배정 해제
   */
  Future deskOut(int? deskStoreNumber) async{
    String returnData = "";
    try{
      await deskService.deskOut(deskStoreNumber).then((message) {
        checkDesk();
        deskGet.checkedDesks.value = []; // 체크 된 리스트 비워주어야함
        returnData = message;
      });
      return returnData;
    }catch(e){
      e.printError();
      return e.toString();
    }
  }
}
