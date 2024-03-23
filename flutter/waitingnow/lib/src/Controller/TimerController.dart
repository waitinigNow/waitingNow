import 'dart:async';

import 'package:get/get.dart';

class TimerController extends GetxController {
  var _remainingSeconds = 600.obs; // 10 minutes
  late Timer _timer;

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  void startTimer() {
    const oneSecond = Duration(seconds: 1);
    _timer = Timer.periodic(oneSecond, (timer) {
      _remainingSeconds.value--;
      if (_remainingSeconds.value <= 0) {
        timer.cancel();
      }
    });
  }

  String get remainingTime {
    int minutes = _remainingSeconds.value ~/ 60;
    int seconds = _remainingSeconds.value % 60;
    return '${minutes.toString().padLeft(2, '0')} : ${seconds.toString().padLeft(2, '0')}';
  }
}