import 'package:get/get.dart';

class DeskGet extends GetConnect{
  RxList Desks = [].obs;
  
  // 테이블 배정 시 체크한 데스크 리스트들
  RxList checkedDesks = [].obs;
}