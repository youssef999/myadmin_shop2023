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

class AddNewProduct extends StatelessWidget {
  const AddNewProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => AdminCubit(),
        child: BlocConsumer<AdminCubit, AdminStates>(

            listener: (context, state) {

              if(state is AddNewProductSuccessState){

                appMessage(text: 'تم اضافة المنتج بنجاح');

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
                            const Divider(),
                            (cubit.pickedImageXFiles!.length>1)?
                            Container(
                              height:  MediaQuery.of(context).size.width*0.41,
                              width: MediaQuery.of(context).size.width*0.6,
                              decoration:BoxDecoration(
                                  image: DecorationImage(
                                      image:FileImage(
                                          File(cubit.pickedImageXFiles![1].path)),
                                      fit:BoxFit.fill
                                  )
                              ),
                            ):const SizedBox(),

                            (cubit.pickedImageXFiles!.length>2)?
                            Container(
                              height:  MediaQuery.of(context).size.width*0.41,
                              width: MediaQuery.of(context).size.width*0.6,
                              decoration:BoxDecoration(
                                  image: DecorationImage(
                                      image:FileImage(
                                          File(cubit.pickedImageXFiles![2].path)),
                                      fit:BoxFit.fill
                                  )
                              ),
                            ):const SizedBox(),

                            (cubit.pickedImageXFiles!.length>3)?
                            Container(
                              height:  MediaQuery.of(context).size.width*0.41,
                              width: MediaQuery.of(context).size.width*0.6,
                              decoration:BoxDecoration(
                                  image: DecorationImage(
                                      image:FileImage(
                                          File(cubit.pickedImageXFiles![3].path)),
                                      fit:BoxFit.fill
                                  )
                              ),
                            ):const SizedBox(),
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
                            cubit.pickMultiImage();
                          //  cubit.showDialogBox(context);
                          },
                        ),
                        const SizedBox(height: 20,),
                        CustomTextFormField(
                          controller:cubit.nameController,
                          color:Colors.black,
                          hint: "الاسم ",
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
                          hint: "التصنيف",
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
                          hint: "البلد",
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
                          hint: "وصف المنتج ",
                          max: 6,
                          obs: false,
                          obx: false,
                          ontap:(){},
                          type:TextInputType.text,
                        ),
                        const SizedBox(height: 16,),
                        CustomTextFormField(
                          controller:cubit.quant,
                          color:Colors.black,
                          hint: "اقصي كمية متاحة من هذا المنتج ",
                          max: 2,
                          obs: false,
                          obx: false,
                          ontap:(){},
                          type:TextInputType.number,
                        ),
                        const SizedBox(height: 16,),
                        CustomTextFormField(
                          controller:cubit.price,
                          color:Colors.black,
                          hint: "سعر المنتح ",
                          max: 2,
                          obs: false,
                          obx: false,
                          ontap:(){},
                          type:TextInputType.number,
                        ),
                        const SizedBox(height: 16,),
                        CustomTextFormField(
                          controller:cubit.rate,
                          color:Colors.black,
                          hint: "التقييم الافتراضي ",
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
                          hint: 'رابط الفيديو ',
                          max: 4,
                          obs: false,
                          obx: false,
                          ontap:(){},
                          type:TextInputType.text,
                        ),
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