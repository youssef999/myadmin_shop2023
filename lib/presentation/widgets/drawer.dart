
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shop_app/presentation/views/Home/main_home.dart';
import 'package:shop_app/presentation/views/auth/login_view.dart';
import 'package:shop_app/presentation/views/splash_view.dart';

import '../resources/color_manager.dart';
import 'Custom_Text.dart';



 class MainDrawer extends StatefulWidget {

   MainDrawer();

  @override
  _MainDrawerState createState() => _MainDrawerState();


}

class _MainDrawerState extends State<MainDrawer> {




  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


      return Drawer(
          backgroundColor: Colors.white,
          child: SafeArea(
              child: SingleChildScrollView(
                  child: Column(
                      children: <Widget>[

                        Container(
                          height: 20,
                          color: ColorsManager.primary,
                        ),

                        const SizedBox(
                          height: 30,
                        ),

                        InkWell(
                          child: Row(
                            children: const [
                              SizedBox(width: 30,),
                              Icon(Icons.logout,color:Colors.black,size:30,),
                              SizedBox(width: 30,),
                              Custom_Text(
                                text: 'تسجيل خروج',
                                fontSize:21,
                              )
                            ],
                          ),

                          onTap:(){
                            final box=GetStorage();
                            box.remove('email');
                            box.remove('name');
                            Get.offAll(const LoginView());
                          },
                        )


                      ]))));


  }



}






