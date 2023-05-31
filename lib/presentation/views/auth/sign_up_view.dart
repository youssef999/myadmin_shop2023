

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/presentation/resources/assets_manager.dart';
import 'package:shop_app/presentation/views/Home/main_home.dart';
import 'package:shop_app/presentation/views/auth/login_view.dart';
import 'package:shop_app/presentation/widgets/Custom_Text.dart';
import 'package:shop_app/presentation/widgets/Custom_button.dart';
import 'package:shop_app/presentation/widgets/custom_textformfield.dart';
import '../../bloc/auth/auth-states.dart';
import '../../bloc/auth/auth_cubit.dart';
import '../../const/app_message.dart';
import '../../resources/color_manager.dart';
import 'package:get/get.dart';
class SignUpView extends StatelessWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
        create: (BuildContext context) => AuthCubit(),
        child: BlocConsumer<AuthCubit, AuthStates>(
            listener: (context, state) {


              if(state is SignUpSuccessState){

                appMessage(text: 'تم انشاء الحساب بنجاح');

                Get.offAll(const MainHome());

              }

              if(state is SignUpErrorState){

                appMessage(text: 'حدث خطا');

              }

            },
            builder: (context, state) {
              AuthCubit cubit = AuthCubit.get(context);
              return Scaffold(
                backgroundColor:ColorsManager.primary2,
                appBar: AppBar(
                  toolbarHeight: 2,
                  backgroundColor:ColorsManager.primary,
                ),
                body:SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: Column(
                      children:  [
                        const SizedBox(height: 11,),
                        SizedBox(
                          height: 260,
                          child: Image.asset(AssetsManager.Logo,
                            fit:BoxFit.fill,
                          ),
                        ),
                        const SizedBox(height: 20,),
                        CustomTextFormField(hint: 'البريد الاكتروني',
                            obx: false, ontap: (){}, type: TextInputType.emailAddress, obs:false, color:ColorsManager.primary
                            , controller: cubit.emailController),
                        const SizedBox(height: 20,),
                        CustomTextFormField(hint: 'الاسم',
                            obx: false, ontap: (){}, type: TextInputType.text, obs:false, color:ColorsManager.primary
                            , controller: cubit.nameController),
                        const SizedBox(height: 30,),
                        CustomTextFormField(hint: 'كلمة المرور',
                            obx: true, ontap: (){}, type: TextInputType.visiblePassword, obs:true, color:ColorsManager.primary
                            , controller: cubit.passController),
                        const SizedBox(height: 20,),
                        CustomButton(text: 'انشاء حساب', onPressed: (){
                          cubit.userSignUp();
                          }, color1: ColorsManager.primary, color2:Colors.white),
                        const SizedBox(height: 34,),
                        InkWell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Custom_Text(text: 'لدي حساب بالفعل  ؟ ',fontSize:17,color:ColorsManager.primary,),
                              SizedBox(width: 30,),
                              Custom_Text(text: 'تسجيل دخول ',fontSize:15,color:Colors.grey,),
                            ],
                          ),
                          onTap:(){
                            Get.to(const LoginView());
                          },
                        )
                      ],
                    ),
                  ),
                ),
              );
            }));
  }
}
