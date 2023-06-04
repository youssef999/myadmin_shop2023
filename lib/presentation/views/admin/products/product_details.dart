import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/data/local/local_data.dart';
import 'package:shop_app/domain/models/cart_model.dart';
import 'package:shop_app/presentation/bloc/cart/cart_cubit.dart';
import 'package:shop_app/presentation/bloc/cart/cart_states.dart';
import 'package:shop_app/presentation/const/app_message.dart';
import 'package:shop_app/presentation/resources/color_manager.dart';
import 'package:shop_app/presentation/views/Fav/fav_products_view.dart';
import 'package:shop_app/presentation/views/admin/admin_view.dart';
import 'package:shop_app/presentation/views/products/product_video_view.dart';
import 'package:shop_app/presentation/widgets/Custom_Text.dart';
import 'package:shop_app/presentation/widgets/Custom_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

import 'edit_product.dart';


class AdminProductDetails extends StatelessWidget {

  DocumentSnapshot posts;
  String tag;
  AdminProductDetails({Key? key,required this.posts,required this.tag}) : super(key: key);

  List data=[];


  @override
  Widget build(BuildContext context) {

    return  BlocProvider(
        create: (BuildContext context) => CartCubit(),
        child: BlocConsumer<CartCubit, CartStates>(
            listener: (context, state) {
              if(state is DeleteProductsSuccessState){
                appMessage(text: 'تم الحذف بنجاح');
                Get.offAll(const AdminView());
              }
            },
            builder: (context, state) {
              CartCubit cubit = CartCubit.get(context);
              return Scaffold(
                backgroundColor:Colors.grey[100],
                appBar: AppBar(
                  toolbarHeight: 2,
                  backgroundColor:ColorsManager.primary,
                ),
                body:SingleChildScrollView(
                  child: Column(
                    children:  [
                      // const SizedBox(height: 10,),
                      Hero(
                        tag: tag,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius:BorderRadius.circular(21),
                              color:Colors.grey[100]
                          ),
                          width: MediaQuery.of(context).size.width,
                          //height: 600,
                          child:Image.network(posts['image'][0],
                              fit:BoxFit.cover
                          ),
                        ),
                      ),

                      Container(
                        decoration: BoxDecoration(
                            borderRadius:BorderRadius.circular(22),
                            color:ColorsManager.primary2,
                            shape: BoxShape.rectangle
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: 20,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Custom_Text(text: posts['name'],
                                  color:ColorsManager.primary
                                  ,fontSize:26,alignment:Alignment.center,),

                                const SizedBox(width: 60,),

                                // ((cubit.data.contains(posts['productid'])==true && cubit.isFav2==false)
                                //     || (cubit.isFav ==true&& cubit.isFav2==false))?
                                //
                                // InkWell (child: const Icon(Icons.favorite
                                //   ,size:33
                                //   ,color:Colors.redAccent,),
                                //   onTap:() {
                                //
                                //     cubit.DeleteFromFav(posts: posts);
                                //
                                //   },
                                //
                                // ):  InkWell(child: const Icon(Icons.favorite_border,size:33,color:Colors.red,),
                                //   onTap:(){
                                //
                                //     cubit.addToFav(posts: posts);
                                //   },
                                // ),

                                const SizedBox(width: 60,),

                                (posts['video'].toString().length>3)?
                                InkWell(child:
                                const Icon(Icons.video_collection_rounded,size: 33,color:Colors.red,),

                                  onTap:(){
                                    Get.to(ProductVideoView(url:posts['video']
                                        , title: posts['name']));
                                  },
                                ):const SizedBox()
                              ],
                            ),
                            const SizedBox(height: 20,),
                            RatingBar.builder(
                              itemSize:17,
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
                            const SizedBox(height: 20,),
                            Container(
                              decoration:BoxDecoration(
                                  color:ColorsManager.primary2,
                                  borderRadius:BorderRadius.circular(31)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Custom_Text(text: posts['des'],fontSize:15,alignment:Alignment.center,
                                  color:ColorsManager.primary,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20,),
                            const Divider(
                              endIndent:0.8,
                              thickness: 0.7,
                            ),
                            const SizedBox(height: 10,),
                            Custom_Text(text:" ${posts['country']}   ",
                              color:Colors.red,
                              fontSize:22,alignment:Alignment.center,),
                            const SizedBox(height: 10,),
                            Custom_Text(text:" ${posts['price']}   ",
                              color:ColorsManager.primary,
                              fontSize:22,alignment:Alignment.center,),
                            const SizedBox(height: 22,),
                            CustomButton(text: 'تعديل ', onPressed:(){

                              Get.to(EditProduct(
                                posts: posts,
                              ));


                            }, color1: ColorsManager.primary, color2: ColorsManager.primary2),
                            const SizedBox(height: 22,),
                            CustomButton(text: ' حذف  ', onPressed:(){

                              cubit.DeleteDataInFireBase(
                                posts: posts
                              );
                            }, color1: ColorsManager.primary, color2: ColorsManager.primary2),
                            const SizedBox(height: 50,),
                          ],
                        ),
                      ),


                    ],
                  ),
                ),
              );
            }));

  }
}








