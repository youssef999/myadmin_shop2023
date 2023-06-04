import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_storage/get_storage.dart';
 import 'package:flutter/material.dart';
import 'package:shop_app/data/local/local_data.dart';
import 'package:shop_app/presentation/resources/color_manager.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shop_app/presentation/views/products/product_details_view.dart';
import '../../widgets/Custom_Text.dart';
import 'package:get/get.dart';

class CatProductsView extends StatelessWidget {
  String cat;

  CatProductsView({Key? key, required this.cat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        elevation: 0.4,
        backgroundColor: ColorsManager.primary,
        title: Custom_Text(text: 'قسم'+" "+cat,fontSize: 26,alignment: Alignment.center,color:ColorsManager.primary2),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 15,),
          const SizedBox(height: 20,),
          CatProductWidget()
        ],
      ),
    );
  }

  Widget CatProductWidget() {

    final box=GetStorage();
    String country=box.read('country');
    String currency=box.read('currency');
    return SizedBox(
      height: 12200,
      child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('products').where(
              'cat', isEqualTo: cat)
              .where('country', isEqualTo: country)
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
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: ColorsManager.primary
                            ),
                            child: Column(
                              children: <Widget>[

                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: 126,
                                  child: Image.network(posts['image'][0],
                                  fit:BoxFit.fitWidth,
                                  ),
                                ),

                                const SizedBox(
                                  height: 4,
                                ),

                                Custom_Text(text: posts['cat'],
                                  fontSize: 14,
                                  alignment: Alignment.center,
                                  color: ColorsManager.primary3
                                ),


                                const SizedBox(height: 2,),
                                Custom_Text(text: posts['name'],
                                  fontSize: 16,
                                  color:ColorsManager.primary2,
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
                                Custom_Text(text: "${posts['price']} $currency",
                                  fontSize: 17,
                                  alignment: Alignment.center,
                                  fontWeight: FontWeight.bold,
                                  color:ColorsManager.primary2,
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