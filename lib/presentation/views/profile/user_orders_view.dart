
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
 import 'package:flutter/material.dart';
import 'package:shop_app/presentation/resources/color_manager.dart';
import 'package:shop_app/presentation/widgets/Custom_Text.dart';

import '../../../data/local/local_data.dart';

class UserOrdersView extends StatelessWidget {
  const UserOrdersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 60,
        backgroundColor:ColorsManager.primary,
        title: const Custom_Text(text: ' طلباتي السابقة  ',
          fontSize: 20,alignment:Alignment.center,color:ColorsManager.primary2,),
      ),
      body:ListView(
        children: [
          const SizedBox(height: 12,),

          UserOrdersWidget()
        ],
      ),
    );
  }
}
Widget UserOrdersWidget(){
final box=GetStorage();
String email=box.read('email')??"x";

  return Container(
    height: 76600,
    color:ColorsManager.primary2,
    child: StreamBuilder(
        stream:
        FirebaseFirestore.instance.collection('orders').where('user_email',isEqualTo:email )
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return  const Center(child: CircularProgressIndicator());
            default:
              return Expanded(
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot posts = snapshot.data!.docs[index];
                      if(snapshot.data == null) return const CircularProgressIndicator();
                      List order=posts['order'];
                      return Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Card(
                          color:Colors.grey[100],
                          child:Column(
                          children: [
                            const SizedBox(height: 10,),
                            Column(
                              children: [
                                const Custom_Text(text: 'بيانات العنوان',fontSize:28,alignment:Alignment.center,),
                                const Custom_Text(text:'العنوان',fontSize:18,alignment:Alignment.center,),
                                Custom_Text(text: posts['address'],fontSize:16,alignment:Alignment.center,color:Colors.grey),
                                const Custom_Text(text:'المبني ',fontSize:18,alignment:Alignment.center,),
                                Custom_Text(text: posts['home'],fontSize:16,alignment:Alignment.center,color:Colors.grey),
                                const Custom_Text(text:'الطابق ',fontSize:18,alignment:Alignment.center,),
                                Custom_Text(text: posts['floor'],fontSize:18,alignment:Alignment.center,color:Colors.grey),
                                const Custom_Text(text:'الهاتف ',fontSize:18,alignment:Alignment.center,),
                                Custom_Text(text: posts['phone'],fontSize:18,alignment:Alignment.center,color:Colors.grey),
                              ],
                            ),
                            const Divider(thickness: 0.7,color:Colors.grey,),
                            (posts['date']!=null)?
                            Column(
                              children: [
                                const SizedBox(height: 10,),
                                Row(children: [
                                  const SizedBox(width: 11,),
                                  const Custom_Text(text: 'تاريخ الطلب',fontSize: 16,color:ColorsManager.primary,),
                                  const SizedBox(width: 11,),
                                  Custom_Text(text: posts['date'],fontSize: 16,color:Colors.grey,)
                                ],),

                                const SizedBox(height: 10,),
                                Row(children: [
                                  const SizedBox(width: 11,),
                                  const Custom_Text(text: 'توقيت الطلب',fontSize: 16,color:ColorsManager.primary,),
                                  const SizedBox(width: 11,),
                                  Custom_Text(text: posts['time'],fontSize: 16,color:Colors.grey,)
                                ],)
                              ],
                            ):const SizedBox(),
                            const SizedBox(height: 10,),
                            const Custom_Text(text: 'الطلب ',fontSize:28,alignment:Alignment.center,),
                            for(int i=0;i<order.length;i++)
                             Column(
                               children: [
                                 Row(
                                    children: [
                                      const SizedBox(width: 11,),
                                      Custom_Text(text:order[i]['name'],fontSize:21,alignment:Alignment.center),
                                      const SizedBox(width: 22,),
                                      Column(
                                        children: [
                                          const Custom_Text(text:'السعر',fontSize:21,alignment:Alignment.center),
                                          Custom_Text(text:order[i]['price'],fontSize:21,alignment:Alignment.center),
                                        ],
                                      ),
                                      const SizedBox(width:22,),
                                      Custom_Text(text:" X "+order[i]['quant'],fontSize:21,alignment:Alignment.center),
                                    ],
                                  ),
                                 const Divider(thickness: 0.7,color:Colors.grey,)
                               ],
                             ),

                            const SizedBox(height: 10,),
                            Custom_Text(text: "الاجمالي = "+posts['total'],fontSize:28,alignment:Alignment.center,),
                            const SizedBox(height: 10,),
                          ],
                        ),),
                      );

                    }),
              );
          }
        }
    ),
  );

}