import 'package:get/get.dart';
import 'package:waitingnow/src/Controller/DeskController.dart';

class DeskGet extends GetxController{
  RxList Desks = [].obs;
  
  // 테이블 배정 시 체크한 데스크 리스트들
  RxList checkedDesks = [].obs;

  // 배정 시 인원
  RxInt people = 0.obs;

  void updateDesk(){
    final deskController = Get.put(DeskController());
    deskController.checkDesk();
  }
}