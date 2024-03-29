
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/presentation/resources/color_manager.dart';
import 'package:shop_app/presentation/views/admin/admin_view.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc_obs.dart';


 void main()async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp();
  runApp(const MyApp());
 }

 class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      debugShowCheckedModeBanner: false,
      textDirection:TextDirection.rtl,
      title: 'ADMIN',
      color:ColorsManager.primary,
      theme: ThemeData(
        primarySwatch: Colors.red,
        appBarTheme:const AppBarTheme(color:ColorsManager.primary)
      ),
      home://FavProductsView()
 //     LoginView()
      const AdminView()
    );
  }
}


