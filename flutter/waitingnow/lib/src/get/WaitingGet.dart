import 'dart:async';

import 'package:get/get.dart';

import '../screen/waiting/home.dart';

class WaitingGet extends GetxController {
  // _변수 : private
  RxString phone = '010 - '.obs;

  /*
    전화번호 입력하는 함수
   */
  bool addPhoneNumber(var number) {
    var changedPhone = phone.value + number;
    print(phone.value);

    if (changedPhone.length == 10) {
      changedPhone += " - ";
      phone.value = changedPhone;
      return true;
    } else if (changedPhone.length == 18) {
      print("[전화번호 입력] 이미 모두 입력했습니다");
      changedPhone = changedPhone.substring(0, 17);
      phone.value = changedPhone;
      return false;
    }

    phone.value = changedPhone;
    return true;
  }

  /*
    전화번호 지우는 함수
   */
  bool removePhoneNumber() {
    var changedPhone = phone.value.substring(0, phone.value.length - 1);
    if (changedPhone.length == 12) {
      changedPhone = changedPhone.substring(0, 9);
      phone.value = changedPhone;
      return true;
    } else if (changedPhone.length == 5) {
      print("[전화번호 입력] 더 지울 수 없습니다. ");
      changedPhone += " ";
      phone.value = changedPhone;
      return false;
    }

    phone.value = changedPhone;
    return true;
  }

  /* ================= 인원 수 상태관리 ============================= */
  RxInt baby = 0.obs;
  RxInt adult = 0.obs;

  bool minusBaby() {
    int tempBaby = baby.value - 1;
    if (tempBaby < 0) {
      print("[인원 입력] 인원은 0보다 작을 수 없습니다!");
      baby.value = 0;
      return false;
    } else {
      baby.value = tempBaby;
      return true;
    }
  }

  bool plusBaby() {
    int tempBaby = baby.value + 1;

    if (tempBaby > 9) {
      print("[인원 입력] 인원은 최대 9명 까지 가능합니다!");
      baby.value = 9;
      return false;
    } else {
      baby.value = tempBaby;
      return true;
    }
  }

  bool minusAdult() {
    int tempAdult = adult.value - 1;

    if (tempAdult < 0) {
      print("[인원 입력] 인원은 0보다 작을 수 없습니다!");
      adult.value = 0;
      return false;
    } else {
      adult.value = tempAdult;
      return true;
    }
  }

  bool plusAdult() {
    int tempAdult = adult.value + 1;

    if (tempAdult > 9) {
      print("[인원 입력] 인원은 최대 9명 까지 가능합니다!");
      adult.value = 9;
      return false;
    } else {
      adult.value = tempAdult;
      return true;
    }
  }

  /* ================= 타이머 상태관리 ============================= */
  RxInt time = 10.obs;

  late Timer timerr;

  void Time() {
    print("호출");
    timerr = Timer.periodic(Duration(seconds: 1), (timer) {
      print(time--);
      if (time == 0) {
        timer.cancel();
        Get.offAll(Home());
      }
    });
  }

  void TimeStop(){
    timerr.cancel();
  }
}
