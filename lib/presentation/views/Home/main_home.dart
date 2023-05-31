



import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/presentation/views/Home/home_view.dart';
import 'package:shop_app/presentation/views/cart/cart_view.dart';
import '../../resources/color_manager.dart';
import '../Fav/fav_products_view.dart';
import '../profile/user_profile.dart';


class MainHome extends StatelessWidget {
  const MainHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {




    List<Widget> fragmentScreens = [
      const HomeView(),
      const CartView(),
      const FavProductsView(),
      const UserProfileView(),

    ];

    List _navigationButtonProperties = [
      {
        "active_icon": (Icons.home),
        "non_active_icon": (Icons.home_outlined),
        "label": "الرئيسية "
      },
      {
        "active_icon": (Icons.shopping_cart),
        "non_active_icon": (Icons.add_shopping_cart_outlined),
        "label": "السلة"
      },
      {
        "active_icon": (Icons.favorite),
        "non_active_icon": (Icons.favorite_border),
        "label": "المفضلة"
      },
      {
        "active_icon": (Icons.person),
        "non_active_icon": (Icons.person_outline),
        "label": "صفحتي "
      },

    ];

    RxInt indexNumber = 0.obs;
    return Scaffold(
      //backgroundColor: ColorsManager.white,
        appBar: AppBar(
          toolbarHeight: 1,
          backgroundColor: ColorsManager.primary,
        ),
        body: SafeArea(child: Obx(() => fragmentScreens[indexNumber.value])),
        bottomNavigationBar: Obx(() => Container(
          //  color:Colors.grey[200],
          padding: const EdgeInsets.all(10.0),
          child: BottomNavigationBar(
            currentIndex: indexNumber.value,
            onTap: (value) {
              indexNumber.value = value;
            },
            showSelectedLabels: true,
            backgroundColor: ColorsManager.primary2,
            showUnselectedLabels: true,
            selectedItemColor: ColorsManager.primary,
            unselectedItemColor: Colors.grey,
            items: List.generate(4, (index) {
              var BtnProp = _navigationButtonProperties[index];
              return BottomNavigationBarItem(
                  backgroundColor: ColorsManager.primary2,
                  icon: Icon(BtnProp["non_active_icon"]),
                  activeIcon: Icon(BtnProp["active_icon"]),
                  label: BtnProp["label"]);
            }),
          ),
        )));
  }
}
