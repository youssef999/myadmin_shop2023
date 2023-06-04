


 import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:shop_app/presentation/bloc/admin/admin-states.dart';
import 'package:shop_app/presentation/const/app_message.dart';
import 'package:shop_app/presentation/resources/color_manager.dart';
import 'package:shop_app/presentation/views/admin/admin_view.dart';
import 'package:shop_app/presentation/widgets/Custom_Text.dart';
import 'package:shop_app/presentation/widgets/Custom_button.dart';
import '../../../bloc/admin/admin_cubit.dart';
import '../../../widgets/custom_textformfield.dart';

class EditProduct extends StatelessWidget {
  DocumentSnapshot posts;

  EditProduct({Key? key,required this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => AdminCubit(),
        child: BlocConsumer<AdminCubit, AdminStates>(

        listener: (context, state) {

          if(state is EditProductsSuccessState){
            appMessage(text: 'تم التعديل بنجاح');
            Get.offAll(const AdminView());
          }

    },

    builder: (context, state) {

    AdminCubit cubit = AdminCubit.get(context);
      List images=posts['image'];
    return Scaffold(
      appBar:AppBar(
        toolbarHeight: 3,
        backgroundColor:ColorsManager.primary,
      ),
      body:Padding(
        padding: const EdgeInsets.all(22.0),
        child: ListView(
          children:  [
            const SizedBox(height: 1,),

            cubit.pickedImageXFile != null?
            InkWell(
              child: Container(
                height:  MediaQuery.of(context).size.width*0.6,
                width: MediaQuery.of(context).size.width*0.8,
                decoration:BoxDecoration(
                    image: DecorationImage(
                        image:FileImage(
                            File(cubit.pickedImageXFile!.path)),
                        fit:BoxFit.fill
                    )
                ),
              ),
              onTap:(){
                cubit.showDialogBox(context);
              },
            ):InkWell(
              child: Column(
                children:   [

              //    for(int i=0;i<images.length;i++)
                  Container(
                     // height:111,
                      width: MediaQuery.of(context).size.width,
                      child: Image.network(posts['image'][0])),

                  const SizedBox(height: 10,),
                  // const Custom_Text(text: 'اضف صورة جديدة ',color:Colors.black,
                  //   fontSize:21,alignment:Alignment.center,
                  // ),
                ],
              ),
              onTap:(){
               // cubit.showDialogBox(context);
              },
            ),
            const SizedBox(height: 20,),
            CustomTextFormField(
              controller:cubit.nameController,
              color:Colors.black,
              hint: posts['name'],
              max: 2,
              obs: false,
              obx: false,
              ontap:(){},
              type:TextInputType.text,
            ),
            const SizedBox(height: 16,),
            CustomTextFormField(
              controller:cubit.catController,
              color:Colors.black,
              hint:posts['cat'],
              max: 2,
              obs: false,
              obx: false,
              ontap:(){},
              type:TextInputType.text,
            ),
            const SizedBox(height: 16,),
            CustomTextFormField(
              controller:cubit.countryController,
              color:Colors.black,
              hint:posts['country'],
              max: 2,
              obs: false,
              obx: false,
              ontap:(){},
              type:TextInputType.text,
            ),
            const SizedBox(height: 16,),
            CustomTextFormField(
              controller:cubit.desController,
              color:Colors.black,
              hint:posts['des'].toString(),
              max: 28,
              obs: false,
              obx: false,
              ontap:(){},
              type:TextInputType.text,
            ),
            const SizedBox(height: 16,),
            CustomTextFormField(
              controller:cubit.price,
              color:Colors.black,
              hint: posts['price'].toString(),
              max: 2,
              obs: false,
              obx: false,
              ontap:(){},
              type:TextInputType.number,
            ),
            const SizedBox(height: 16,),
            CustomTextFormField(
              controller:cubit.video,
              color:Colors.black,
              hint: 'رابط الفيديو',
              max: 2,
              obs: false,
              obx: false,
              ontap:(){},
              type:TextInputType.number,
            ),
            const SizedBox(height: 20,),
            CustomButton(text: " تعديل ",
                onPressed: (){

                  cubit.EditDataInFireBase(posts: posts);


                }, color1:ColorsManager.primary,
                color2: Colors.white),
            const SizedBox(height: 30,),
          ],
        ),
      ),
    );
    }));
  }
}