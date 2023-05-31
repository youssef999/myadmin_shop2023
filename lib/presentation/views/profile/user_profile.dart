
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
 import 'package:flutter/material.dart';
import 'package:shop_app/data/local/local_data.dart';
import 'package:shop_app/presentation/resources/color_manager.dart';
import 'package:shop_app/presentation/views/profile/user_orders_view.dart';
import 'package:shop_app/presentation/widgets/Custom_Text.dart';

import '../../resources/assets_manager.dart';
import 'change_password_view.dart';

class UserProfileView extends StatelessWidget {
  const UserProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

final box=GetStorage();
String email=box.read('email')??"x";
String name=box.read('name')??"x";

    return Scaffold(
      backgroundColor:Colors.white,
      appBar: AppBar(
        toolbarHeight: 2,
        backgroundColor:ColorsManager.primary,
      ),
      body:SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 11,),
            SizedBox(
              height: 160,
              child:Image.asset(AssetsManager.Logo),),
            const SizedBox(height: 11,),
            (name!='x')?
            Custom_Text(text:name,fontSize: 22,alignment:Alignment.center,color:ColorsManager.primary,):const SizedBox(),
            const SizedBox(height: 22,),
            Row(
              children: [
                const SizedBox(width: 20,),
                const Icon(Icons.email,size: 28,color:ColorsManager.primary3,),
                const SizedBox(width: 20,),
                Custom_Text(text: email,fontSize: 20,alignment:Alignment.center,color:ColorsManager.primary,)
              ],
            ),
            const SizedBox(height: 40,),
            InkWell(
              child: Row(
                children: const [
                  SizedBox(width: 20,),
                  Icon(Icons.on_device_training_sharp,size: 28,color:ColorsManager.primary3,),
                  SizedBox(width: 20,),
                  Custom_Text(text: ' طلباتي السابقة  ',fontSize: 20,alignment:Alignment.center,color:ColorsManager.primary,)
                ],
              ),
              onTap:(){
                Get.to(const UserOrdersView());
              },
            ),

const SizedBox(height: 40,),
            InkWell(
              child: Row(
                children: const [
                  SizedBox(width: 20,),
                  Icon(Icons.password,size: 28,color:ColorsManager.primary3,),
                  SizedBox(width: 20,),
                  Custom_Text(text: 'تغير كلمة المرور ',fontSize: 20,alignment:Alignment.center,color:ColorsManager.primary,)
                ],
              ),
              onTap:(){
                Get.to(const ChangePasswordView());
              },
            ),

          ],
        ),
      ),
    );
  }
}
