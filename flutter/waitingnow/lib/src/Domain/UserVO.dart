class UserVO {
  int? memberNumber;
  String? memberName;
  String? memberPhone;
  String? memberPassword;
  String? memberStoreName;
  String? memberStorePhone;
  String? memberStoreCategory;
  bool? memberPreorder;

  UserVO(){}

  Map<String, dynamic> toJson() {
    return {
      'memberNumber': memberNumber,
      'memberName': memberName,
      'memberPhone': memberPhone,
      'memberPassword': memberPassword,
      'memberStoreName': memberStoreName,
      'memberStorePhone': memberStorePhone,
      'memberStoreCategory': memberStoreCategory,
      'memberPreorder': memberPreorder,
    };
  }

  UserVO.fromJson(Map m) {
    memberNumber = m['memberNumber'];
    memberName = m['memberName'];
    memberPhone = m['memberPhone'];
    memberPassword = m['memberPassword'];
    memberStoreName = m['memberStoreName'];
    memberStorePhone = m['memberStorePhone'];
    memberStoreCategory = m['memberStoreCategory'];
    memberPreorder = m['memberPreorder'];
  }
}