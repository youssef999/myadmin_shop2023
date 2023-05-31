import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_app/presentation/views/Home/main_home.dart';
import 'package:shop_app/presentation/widgets/Custom_Text.dart';
import 'package:http/http.dart' as http;
import '../../const/app_message.dart';
import 'admin-states.dart';

class AdminCubit extends Cubit<AdminStates> {
  AdminCubit() : super(AppIntialState());

  static AdminCubit get(context) => BlocProvider.of(context);
  TextEditingController nameController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController coinsController = TextEditingController();
  TextEditingController codeIdController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  TextEditingController freeController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController numController = TextEditingController();
  TextEditingController desController = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController video = TextEditingController();
  TextEditingController days = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController catController = TextEditingController();
  TextEditingController currencyController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  XFile? pickedImageXFile;
  var imageLink = '';
  String downloadUrl = '';
  bool data=false;
  showDialogBox(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            backgroundColor: Colors.white,
            title: const Custom_Text(
              text: 'الصورة ',
              alignment: Alignment.center,
              fontSize: 19,
              color: Colors.black,
            ),
            children: [
              SimpleDialogOption(
                child: const Custom_Text(
                  text: 'كاميرا ',
                  alignment: Alignment.center,
                  fontSize: 14,
                  color: Colors.black,
                ),
                onPressed: () {
                  captureImage();
                },
              ),
              SimpleDialogOption(
                  child: const Custom_Text(
                    text: ' اختر صورة  ',
                    alignment: Alignment.center,
                    fontSize: 14,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    pickImage();
                  }),
              SimpleDialogOption(
                  child: const Custom_Text(
                    text: 'الغاء  ',
                    alignment: Alignment.center,
                    fontSize: 14,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    Get.back();
                  })
            ],
          );
        });
  }

  captureImage() async {
    pickedImageXFile = await _picker.pickImage(source: ImageSource.camera);
    Get.back();
    pickedImageXFile;
    emit(setImageSuccessState());
    changeData();
    // uploadImageToFirebaseStorage(pickedImageXFile!);
  }

  pickImage() async {
    pickedImageXFile = await _picker.pickImage(source: ImageSource.gallery);
    Get.back();
    emit(setImageSuccessState());
    changeData();
    //   uploadImageToFirebaseStorage(pickedImageXFile!);
  }

  Future<String> uploadImageToFirebaseStorage(XFile image) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference reference =
          FirebaseStorage.instance.ref().child('images/$fileName');
      UploadTask uploadTask = reference.putFile(File(image.path));
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
      downloadUrl = await taskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      // Handle any errors that occur during the upload process
      print('Error uploading image to Firebase Storage: $e');
      return '';
    }
  }


  addCountryToFireBase() async {
    uploadImageToFirebaseStorage(pickedImageXFile!).then((value) async {
      if(nameController.text.length>1){
        await FirebaseFirestore.instance.collection('countries').add({
          'name': nameController.text,
          'currency': desController.text,
          'image': downloadUrl,
        }).then((value) {
          print('addddddddd');
          emit(AddNewProductSuccessState());
        });
      }else{
        appMessage(text: 'تاكد من ادخال البيانات بشكل صحيح');
      }

    });
  }



  addDataToFireBase() async {
    uploadImageToFirebaseStorage(pickedImageXFile!).then((value) async {
      final random = Random.secure();
      const chars =
          'abcdefghijklmnopqrstuvwxyz0123456789ABCDEFGRTYUIOAPMSKSOAPALIOWWNCVZ';
      String result = '';

      for (int i = 0; i < 16; i++) {
        result += chars[random.nextInt(chars.length)];
      }

      if(nameController.text.length>1&&desController.text.length>5&&
      countryController.text.length>1&&price.text.length>0&&catController.text.length>2){
        await FirebaseFirestore.instance.collection('products').add({
          'name': nameController.text,
          'des': desController.text,
          'image': downloadUrl,
          'video':'',
          'country': countryController.text,
          'productid': result,
          'price': num.parse(price.text),
          'cat': catController.text,
          'rate': 0.0,
        }).then((value) {
          print('addddddddd');
          emit(AddNewProductSuccessState());
        });
      }else{
        appMessage(text: 'تاكد من ادخال البيانات بشكل صحيح');
      }

    });
  }

  addCatToFireBase() async {
    if(nameController.text.length>1){
      await FirebaseFirestore.instance.collection('categories').add({
        'name': nameController.text,
        'image1': '',
        'image': '',
      }).then((value) {
        print('addddddddd');
        emit(AddNewCatSuccessState());
      });
    }else{
      appMessage(text: 'تاكد من ادخال البيانات بشكل صحيح');
    }
  }



  changeData(){
    data=true;
    emit(ChangeDataSuccessState());
  }


  EditDataInFireBase ({required DocumentSnapshot posts})async{


    String name='';
    String des='';
    String vid='';
    num pr=0.0;
    String country='';
    String cat='';
    String img='';

    if(nameController.text.length<2){
      name=posts['name'];
    }
    else{
      name=nameController.text;
    }
    if(desController.text.length<2){
      des=posts['des'];
    }
    else{
      des=desController.text;
    }

    if(video.text.length<2){
      vid=posts['video'];
    }else{
      vid=video.text;
    }
    if(price.text.length<2){
      pr=posts['price'];
    }else{
      pr=num.parse(price.text);
    }


    if(countryController.text.length<2){
      country=posts['country'];
    }else{
     country=countryController.text;
    }
    if(catController.text.length<2){
      cat=posts['cat'];
    }else{
      cat=catController.text;
    }



    if(data==true){
      uploadImageToFirebaseStorage(pickedImageXFile!);
      img= downloadUrl;
    }else{
      print('noxxxxx');
      img=posts['image'];
    }


    final CollectionReference _updates =
    FirebaseFirestore.instance.collection('products');
    await _updates
        .where('productid', isEqualTo: posts['productid'])
        .get().then((snapshot) {
      snapshot.docs.last.reference.update({
        'name':name,
        'des': des,
        'image': img,
        'video':vid,
        'country': country,
        'price': pr,
        'cat': cat,
        'rate': 0.0,
      }).then((value) {

        print("EDITED");
        emit(EditProductsSuccessState());

      });
    });
  }


}
