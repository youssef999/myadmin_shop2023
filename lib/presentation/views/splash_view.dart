import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shop_app/data/local/local_data.dart';
import 'package:shop_app/presentation/resources/assets_manager.dart';
import 'package:shop_app/presentation/resources/color_manager.dart';
import 'package:get/get.dart';

import 'package:get_storage/get_storage.dart';
import 'Country/country_view.dart';

class SplashView extends StatefulWidget
 {
  const SplashView({Key? key}) : super(key: key);

  @override
  _MySplashScreenState createState() => _MySplashScreenState();

 }
class _MySplashScreenState extends State<SplashView>
{
  startTimer()
  {
final box=GetStorage();

String country=box.read('country')??"x";



    Timer(const Duration(seconds: 3), () async
    {
      if( country!='x'){
        Get.offAll(const CountryView());
        //Get.offAll(MainHome());
      }

      else{
        Get.offAll(const CountryView());
      }

    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context)
  {
    return
      Scaffold(
          appBar: AppBar(
            toolbarHeight: 10,
            backgroundColor:ColorsManager.primary,
          ),
          body:
          Container(
            color:    ColorsManager.primary2,
            child:   Center(
              child: Container(
                  color:ColorsManager.primary2,
                  height: 290, child:
            SizedBox(
                 height: 210,
                  child: Image.asset(AssetsManager.Logo,fit:BoxFit.fill,))),
            ),
          )
      );
  }
}
