import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../bloc/admin/admin-states.dart';
import '../../bloc/admin/admin_cubit.dart';
import '../../const/app_message.dart';
import '../../resources/color_manager.dart';
import '../../widgets/Custom_Text.dart';
import '../../widgets/Custom_button.dart';
import 'admin_view.dart';


class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => AdminCubit(),
        child: BlocConsumer<AdminCubit, AdminStates>(

            listener: (context, state) {

              if(state is AddNewSplashSuccessState){
                appMessage(text: 'تم اضافة  بنجاح');
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

                        cubit.pickedImageXFiles != null?
                        Column(
                          children: [
                            InkWell(
                              child: Container(
                                height:  MediaQuery.of(context).size.width*0.41,
                                width: MediaQuery.of(context).size.width*0.6,
                                decoration:BoxDecoration(
                                    image: DecorationImage(
                                        image:FileImage(
                                            File(cubit.pickedImageXFiles![0].path)),
                                        fit:BoxFit.fill
                                    )
                                ),
                              ),
                              onTap:(){
                                cubit.pickMultiImage();
                              },
                            ),

                            const SizedBox(height: 31,),

                          ],
                        ):














                        InkWell(
                          child: Column(
                            children: const [

                              CircleAvatar(
                                  radius: 100,
                                  child:Icon(Icons.image,size: 60,)
                              ),
                              SizedBox(height: 10,),
                              Custom_Text(text: 'اضف صورة ',color:Colors.black,
                                fontSize:21,alignment:Alignment.center,
                              ),
                            ],
                          ),
                          onTap:(){
                            cubit.pickImage();
                            //  cubit.showDialogBox(context);
                          },
                        ),
                        const SizedBox(height: 20,),

                        const SizedBox(height: 20,),
                        CustomButton(text: "اضافة",
                            onPressed: (){
                              cubit.addDataToFireBase();

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