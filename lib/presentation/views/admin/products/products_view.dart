

 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:shop_app/presentation/resources/color_manager.dart';
import 'package:shop_app/presentation/views/admin/products/product_details.dart';
import 'package:shop_app/presentation/widgets/Custom_Text.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        toolbarHeight: 3,
        backgroundColor:ColorsManager.primary,
      ),
      body:ListView(
        children: [
          ProductWidget()
        ],
      ),
    );
  }
}

 Widget ProductWidget() {
   return SizedBox(
     height: 12200,
     child: StreamBuilder(
         stream: FirebaseFirestore.instance.collection('products')
             .where('country',isNotEqualTo: '')
             .snapshots(),
         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
           if (!snapshot.hasData) {
             return const Center(child: CircularProgressIndicator());
           }
           switch (snapshot.connectionState) {
             case ConnectionState.waiting:
               return const Center(child: CircularProgressIndicator());
             default:
               return GridView.builder(
                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                       crossAxisCount: 2,
                       crossAxisSpacing: 2,
                       mainAxisSpacing: 4,
                       childAspectRatio:0.85
                   ),
                   physics: const NeverScrollableScrollPhysics(),
                   itemCount: snapshot.data!.docs.length,
                   itemBuilder: (context, index) {
                     DocumentSnapshot posts = snapshot.data!.docs[index];
                     if (snapshot.data == null) {
                       return const CircularProgressIndicator();
                     }
                     return InkWell(
                       child: Hero(
                         tag: 'img$index',
                         child: Padding(
                           padding: const EdgeInsets.all(4.0),
                           child: Container(
                             decoration: BoxDecoration(
                                 borderRadius:BorderRadius.circular(10),
                                 color:ColorsManager.primary2
                             ),
                             child: Column(
                               children: <Widget>[
                                 SizedBox(
                                   height: 130,
                                   width: MediaQuery.of(context).size.width,
                                   child:  Image.network(posts['image'],fit:BoxFit.fitWidth,),),
                                 const SizedBox(
                                   height: 5,
                                 ),

                                 Custom_Text(text: posts['country'],fontSize:14,alignment:Alignment.center,
                                   color:Colors.red,
                                 ),
                                 const SizedBox(height: 2,),
                                 Custom_Text(text: posts['name'],fontSize:17,alignment:Alignment.center,
                                   fontWeight:FontWeight.bold,
                                 ),
                                 const SizedBox(height: 3,),
                                 RatingBar.builder(
                                   itemSize:14,
                                   initialRating:double.parse(  posts['rate'].toString()),
                                   minRating: 1,
                                   direction: Axis.horizontal,
                                   allowHalfRating: true,
                                   itemCount: 5,
                                   itemPadding:
                                   const EdgeInsets.symmetric(horizontal: 1.0),
                                   itemBuilder: (context, _) => const Icon(
                                     Icons.star,
                                     color: Colors.amber,
                                   ),
                                   unratedColor:Colors.grey,
                                   onRatingUpdate: (rating) {
                                     print(rating);
                                   },
                                 ),
                                 const SizedBox(height: 3,),
                                 Custom_Text(text: "${posts['price']} ",fontSize:16,alignment:Alignment.center,
                                   fontWeight:FontWeight.bold,
                                 ),

                               ],
                             ),
                           ),
                         ),
                       ),
                       onTap:(){
                         Get.to(AdminProductDetails(
                           tag: 'img$index',
                           posts: posts,
                         ));
                         // Get.to (ProductDetailsView(
                         //     posts: posts,
                         //     tag:'img$index'
                         // ));
                       },
                     );
                   });
           }
         }),
   );
 }