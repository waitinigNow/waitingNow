import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:waitingnow/src/Service/PreorderService.dart';

final GetStorage _storage = GetStorage();

class PreorderController extends GetConnect {

  final preorderService = Get.put(PreorderService());

  /**
   * 현재 대기 인원 출력하는 메소드
   * return 대기 인원 / 오류 발생 시 : -1
   */
  Future<String> preorderList(int deskStoreNumber) async{
    String value = "Preorder";
    try{
      await preorderService.preorderList(deskStoreNumber).then((data) {
        if(data == "선주문 내역이 없습니다."){
          value = "No Preorder";
        }
        else throw Exception(data['message']);
      });
      return value;
    }catch(e){
      return e.toString();
    }
  }
}
