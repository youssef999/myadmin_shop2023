import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
 import 'package:flutter/material.dart';
import 'package:shop_app/data/local/local_data.dart';
import 'package:shop_app/domain/models/cart_model.dart';
import 'package:shop_app/presentation/const/app_message.dart';
import 'package:shop_app/presentation/widgets/Custom_Text.dart';
import 'package:shop_app/presentation/widgets/Custom_button.dart';
import '../../bloc/cart/cart_cubit.dart';
import '../../bloc/cart/cart_states.dart';
import '../../resources/color_manager.dart';
import 'order_done_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class CheckOutView extends StatelessWidget {
  List <CartProductModel> order;
  String total;
  String address, phone, home, floor;


  CheckOutView(
      {super.key, required this.order, required this.total, required this.home, required this.phone, required this.address, required this.floor});

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
        create: (BuildContext context) => CartCubit()..getAllProduct(),
        child: BlocConsumer<CartCubit, CartStates>(
            listener: (context, state) {},
            builder: (context, state) {

        CartCubit cubit = CartCubit.get(context);
        final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 3,
        backgroundColor: ColorsManager.primary,
      ),
      bottomNavigationBar: CustomButton(
        text: 'تاكيد الطلب' + "   " + "$total",
        color1: ColorsManager.primary,
        color2: ColorsManager.primary2,
        onPressed: () {
          addOrderToFireBase();
          cubit.DeleteAll(order[0]);
        },
      ),
      body: ListView(
        children: [
          LocationWidget(
              address: address, phone: phone, floor: floor, home: home),
          const SizedBox(height: 14,),
          Row(children: const [
            SizedBox(width: 17,),
            Icon(Icons.circle,color:ColorsManager.primary,size: 24,),
            SizedBox(width: 33,),
            Custom_Text(text: 'الدفع عند التوصيل',fontSize: 17,alignment:Alignment.topRight,color:Colors.black45,),
          ],),
          const SizedBox(height: 14,),
          OrderWidget(order: order, total: total)
        ],
      ),
    );

            }));

}


  Widget LocationWidget(
      {required String address, required String phone, required String home, required String floor}) {
    return Card(
      color: Colors.grey[300],
      child: Column(
        children: [
          const SizedBox(height: 11,),
          const Custom_Text(text: 'بيانات العنوان الخاص بك',
            alignment: Alignment.center,
            fontSize: 21,
            color: ColorsManager.primary,),
          const SizedBox(height: 11,),
          const Custom_Text(text: 'العنوان',
            alignment: Alignment.center,
            fontSize: 16,
            color: ColorsManager.primary,),
          Custom_Text(text: address,
            alignment: Alignment.center,
            fontSize: 16,
            color: Colors.grey,),
          const SizedBox(height: 11,),
          const Custom_Text(text: 'رقم المبني',
            alignment: Alignment.center,
            fontSize: 16,
            color: ColorsManager.primary,),
          Custom_Text(text: home,
            alignment: Alignment.center,
            fontSize: 16,
            color: Colors.grey,),
          const SizedBox(height: 11,),
          const Custom_Text(text: 'رقم الهاتف',
            alignment: Alignment.center,
            fontSize: 16,
            color: ColorsManager.primary,),
          Custom_Text(text: phone,
            alignment: Alignment.center,
            fontSize: 16,
            color: Colors.grey,),
          const SizedBox(height: 11,),
          const Custom_Text(text: 'رقم الطابق',
            alignment: Alignment.center,
            fontSize: 16,
            color: ColorsManager.primary,),
          Custom_Text(text: floor,
            alignment: Alignment.center,
            fontSize: 16,
            color: Colors.grey,),
          const SizedBox(height: 11,),
        ],
      ),
    );
  }

  Widget OrderWidget(
      {required List <CartProductModel> order, required String total}) {
    return SizedBox(
      height: 2100,
      child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: order.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Row(
                  children: [
                    const SizedBox(height: 11,),
                    Column(
                      children: [
                        const SizedBox(height: 10,),
                        SizedBox(
                            width: 100,
                            child: Image.network(order[index].image
                                .toString())),
                        const SizedBox(height: 10,),
                        Custom_Text(text: order[index].name.toString(),
                            alignment: Alignment.center,
                            fontSize: 16),
                        const SizedBox(height: 10,),
                      ],
                    ),
                    const SizedBox(height: 12,),
                    const SizedBox(width: 11,),
                    Column(
                      children: [
                        const Custom_Text(text: 'السعر ', fontSize: 18),
                        Custom_Text(text: order[index].price.toString(),
                            alignment: Alignment.center,
                            fontSize: 16),
                      ],
                    ),
                    const SizedBox(width: 11,),
                    Custom_Text(text: " X ${order[index].quantity}",
                        alignment: Alignment.center,
                        fontSize: 16),
                  ],
                ),
              ),
            );
          }),
    );
  }

  addOrderToFireBase() async {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
    final box=GetStorage();
    String email=box.read('email');
    String name=box.read('name');
    DateTime now = DateTime.now();
    String currentDate = '${now.year}-${now.month}-${now.day}';
    String currentTime = '${now.hour}:${now.minute}:${now.second}';

    List<String>orderNames=[];
    List<String>orderQuant=[];
    List<String>orderPrice=[];

    for(int i=0;i<order.length;i++){
      orderNames.add(order[i].name!);
    }

    for(int i=0;i<order.length;i++){
      orderQuant.add(order[i].quantity.toString());
    }

    for(int i=0;i<order.length;i++){
      orderPrice.add(order[i].price.toString());
    }


    await FirebaseFirestore.instance.collection('orders').add({
      'order': [
        for(int i=0;i<order.length;i++)
        {
          "name":orderNames[i],
          "quant":orderQuant[i],
          "price":orderPrice[i],
        }
      ],
      'user_name': name,
      'user_email': email,
      'address': address,
       'phone':phone,
       'home':home,
       'floor':floor,
       'total':total,
      'date':currentDate,
      'time':currentTime,
    }).then((value) {
      appMessage(text: 'تم اضافة طليك بنجاح');

      Noti.showBigTextNotification(title: "New message title", body: "Your long body",
          fln: flutterLocalNotificationsPlugin);
      Get.offAll(const OrderDoneView());
    });
  }
}

class Noti{
  static Future initialize(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var androidInitialize = new AndroidInitializationSettings('mipmap/ic_launcher');
 //   var iOSInitialize = new IOSInitializationSettings();
    var initializationsSettings = new InitializationSettings(android: androidInitialize,
       // iOS: iOSInitialize
    );
    await flutterLocalNotificationsPlugin.initialize(initializationsSettings );
  }

  static Future showBigTextNotification({var id =0,required String title, required String body,
    var payload, required FlutterLocalNotificationsPlugin fln
  } ) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
    new AndroidNotificationDetails(
      'you_can_name_it_whatever1',
      'channel_name',

      playSound: true,
      sound: RawResourceAndroidNotificationSound('notification'),
      importance: Importance.max,
      priority: Priority.high,
    );

    var not= NotificationDetails(android: androidPlatformChannelSpecifics,
       // iOS: IOSNotificationDetails()
    );
    await fln.show(0, title, body,not );
  }

}