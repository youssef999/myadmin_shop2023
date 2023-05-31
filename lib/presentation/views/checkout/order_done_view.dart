


import 'package:get/get.dart';
 import 'package:flutter/material.dart';
import 'package:shop_app/presentation/resources/color_manager.dart';
import 'package:shop_app/presentation/views/Home/main_home.dart';
import 'package:shop_app/presentation/widgets/Custom_Text.dart';
import 'package:shop_app/presentation/widgets/Custom_button.dart';

class OrderDoneView extends StatelessWidget {
  const OrderDoneView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 4,
        backgroundColor:ColorsManager.primary,
      ),
      body:Column(
        children:  [
          SizedBox(height: 50,),
          Icon(Icons.check_circle,size:121,color:Colors.lightGreen,),
          SizedBox(height: 40,),
          Custom_Text(text: 'تم تنفيذ طلبك بنجاح',fontSize: 30,alignment:Alignment.center),
          SizedBox(height: 12,),
          CustomButton(text: 'انتقل للرئيسية', onPressed: (){
            Get.off(const MainHome());
          }, color1:ColorsManager.primary , color2: ColorsManager.primary2)
        ],
      ),
    );
  }
}
