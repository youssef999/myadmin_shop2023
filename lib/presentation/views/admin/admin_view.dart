

 import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/presentation/resources/assets_manager.dart';
import 'package:shop_app/presentation/resources/color_manager.dart';
import 'package:shop_app/presentation/views/admin/country/add_new_country.dart';
import 'package:shop_app/presentation/views/admin/country/country_view.dart';
import 'package:shop_app/presentation/views/admin/products/add_product.dart';
import 'package:shop_app/presentation/views/admin/splash.dart';
import 'package:shop_app/presentation/widgets/Custom_button.dart';

import 'cat/add_cat.dart';
import 'cat/all_cat.dart';
import 'orders/orders.dart';
import 'products/products_view.dart';

class AdminView extends StatelessWidget {
  const AdminView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor:Colors.white,
      appBar:AppBar(
        toolbarHeight: 3,
        backgroundColor:ColorsManager.primary,
      ),
      body:Padding(
        padding: const EdgeInsets.all(21.0),
        child: ListView(
         // mainAxisAlignment:MainAxisAlignment.center,
         // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30,),
            SizedBox(
              height: 200,
              child:Image.asset(AssetsManager.Logo),
            ),

            const SizedBox(height: 20,),

            //
            // CustomButton(text:' تغيير الsplash للتطبيق ', onPressed:(){
            //
            //   Get.to(const SplashView());
            //
            // }, color1:ColorsManager.primary, color2: ColorsManager.primary2),
            //
            // const SizedBox(height: 20,),


            CustomButton(text:'اضف منتج جديد', onPressed:(){

              Get.to(const AddNewProduct());
              }, color1:ColorsManager.primary, color2: ColorsManager.primary2),

            const SizedBox(height: 20,),

            CustomButton(text:'جميع المنتجات ', onPressed:(){
              Get.to(const ProductsView());
            }, color1:ColorsManager.primary, color2: ColorsManager.primary2),

            const SizedBox(height: 20,),

            CustomButton(text:'اضف قسم جديد  ', onPressed:(){
              Get.to(const AddNewCat());
            }, color1:ColorsManager.primary, color2: ColorsManager.primary2),

            const SizedBox(height: 20,),

            CustomButton(text:'جميع الاقسام  ', onPressed:(){
              Get.to(const CatView());
            }, color1:ColorsManager.primary, color2: ColorsManager.primary2),

            const SizedBox(height: 20,),

            CustomButton(text:'البلاد', onPressed:(){
              Get.to(const CountryView());
            }, color1:ColorsManager.primary, color2: ColorsManager.primary2),

            const SizedBox(height: 20,),

            CustomButton(text:' اضف بلد جديدة  ', onPressed:(){
              Get.to(const AddNewCountry());
            }, color1:ColorsManager.primary, color2: ColorsManager.primary2),
            const SizedBox(height: 20,),

            CustomButton(text:'جميع الطلبات علي المتجر   ', onPressed:(){
              Get.to( OrdersView(
                status: 'all',
              ));
            }, color1:ColorsManager.primary, color2: ColorsManager.primary2),
            const SizedBox(height: 20,),
            CustomButton(text:' طلبات بانتظار الموافقة    ', onPressed:(){
              Get.to( OrdersView(
                status: 'wait',
              ));
            }, color1:ColorsManager.primary, color2: ColorsManager.primary2),


            const SizedBox(height: 20,),

            CustomButton(text:' طلبات تم الموافقة عليها    ', onPressed:(){

              Get.to( OrdersView(
                status: 'accept',
              ));
            }, color1:ColorsManager.primary, color2: ColorsManager.primary2),

            const SizedBox(height: 20,),
            CustomButton(text:' طلبات تم الغائها    ', onPressed:(){
              Get.to( OrdersView(
                status: 'refused',
              ));
            }, color1:ColorsManager.primary, color2: ColorsManager.primary2),
          ],
        ),
      ),
    );
  }
}
