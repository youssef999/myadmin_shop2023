


 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/presentation/resources/color_manager.dart';
import 'package:shop_app/presentation/widgets/Custom_Text.dart';

class OrdersView extends StatelessWidget {
  const OrdersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: ColorsManager.primary,
        toolbarHeight: 2,
      ),
      body: ListView(
        children: [
          OrdersWidget()
        ],
      ),
    );
  }
}

 Widget OrdersWidget(){


   return Container(
     height: 76600,
     color:ColorsManager.primary2,
     child: StreamBuilder(
         stream:
         FirebaseFirestore.instance.collection('orders')
             .orderBy('date',descending:true )
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
                                   const Custom_Text(text:'البريد الالكتروني ',fontSize:18,alignment:Alignment.center,),
                                   Custom_Text(text: posts['user_email'],fontSize:16,alignment:Alignment.center,color:Colors.grey),
                                   const SizedBox(height: 10,),
                                   const Custom_Text(text:'الاسم  ',fontSize:18,alignment:Alignment.center,),
                                   Custom_Text(text: posts['user_name'],fontSize:16,alignment:Alignment.center,color:Colors.grey),
                                 ],
                               ),
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
