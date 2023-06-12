

import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';

class Cat {
  String ? name;

  Cat(
      {
        this.name,
      });

  Cat.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    }
    name = map['name'];



  }

  toJson() {
    return {
      'name': name,

    };
  }
}
