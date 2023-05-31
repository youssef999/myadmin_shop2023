
import 'package:get/get.dart';

import 'package:get_storage/get_storage.dart';
  import 'package:flutter/material.dart';
import 'package:shop_app/presentation/resources/color_manager.dart';
import 'package:shop_app/presentation/views/checkout/checkout_view.dart';
import 'package:shop_app/presentation/widgets/Custom_Text.dart';
import 'package:shop_app/presentation/widgets/Custom_button.dart';
import 'package:shop_app/presentation/widgets/custom_textformfield.dart';
  import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/models/cart_model.dart';
import '../../bloc/cart/cart_cubit.dart';
import '../../bloc/location/location_cubit.dart';
import '../../bloc/location/location_states.dart';

class LocationFormView extends StatelessWidget {

  List <CartProductModel> order;
  String total;
   LocationFormView({Key? key,required this.order,required this.total}) : super(key: key);

   @override
   Widget build(BuildContext context) {
     return  BlocProvider(
         create: (BuildContext context) => LocationCubit(),
         child: BlocConsumer<LocationCubit, LocationStates>(
         listener: (context, state) {},
     builder: (context, state) {

     LocationCubit cubit = LocationCubit.get(context);
     return Scaffold(
       appBar:AppBar(
         toolbarHeight: 2,
         backgroundColor:ColorsManager.primary,
       ),
       body:Padding(
         padding: const EdgeInsets.all(21.0),
         child: ListView(
           children:  [
             const SizedBox(height: 4,),
             const Custom_Text(text: 'بيانات عنوانك',fontSize: 21,alignment:Alignment.center,),
             const SizedBox(height: 20,),
             CustomTextFormField(hint: 'العنوان', obx: false, ontap: (){}
                 , type: TextInputType.text, obs: false, color: ColorsManager.primary, controller: cubit.addressController),
             const SizedBox(height: 20,),
             const SizedBox(height: 20,),
             CustomTextFormField(hint: 'رقم هاتفك ', obx: false, ontap: (){}
                 , type: TextInputType.phone, obs: false, color: ColorsManager.primary, controller: cubit.phoneController),
             // CustomTextFormField(hint: 'المبني', obx: false, ontap: (){}
             //     , type: TextInputType.text, obs: false, color: ColorsManager.primary, controller: cubit.homeController),
             const SizedBox(height: 20,),
             CustomTextFormField(hint: 'رقم الشقة', obx: false, ontap: (){}
                 , type: TextInputType.number, obs: false, color: ColorsManager.primary, controller: cubit.homeController),
             const SizedBox(height: 20,),
             CustomTextFormField(hint: 'رقم الطابق', obx: false, ontap: (){}
                 , type: TextInputType.number, obs: false, color: ColorsManager.primary, controller: cubit.floorController),
             const SizedBox(height: 20,),
             CustomButton(text: 'التالي', onPressed: () {

               final box=GetStorage();
               box.write('address', cubit.addressController.text);
               box.write('phone', cubit.phoneController.text);
               box.write('home', cubit.homeController.text);
               box.write('floor', cubit.homeController.text);

               Get.to(CheckOutView(
                 total: total,
                 order: order,
                 home: cubit.homeController.text,
                 floor: cubit.floorController.text,
                 phone: cubit.phoneController.text,
                 address: cubit.addressController.text,
               ));
             }, color1: ColorsManager.primary, color2: ColorsManager.primary2)
           ],
         ),
       ),
     );
     }));
   }
}