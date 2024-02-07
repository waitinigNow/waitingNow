import 'package:get/get.dart';

class WaitingGet extends GetxController {
  String _phone = '010 - ';
  String get phone => _phone;

  void up(String changedPhone){
    _phone = changedPhone;
    update();
  }
  /*
    전화번호 입력하는 함수
   */
  bool addPhoneNumber(var number) {
    var changedPhone = this._phone + number;
    print(this._phone);

    if(changedPhone.length == 10){
      changedPhone += " - ";
      up(changedPhone);
      return true;
    }
    else if(changedPhone.length == 18){
      print("[전화번호 입력] 이미 모두 입력했습니다");
      changedPhone = changedPhone.substring(0,17);
      up(changedPhone);
      return false;
    }

    up(changedPhone);
    return true;
  }

  /*
    전화번호 지우는 함수
   */
  bool removePhoneNumber() {
    var changedPhone = this._phone.substring(0, this._phone.length - 1);
    if(changedPhone.length == 12){
      changedPhone = changedPhone.substring(0, 9);
      up(changedPhone);
      return true;
    }
    else if(changedPhone.length == 5){
      print("[전화번호 입력] 더 지울 수 없습니다. ");
      changedPhone += " ";
      up(changedPhone);
      return false;
    }

    up(changedPhone);
    return true;
  }
}