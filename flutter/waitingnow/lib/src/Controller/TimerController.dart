import 'dart:async';

import 'package:get/get.dart';

class TimerController extends GetxController {
  RxMap<int, int> dictionary = <int, int>{}.obs; // 10 minutes
  late Timer _timer;

  @override
  void onInit() {
    super.onInit();
  }

  void startTimer(int memberNumber) {
    dictionary[memberNumber] = 600;
    const oneSecond = Duration(seconds: 1);
    _timer = Timer.periodic(oneSecond, (timer) {
      if (dictionary[memberNumber]! <= 0) {
        timer.cancel();
      } else {
        dictionary[memberNumber] = dictionary[memberNumber]! - 1;
      }
    });
  }

  String remainingTime(int memberNumber) {
    int remaining = dictionary[memberNumber] ?? 0; // Null 체크 후 기본값 설정
    if (remaining <= 0) {
      return '10 : 00'; // 0 이하인 경우 기본값 반환
    } else {
      int minutes = remaining ~/ 60;
      int seconds = remaining % 60;
      return '${minutes.toString().padLeft(2, '0')} : ${seconds.toString()
          .padLeft(2, '0')}';
    }
  }
}