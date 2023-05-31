import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../data/local/local_data.dart';
import '../../bloc/location/location_cubit.dart';
import '../../bloc/location/location_states.dart';
import '../../const/app_message.dart';
import '../../resources/color_manager.dart';
import '../../widgets/Custom_button.dart';

import 'package:get_storage/get_storage.dart';
import 'dart:collection';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/presentation/bloc/cart/cart_cubit.dart';
import 'package:shop_app/presentation/bloc/cart/cart_states.dart';
import 'package:shop_app/presentation/resources/color_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/presentation/views/location/map_view.dart';

import '../../../domain/models/cart_model.dart';
import '../../widgets/Custom_Text.dart';
import '../../widgets/Custom_button.dart';
import '../location/location_form_view.dart';
import '../location/prev_location.dart';

class CartView extends StatefulWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  var locationMessage = "";
  var position;

  // var l1 = 37.43296265331129;
  // var l2 = -122.08832357078792;
  String? country = '';
  String? city = '';
  String? address = '';
  GoogleMapController? newGooGleMapController;
  LatLng? latLng;
  double lat = 34.33;
  double long = 120.44;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => CartCubit()..getAllProduct(),
        child: BlocConsumer<CartCubit, CartStates>(
            listener: (context, state) {},
            builder: (context, state) {
              CartCubit cubit = CartCubit.get(context);

              return Scaffold(
                appBar: AppBar(
                  elevation: 0,
                  backgroundColor: ColorsManager.primary,
                  toolbarHeight: 1,
                ),
                backgroundColor: Colors.white,
                body: cubit.cartProductModel.isEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset("assets/images/cart2.png"),
                          const SizedBox(
                            height: 5,
                          ),
                          const Custom_Text(
                            text: 'السلة فارغة ',
                            fontSize: 35,
                            color: ColorsManager.primary,
                            alignment: Alignment.center,
                          )
                        ],
                      )
                    : Column(
                        children: [
                          Expanded(
                            child: ListView.separated(
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 12, right: 12, top: 25),
                                  child: SizedBox(
                                      height: 140,
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 140,
                                            child: Image.network(
                                                cubit.cartProductModel[index]
                                                    .image
                                                    .toString(),
                                                fit: BoxFit.fill),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 30),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  cubit.cartProductModel[index]
                                                      .name
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontSize: 24,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const SizedBox(
                                                  height: 6,
                                                ),
                                                Text(
                                                  "${cubit.cartProductModel[index].price} L.E",
                                                  style: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: ColorsManager
                                                          .primary),
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                Container(
                                                  width: 140,
                                                  color: Colors.grey.shade200,
                                                  height: 40,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      InkWell(
                                                          onTap: () {
                                                            cubit
                                                                .increaseQuantity(
                                                                    index);
                                                          },
                                                          child: const Icon(
                                                            Icons.add,
                                                            color: ColorsManager
                                                                .primary,
                                                          )),
                                                      const SizedBox(
                                                        width: 20,
                                                      ),
                                                      Custom_Text(
                                                        alignment:
                                                            Alignment.center,
                                                        text: cubit
                                                            .cartProductModel[
                                                                index]
                                                            .quantity
                                                            .toString(),
                                                        fontSize: 20,
                                                      ),
                                                      const SizedBox(
                                                        width: 20,
                                                      ),
                                                      Container(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  bottom: 20),
                                                          child: InkWell(
                                                              onTap: () {
                                                                cubit
                                                                    .decreaseQuantity(
                                                                        index);
                                                              },
                                                              child: const Icon(
                                                                Icons.minimize,
                                                                color:
                                                                    ColorsManager
                                                                        .primary,
                                                              ))),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      InkWell(
                                                          onTap: () {
                                                            cubit.DeleteProducts(
                                                                CartProductModel(
                                                                    name: cubit
                                                                        .cartProductModel[
                                                                            index]
                                                                        .name,
                                                                    image: cubit
                                                                        .cartProductModel[
                                                                            index]
                                                                        .image,
                                                                    price: cubit
                                                                        .cartProductModel[
                                                                            index]
                                                                        .price,
                                                                    quantity: cubit
                                                                        .cartProductModel[
                                                                            index]
                                                                        .quantity,
                                                                    productId: cubit
                                                                        .cartProductModel[
                                                                            index]
                                                                        .productId),
                                                                cubit
                                                                    .cartProductModel[
                                                                        index]
                                                                    .productId!);
                                                          },
                                                          child: const Icon(Icons
                                                              .delete_outline))
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      )),
                                );
                              },
                              itemCount: cubit.cartProductModel.length,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                height: 5,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 30, right: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    const Text(
                                      "الاجمالي ",
                                      style: TextStyle(
                                          fontSize: 22, color: Colors.grey),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Custom_Text(
                                      text: cubit.totalPrice.toString(),
                                      color: ColorsManager.primary,
                                      fontSize: 18,
                                    ),
                                  ],
                                ),
                                Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: SizedBox(
                                      height: 70,
                                      width: 120,
                                      child: CustomButton(
                                        text: "التالي",
                                        onPressed: () {
                                          final box = GetStorage();

                                          String adress =
                                              box.read('address') ?? 'x';

                                          if (adress != 'x') {
                                            Get.to(PrevLocationView(
                                              total:
                                                  cubit.totalPrice.toString(),
                                              order: cubit.cartProductModel,
                                            ));
                                          } else {
                                            print(
                                                "order==${cubit.cartProductModel}");
                                            currentLocation();
                                            getData();
                                            Future.delayed(
                                                    const Duration(seconds: 3))
                                                .then((value) {


                                              Get.to( LocationFormView(
                                                total: cubit.totalPrice.toString(),
                                                order: cubit.cartProductModel,
                                              ));
                                              // Get.to(MapLocationView(
                                              //   l1: lat,
                                              //   l2: long,
                                              //   total:
                                              //       cubit.totalPrice.toString(),
                                              //   order: cubit.cartProductModel,
                                              // ));
                                            });
                                          }
                                        },
                                        color1: ColorsManager.primary,
                                        color2: ColorsManager.primary2,
                                      ),
                                    ))
                              ],
                            ),
                          )
                        ],
                      ),
              );
            }));
  }

  void currentLocation() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    latLng = LatLng(position.latitude, position.longitude);
    var lastposition = await Geolocator.getLastKnownPosition();
    lat = position.latitude;
    long = position.longitude;
    print(lastposition);
    print("lll=$locationMessage");
    print(
      "ooo=${position.latitude}",
    );
    print(
      "yyy=${position.longitude}",
    );

    setState(() {
      locationMessage = "$position";
      lat = position.latitude;
      long = position.longitude;
    });
  }

  Future<void> getData() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      appMessage(text: 'Location service disapled');
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    print("HERE");
    Future.delayed(const Duration(seconds: 4)).then((value) async {
      try {
        // emit(GetLocationLoadingState());
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best,
        );

        List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude,
          position.longitude,
        );
        Placemark placemark = placemarks.first;
        // print(placemark);
        // print(position.longitude);
        setState(() {
          lat = position.latitude;
          long = position.longitude;
          // emit(GetLocationSuccessState());
          country = placemark.country!;
          city = placemark.locality!;
        });
        // print(position.latitude);

        address = placemark.street.toString();
        //   locatate = true;
        appMessage(text: 'تم تحديد موقعك بنجاح');
        // emit(GetLocationSuccessState());
      } catch (e) {
        print(e);
        appMessage(text: '$e');
      }
    });
  }
}
