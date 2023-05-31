import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../resources/color_manager.dart';

appMessage({required String text}){

  Get.snackbar ("   $text ", '',colorText:ColorsManager.primary2,
      backgroundColor:Colors.black45,
      icon:const Icon(Icons.app_shortcut,color:ColorsManager.primary2,size:33,)
  );
}