class WaitingVO {
  int? waitingNumber;
  int? waitingCustomerNumber;
  String? waitingPhone;
  int? waitingPeople;
  String? waitingDate;
  int? waitingAvailable;
  int? memberNumber;

  WaitingVO(){}

  Map<String, dynamic> toJson() {
    return {
      'waitingNumber': waitingNumber,
      'waitingCustomerNumber': waitingCustomerNumber,
      'waitingPhone': waitingPhone,
      'waitingPeople': waitingPeople,
      'waitingDate': waitingDate,
      'waitingAvailable': waitingAvailable,
      'memberNumber': memberNumber,
    };
  }

  WaitingVO.fromJson(Map m) {
    waitingNumber = m['waitingNumber'];
    waitingCustomerNumber = m['waitingCustomerNumber'];
    waitingPhone = m['waitingPhone'];
    waitingPeople = m['waitingPeople'];
    waitingDate = m['waitingDate'];
    waitingAvailable = m['waitingAvailable'];
    memberNumber = m['memberNumber'];
  }

  printWaitings(){
    print("waiingNumber : " + waitingNumber.toString() + " / waitingCustomerNumber : " + waitingCustomerNumber.toString() + " / waitingPhone : " + waitingPhone.toString() + " / waitingAvailable : " + waitingAvailable.toString());
  }
}