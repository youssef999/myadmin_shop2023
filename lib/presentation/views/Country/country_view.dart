
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
 import 'package:flutter/material.dart';
import 'package:shop_app/data/local/local_data.dart';
import 'package:shop_app/presentation/resources/assets_manager.dart';
import 'package:shop_app/presentation/resources/color_manager.dart';

import 'package:get_storage/get_storage.dart';
import '../Home/main_home.dart';

class CountryView extends StatelessWidget {
  const CountryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.primary2,
      appBar:AppBar(
        backgroundColor:ColorsManager.primary,
        toolbarHeight: 2,
      ),
      body: //CountriesWidget()
      
      
      ListView(
        children: [
          const SizedBox(height: 30,),
          SizedBox(
            height: 230,
            child:Image.asset(AssetsManager.Logo),
          ),
          const SizedBox(height: 2,),
          CountriesWidget()
        ],
      )
    );
  }
}


Widget CountriesWidget(){



  return SizedBox(
    height: 700,
    child: StreamBuilder(
        stream:
        FirebaseFirestore.instance.collection('countries')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return  const Center(child: CircularProgressIndicator());
            default:
              return Expanded(
                child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot posts = snapshot.data!.docs[index];
                      if(snapshot.data == null) return const CircularProgressIndicator();
                      return
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            color: Colors.white,
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  child: ListTile(
                                    leading: Container(
                                      width: 60,
                                        child: Image.network(posts['img'])),
                                    title: Padding(
                                      padding: const EdgeInsets.only(right: 30.0),
                                      child: Text(posts['name']??" ",
                                          style:const TextStyle(color:Colors.black,fontSize:24,fontWeight:FontWeight.w300)),
                                    ),
                                    onTap:(){
                                      final box=GetStorage();

                                      // box.remove('country');
                                      // box.remove('currency');

                                      box.write('country', posts['name']);
                                      box.write('currency', posts['currency']);
                                      print(posts['name']);
                                      Get.to(const MainHome());
                                      },
                                  ),
                                ),
                                const SizedBox(height: 10,)


                              ],
                            ),

                          ),
                        );
                    }),
              );
          }
        }
    ),
  );
}