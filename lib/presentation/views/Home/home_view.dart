import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shop_app/data/local/local_data.dart';
import 'package:shop_app/presentation/resources/color_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shop_app/presentation/widgets/drawer.dart';
import '../../widgets/Custom_Text.dart';
import '../Cat/cat_products_view.dart';
import '../Search/search_view.dart';
import '../cart/cart_view.dart';
import '../products/product_details_view.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          elevation: 0.5,
          backgroundColor: ColorsManager.primary2,
          title:const Custom_Text(text: 'Shop App',alignment:Alignment.center,fontSize: 27,),
          iconTheme:const IconThemeData(color:ColorsManager.primary,size:30),
                actions:  [
                  SizedBox(width: 20,),
                  InkWell(child: Icon(Icons.search),
                  onTap:(){
                    Get.to(SearchView());
                  },
                  ),
                  SizedBox(width: 20,),
                ],

        ),
        drawer:  MainDrawer(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
             Row(
               children: const [
               ],
             ),
              CatWidget(),
              const SizedBox(
                height: 20,
              ),
              ProductWidget()
            ],
          ),
        ));
  }
}

Widget SliderWidget() {
  List images = [
    'assets/images/shop.jpg',
    'assets/images/shop2.jpg',
    'assets/images/shop3.png',
  ];

  return CarouselSlider(
    options: CarouselOptions(
      height: 200.0,
      autoPlay: true,
    ),
    items: images.map((i) {
      return Builder(
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.only(left: 28.0, right: 28),
            child: Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: const BoxDecoration(color: ColorsManager.primary2),
                child: Image.asset(i)),
          );
        },
      );
    }).toList(),
  );
}

RectTween _createRectTween(Rect begin, Rect end) {
return MaterialRectCenterArcTween(begin: begin, end: end);
}

Widget ProductWidget() {
  final box=GetStorage();
  String country=box.read('country');
  String currency=box.read('currency');
  return SizedBox(
    height: 12200,
    child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('products').where('country',isEqualTo:country).snapshots(),
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
                                  height: 2,
                                ),
                                Custom_Text(text: posts['cat'],fontSize:14,alignment:Alignment.center,
                               color:Colors.grey,
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
                                Custom_Text(text: "${posts['price']} "  "  $currency",fontSize:16,alignment:Alignment.center,
                                  fontWeight:FontWeight.bold,
                                ),

                              ],
                            ),
                          ),
                        ),
                      ),
                      onTap:(){
                       Get.to (ProductDetailsView(
                         posts: posts,
                         tag:'img$index'
                       ));
                      },
                    );
                  });
          }
        }),
  );
}

 Widget CatWidget() {
  return SizedBox(
    height: 140,
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
              return ListView.builder(
                scrollDirection:Axis.horizontal,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot posts = snapshot.data!.docs[index];
                    if (snapshot.data == null) {
                      return const CircularProgressIndicator();
                    }
                    return InkWell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius:BorderRadius.circular(10),
                              color:ColorsManager.primary2
                          ),
                          //  color: Colors.white,
                          child:  Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: 100,
                              //height: 2,
                              child: Custom_Text(text: posts['name'],fontSize:17,alignment:Alignment.center,
                                fontWeight:FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      onTap:(){
                        Get.to(CatProductsView(
                          cat: posts['name'],
                        ));
                      },
                    );
                  });
          }
        }),
  );
}