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


}
