import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../bloc/admin/admin-states.dart';
import '../../../bloc/admin/admin_cubit.dart';
import '../../../const/app_message.dart';
import '../../../resources/color_manager.dart';
import '../../../widgets/Custom_Text.dart';
import '../../../widgets/Custom_button.dart';
import '../../../widgets/custom_textformfield.dart';
import '../admin_view.dart';

class AddNewCat extends StatelessWidget {
  const AddNewCat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => AdminCubit(),
        child: BlocConsumer<AdminCubit, AdminStates>(

            listener: (context, state) {

              if(state is AddNewCatSuccessState){

                appMessage(text: 'تم اضافة القسم بنجاح');

                Get.offAll(const AdminView());

              }
            },

            builder: (context, state) {

              AdminCubit cubit = AdminCubit.get(context);
              return Scaffold(
                backgroundColor:Colors.white,
                appBar:AppBar(
                  elevation: 0,
                  toolbarHeight: 5,
                  backgroundColor:ColorsManager.primary,
                ),
                body:
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(17.0),
                    child: Column(
                      children:  [
                        const SizedBox(height: 20,),


                        Container(
                            height: 140,
                            width: 600,
                            color:Colors.white,
                            child: Image.asset('assets/images/logo.png')),




                        const SizedBox(height: 20,),
                        CustomTextFormField(
                          controller:cubit.nameController,
                          color:Colors.black,
                          hint: "اسم القسم  ",
                          max: 2,
                          obs: false,
                          obx: false,
                          ontap:(){},
                          type:TextInputType.text,
                        ),
                        const SizedBox(height: 20,),

                        CustomButton(text: "اضافة",
                            onPressed: (){

                              cubit. addCatToFireBase();


                            }, color1:ColorsManager.primary,
                            color2: Colors.white),
                        const SizedBox(height: 30,),
                      ],
                    ),
                  ),
                ),
              );
            }));
  }
}