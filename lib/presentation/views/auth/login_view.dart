
import 'package:get/get.dart';
  import 'package:flutter/material.dart';
  import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/presentation/const/app_message.dart';
import 'package:shop_app/presentation/views/auth/sign_up_view.dart';
import 'package:shop_app/presentation/widgets/Custom_Text.dart';
import 'package:shop_app/presentation/widgets/Custom_button.dart';
import 'package:shop_app/presentation/widgets/custom_textformfield.dart';
import '../../bloc/auth/auth-states.dart';
import '../../bloc/auth/auth_cubit.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../Home/main_home.dart';
import 'forgot_pass_view.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
        create: (BuildContext context) => AuthCubit(),
        child: BlocConsumer<AuthCubit, AuthStates>(
            listener: (context, state) {
              if(state is LoginSuccessState){
                appMessage(text: 'تم تسجيل الدخول بنجاح');
                Get.offAll(const MainHome());
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
                        Container(
                          height: 260,
                          child: Image.asset(AssetsManager.Logo,
                          fit:BoxFit.fill,
                          ),
                        ),
                        const SizedBox(height: 20,),
                        CustomTextFormField(hint: 'البريد الاكتروني',
                            obx: false, ontap: (){}, type: TextInputType.emailAddress, obs:false, color:ColorsManager.primary
                            , controller: cubit.emailController),
                        const SizedBox(height: 30,),
                        CustomTextFormField(hint: 'كلمة المرور',
                            obx: true, ontap: (){}, type: TextInputType.visiblePassword, obs:true, color:ColorsManager.primary
                            , controller: cubit.passController),
                        const SizedBox(height: 20,),
                        CustomButton(text: 'تسجيل دخول', onPressed: (){
                          cubit.userLogin();
                        }, color1: ColorsManager.primary, color2:Colors.white),
                        
                        const SizedBox(height: 34,),
                        InkWell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Custom_Text(text: 'ليس لديك حساب ؟ ',fontSize:17,color:ColorsManager.primary,),
                              SizedBox(width: 30,),
                              Custom_Text(text: 'انشاء حساب جديد ',fontSize:15,color:Colors.grey,),
                            ],
                          ),
                          onTap:(){
                            Get.to(const SignUpView());
                          },
                        ),
                        const SizedBox(height: 34,),
                        //ForgotPassView
                        InkWell(
                          child: Row(
                            children: const [
                              SizedBox(width: 20,),
                              Custom_Text(text:  ' نسيت كلمة المرور ؟ ',
                              fontSize: 16,
                                alignment:Alignment.center,
                                color:Colors.grey,
                              ),
                              SizedBox(width: 22,),
                              Custom_Text(text: 'اعادة كلمة المرور ',
                                fontSize: 20,
                                alignment:Alignment.center,
                                color:ColorsManager.primary,
                              ),

                            ],
                          ),
                          onTap:(){

                            Get.to(const ForgotPassView());

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
