// import 'dart:collection';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:shop_app/domain/models/cart_model.dart';
// import 'package:shop_app/presentation/views/location/location_form_view.dart';
// import '../../bloc/location/location_cubit.dart';
// import '../../bloc/location/location_states.dart';
// import '../../const/app_message.dart';
// import '../../resources/color_manager.dart';
// import '../../widgets/Custom_button.dart';
//
//  class MapLocationView extends StatefulWidget {
//
//
//  double  l1, l2;
//  List <CartProductModel> order;
//  String total;
//   //
//    MapLocationView({required this.l1, required this.l2,required this.order,required this.total});
//
//   @override
//   _Map1State createState() => _Map1State();
// }
//
//
// class _Map1State extends State<MapLocationView> {
//
//    var locationMessage = "";
//   var position;
//   // var l1 = 37.43296265331129;
//   // var l2 = -122.08832357078792;
//   String? country='';
//   String? city='';
//   String? address='';
//   GoogleMapController ? newGooGleMapController;
//   LatLng ?latLng;
//   CameraPosition ?cameraPosition;
//   CameraPosition initCameraPosition() => CameraPosition(target: LatLng(widget.l1,widget.l2), zoom: 6);
//
//   @override
//   void initState() {
//     super.initState();
//     // currentLocation();
//     // getData();
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     var markers = HashSet<Marker>();
//     return BlocProvider(
//         create: (BuildContext context) => LocationCubit(),
//         child: BlocConsumer<LocationCubit, LocationStates>(
//             listener: (context, state) async {
//
//             },
//             builder: (context, state) {
//               LocationCubit authCubit = LocationCubit.get(context);
//               return Scaffold(
//                 appBar: AppBar(
//                   toolbarHeight: 1,
//                   backgroundColor: ColorsManager.primary,
//                   automaticallyImplyLeading: false,
//                 ),
//                 body: Column(
//                   children: [
//                     const SizedBox(
//                       height: 12,
//                     ),
//                     SizedBox(
//                       height: 530,
//                       child: GoogleMap(
//                         initialCameraPosition: CameraPosition(
//                             target: LatLng(widget.l1, widget.l2),
//                             zoom: 19.151926040649414),
//                         onMapCreated: (
//                             GoogleMapController googleMapController) {
//                           setState(() {
//                             markers.add(Marker(
//                                 markerId: const MarkerId('1'),
//                                 visible: true,
//                                 draggable: true,
//                                 position: LatLng(widget.l1,widget.l2),
//                                 infoWindow:
//                                 const InfoWindow(title: 'Shop', snippet: 'ssss'),
//                                 onTap: () {
//                                   print("marker");
//                                 },
//                                 onDragEnd: (LatLng) {
//                                   print(LatLng);
//                                 }));
//                           });
//                         },
//                         markers: markers,
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 50,
//                     ),
//                     CustomButton(text: 'تاكيد', onPressed: () {
//                       print(country);
//                       print(city);
//                       print(address);
//                       final box = GetStorage();
//                       box.write('l1', widget.l1);
//                       box.write('l2',widget. l2);
//                       Get.to( LocationFormView(
//                         total: widget.total,
//                         order: widget.order,
//                       ));
//                     }, color1: ColorsManager.primary, color2: Colors.white),
//
//                     CustomButton(text: ' تخطي ', onPressed: () {
//
//                       final box = GetStorage();
//
//                       box.write('l1', 0.0);
//
//                       box.write('l2',0.0);
//
//                       Get.to( LocationFormView(
//                         total: widget.total,
//                         order: widget.order,
//                       ));
//
//                     }, color1: ColorsManager.primary, color2: Colors.white),
//                     const SizedBox(
//                       height: 25,
//                     ),
//
//                   ],
//                 ),
//               );
//             }));
//   }
//
//
//   void currentLocation() async {
//     position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//     latLng = LatLng(position.latitude, position.longitude);
//     cameraPosition = CameraPosition(target: latLng!, zoom: 14);
//     var lastposition = await Geolocator.getLastKnownPosition();
//     widget.l1 = position.latitude;
//     widget.l2 = position.longitude;
//     print(lastposition);
//     print("lll=$locationMessage");
//     print(
//       "ooo=${position.latitude}",
//     );
//     print(
//       "yyy=${position.longitude}",
//     );
//
//     setState(() {
//       locationMessage = "$position";
//      widget. l1 = position.latitude;
//       widget.l2 = position.longitude;
//     });
//   }
//
//   Future<void> getData() async {
//
//
//     bool serviceEnabled=await Geolocator.isLocationServiceEnabled();
//     if(!serviceEnabled){
//       appMessage(text: 'Location service disapled');
//     }
//     LocationPermission permission=await Geolocator.checkPermission();
//     if(permission==LocationPermission.denied){
//       permission=await Geolocator.requestPermission();
//     }
//
//
//     print("HERE");
//     Future.delayed(Duration(seconds: 4)).then((value) async {
//       try {
//         // emit(GetLocationLoadingState());
//         Position position = await Geolocator.getCurrentPosition(
//           desiredAccuracy: LocationAccuracy.best,
//         );
//
//         List<Placemark> placemarks = await placemarkFromCoordinates(
//           position.latitude,
//           position.longitude,
//         );
//         Placemark placemark = placemarks.first;
//         // print(placemark);
//         // print(position.longitude);
//         setState(() {
//         widget.  l1 = position.latitude;
//          widget. l2 = position.longitude;
//           // emit(GetLocationSuccessState());
//           country = placemark.country!;
//           city = placemark.locality!;
//         });
//         // print(position.latitude);
//
//
//         address = placemark.street.toString();
//      //   locatate = true;
//         appMessage(text: 'تم تحديد موقعك بنجاح');
//        // emit(GetLocationSuccessState());
//       } catch (e) {
//         print(e);
//         appMessage(text: '$e');
//       }
//     });
//
//   }
// }
//
