import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:waitingnow/src/Domain/DeskVO.dart';
import 'package:waitingnow/src/Domain/MenuVO.dart';
import 'package:waitingnow/src/Service/PreorderService.dart';

import '../Domain/MenuVO.dart';

final GetStorage _storage = GetStorage();

class PreorderController extends GetConnect {

  final preorderService = Get.put(PreorderService());

  /**
   * 현재 대기 인원 출력하는 메소드
   * return 대기 인원 / 오류 발생 시 : -1
   */
  Future preorderList(int deskStoreNumber) async{
    dynamic value = "Preorder";
    List<MenuVO> menus = [];
    try{
      await preorderService.preorderList(deskStoreNumber).then((data) {
        if(data['data'] == null){
          if(data['message'] == "선주문 내역이 없습니다."){
            value = "No Preorder";
          }
          else throw Exception(data['message']);
        }
        else{
          Iterator<dynamic> iterator = data['data'].iterator;
          while (iterator.moveNext()) {
            menus.add(MenuVO.fromJson(iterator.current));
            print(menus.toString());
          }
        }
      });
      return menus.isEmpty ? value : menus;
    }catch(e){
      print(e.toString());
      return e.toString();
    }
  }
}
