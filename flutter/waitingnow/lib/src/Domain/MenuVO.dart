import 'OptionMenuVO.dart';

class MenuVO {
   int? menuNumber;
   String? menuName;
   int? menuPrice;
   int? menuCount;
   String? menuFile;
   String? menuCategory;
   int? memberNumber;
   Map<String, List<OptionMenuVO>>? menuOption;

   MenuVO(){}

   Map<String, dynamic> toJson() {
      return {
         'menuNumber': menuNumber,
         'menuName': menuName,
         'menuPrice': menuPrice,
         'menuCount': menuCount,
         'menuFile': menuFile,
         'menuCategory': menuCategory,
         'memberNumber': memberNumber,
         'menuOption': menuOption?.map((key, value) => MapEntry(key, value.map((e) => e.toJson()).toList())),
      };
   }

   MenuVO.fromJson(Map<String, dynamic> json) {
      menuNumber = json['menuNumber'];
      menuName = json['menuName'];
      menuPrice = json['menuPrice'];
      menuCount = json['menuCount'];
      menuFile = json['menuFile'];
      menuCategory = json['menuCategory'];
      memberNumber = json['memberNumber'];
      menuOption = (json['menuOption'] as Map<String, dynamic>?)?.map((key, value) => MapEntry(key, (value as List<dynamic>).map((e) => OptionMenuVO.fromJson(e)).toList()));
   }
}
