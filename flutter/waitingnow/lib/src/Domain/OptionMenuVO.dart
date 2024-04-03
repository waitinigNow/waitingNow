class OptionMenuVO {
   int? optionMenuKey;
   int? menuNumber;
   String? optionMenuName;
   int? optionMenuPrice;
   String? optionMenuCategory;

   OptionMenuVO.fromJson(Map<String, dynamic> json) {
      optionMenuKey = json['optionMenuKey'];
      menuNumber = json['menuNumber'];
      optionMenuName = json['optionMenuName'];
      optionMenuPrice = json['optionMenuPrice'];
      optionMenuCategory = json['optionMenuCategory'];
   }

   Map<String, dynamic> toJson() {
      return {
         'optionMenuKey': optionMenuKey,
         'menuNumber': menuNumber,
         'optionMenuName': optionMenuName,
         'optionMenuPrice': optionMenuPrice,
         'optionMenuCategory': optionMenuCategory,
      };
   }
}