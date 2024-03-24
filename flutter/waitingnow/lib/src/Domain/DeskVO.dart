class DeskVO {
  bool? deskAvailable;
  int? deskStoreNumber;
  int? deskPeople;

  DeskVO(){}

  Map<String, dynamic> toJson() {
    return {
      'deskAvailable': deskAvailable,
      'deskStoreNumber': deskStoreNumber,
      'deskPeople': deskPeople,
    };
  }

  DeskVO.fromJson(Map m) {
    deskAvailable = m['deskAvailable'];
    deskStoreNumber = m['deskStoreNumber'];
    deskPeople = m['deskPeople'];
  }

  printDesks(){
    print("deskStoreNumber : " + deskStoreNumber.toString() + " / deskPeople : " + deskPeople.toString() + " / deskAvailable : " + deskAvailable.toString());
  }
}