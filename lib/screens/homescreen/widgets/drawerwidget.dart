import 'package:ecomerce/constrants.dart';
import 'package:ecomerce/login/login.dart';
import 'package:ecomerce/provider/cartprovider.dart';
import 'package:ecomerce/screens/cartscreen/cartscreen.dart';
import 'package:ecomerce/screens/homescreen/homescreen.dart';
import 'package:ecomerce/screens/oderdetails_screen/oderdetails_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:badges/badges.dart' as badges;

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
          child: ListView(
        padding: EdgeInsets.zero,
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(
            height: 50,
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              "E-COMMERCE",
              style: TextStyle(
                  color: maincolor, fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Divider(),
          const SizedBox(
            height: 10,
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text(
              "Home",
              style: TextStyle(fontSize: 15),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 15,
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return const HomeScreen();
                },
              ));
            },
          ),
          ListTile(
            leading: badges.Badge(
              showBadge: context.read<Cart>().getitems.isEmpty
                  ? false
                  : true, // cart inside data illankil false akaam condition
              badgeStyle: const badges.BadgeStyle(
                badgeColor: Colors.red,
              ),

              badgeContent: Text(
                context.watch<Cart>().getitems.length.toString(),
                style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
              child: const badges.Badge(
                child: Icon(
                  Icons.shopping_cart,
                  color: Colors.grey,
                ),
              ),
            ),
            title: const Text('Cart Page', style: TextStyle(fontSize: 15.0)),
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 15,
            ),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => CartPage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.book_online),
            title: const Text(
              "Order Details",
              style: TextStyle(fontSize: 15),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 15,
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return const OrderdetailsPage();
                },
              ));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.power_settings_new_rounded,
              color: Colors.red,
            ),
            title: const Text(
              'Logout',
              style: TextStyle(
                fontSize: 15.0,
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 15,
            ),
            onTap: () async {
              final prefs = await SharedPreferences.getInstance();
              prefs.setBool("isLoggedIn", false);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()));
            },
          ),
        ],
      )),
    );
  }
}
