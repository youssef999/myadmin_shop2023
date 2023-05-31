

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:shop_app/presentation/resources/color_manager.dart';
import 'package:shop_app/presentation/views/admin/products/product_details.dart';
import 'package:shop_app/presentation/widgets/Custom_Text.dart';

class CatView extends StatelessWidget {
  const CatView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        toolbarHeight: 3,
        backgroundColor:ColorsManager.primary,
      ),
      body:ListView(
        children: [
          CatWidget()
        ],
      ),
    );
  }
}

Widget CatWidget() {
  return SizedBox(
    height: 12200,
    child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('categories').snapshots(),
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
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius:BorderRadius.circular(10),
                              color:ColorsManager.primary2
                          ),
                          child: Column(
                            children: <Widget>[
                              const SizedBox(height: 2,),
                              Custom_Text(text: posts['name'],fontSize:17,alignment:Alignment.center,
                                fontWeight:FontWeight.bold,
                              ),


                            ],
                          ),
                        ),
                      ),
                      onTap:(){
                        // Get.to(AdminProductDetails(
                        //   tag: 'img$index',
                        //   posts: posts,
                        // ));
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