import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/presentation/resources/color_manager.dart';
import 'package:shop_app/presentation/widgets/Custom_Text.dart';
import 'package:shop_app/presentation/widgets/custom_textformfield.dart';

import '../products/product_details_view.dart';


class SearchView extends StatefulWidget {


  @override
  _PostsScreenState createState() => _PostsScreenState();
}

class _PostsScreenState extends State<SearchView> {

  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();

  TextEditingController controller=TextEditingController();
  String searchData='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: ColorsManager.primary,
          toolbarHeight: 1,
        ),
        body: ListView(children:  [
          const SizedBox(
            height: 4,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration:BoxDecoration(
                border:Border.all(color:ColorsManager.primary)
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    hintText: 'ابحث هنا',
                    border:InputBorder.none,
                    icon:Icon(Icons.search,size:21,color:ColorsManager.primary,)
                  ),
                  onChanged:(value){
                    setState(() {
                      searchData=value;
                    });
                  },
                ),
              ),
            )
          ),
          const SizedBox(
            height: 20,
          ),
          SearchWidget()

        ]));
  }


  Widget SearchWidget() {
     return Container(
       height: 12900,
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('products')
              .where('name', isGreaterThanOrEqualTo: searchData)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: Text('Loading'));
            }
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Text('Loading...');
              default:
                      return   GridView.builder(
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
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: ColorsManager.primary2
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(
                                        height: 120,
                                        child: Image.network(posts['image']),),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Custom_Text(text: posts['name'],
                                        fontSize: 17,
                                        alignment: Alignment.center,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      RatingBar.builder(
                                        itemSize: 12,
                                        initialRating: double.parse(
                                            posts['rate'].toString()),
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemPadding:
                                        const EdgeInsets.symmetric(horizontal: 1.0),
                                        itemBuilder: (context, _) =>
                                        const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        unratedColor: Colors.grey,
                                        onRatingUpdate: (rating) {
                                          print(rating);
                                        },
                                      ),
                                      const SizedBox(height: 3,),
                                      Custom_Text(text: "${posts['price']} ",
                                        fontSize: 17,
                                        alignment: Alignment.center,
                                        fontWeight: FontWeight.bold,
                                      ),

                                    ],
                                  ),
                                ),
                              ),
                              onTap: () {

                                Get.to(ProductDetailsView(
                                  posts: posts,
                                  tag: 'img$index',
                                ));

                                },
                            );
                          });


            }
          }),
    );
  }

}