

import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';

class Country {
  String ? name,img,currency;

  Country(
      {
        this.name,this.img,this.currency
      });

  Country.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    }
    name = map['name'];
    img = map['img'];
    currency = map['currency'];



  }

  // toJson() {
  //   return {
  //     'name': name,
  //
  //   };
  // }
}
