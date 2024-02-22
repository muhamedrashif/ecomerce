import 'dart:convert';
import 'dart:developer';
import 'package:ecomerce/constrants.dart';
import 'package:ecomerce/model/getuser.dart';
import 'package:ecomerce/provider/cartprovider.dart';
import 'package:ecomerce/screens/homescreen/homescreen.dart';
import 'package:ecomerce/screens/rezorpay/rezorpay.dart';
import 'package:ecomerce/websirvice/webservice.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CheckoutScreen extends StatefulWidget {
  final List<CartProduct> cart;
  const CheckoutScreen({required this.cart});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int selectedValue = 1;
  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  String? username;
  //Loading counter value on start
  void _loadUsername() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      username = prefs.getString('username');
    });
    log("isloggedin =" + username.toString());
  }

  //fuction+
  orderPlace(
    List<CartProduct> cart,
    String amount,
    String paymentmethod,
    String date,
    String name,
    String address,
    String phone,
  ) async {
    String jsondata = jsonEncode(cart);
    log('jsondata = ${jsondata}');

    final vm = Provider.of<Cart>(context, listen: false);
    //replaace above line using getbuilder
    final response =
        await http.post(Uri.parse(Webservice().mainurl + "order.php"), body: {
      "username": username,
      "amount": amount,
      " paymentmethod": paymentmethod,
      "date": date,
      "quantity": vm.count.toString(),
      "cart": jsondata,
      'name': name,
      " address": address,
      "phone": phone,
    });

    if (response.statusCode == 200) {
      log(response.body);
      if (response.body.contains("Success")) {
        vm.clearCart();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          duration: Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
          padding: EdgeInsets.all(15.0),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          content: Text(
            "YOUR ORDER SUCCESSFULLY COMPLETED",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ));
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const HomeScreen();
        }));
      }
    }
  }

  String? name, address, phone;
  String? paymentmethod = "Cash on delivery";
  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<Cart>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        // toolbarOpacity: 60,
        elevation: 0,
        backgroundColor: Colors.grey.shade100,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "CheckOut",
          style: TextStyle(
            fontSize: 25,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder<Getuser>(
                  future: Webservice().fetchUser(username.toString()),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      name = snapshot.data!.name;
                      phone = snapshot.data!.phone;
                      address = snapshot.data!.address;

                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const Text("Name : ",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold)),
                                  Text(name.toString())
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  const Text("Phone : ",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold)),
                                  Text(phone.toString())
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  const Text("Address : ",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          1.5, //address overflow avoid

                                      child: Text(
                                        address.toString(),
                                        maxLines: 4,
                                        overflow: TextOverflow.ellipsis,
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    return const CircularProgressIndicator();
                  }),
            ),
            const SizedBox(
              height: 10,
            ),
            RadioListTile(
              activeColor: maincolor,
              value: 1,
              groupValue: selectedValue,
              onChanged: (int? value) {
                setState(() {
                  selectedValue = value!;
                  paymentmethod = 'Cash on delivery';
                });
              },
              title: const Text(
                'Cash On Delivery',
                style: TextStyle(fontFamily: "muli"),
              ),
              subtitle: const Text(
                'Pay Cash At Home',
                style: TextStyle(fontFamily: "muli"),
              ),
            ),
            RadioListTile(
              activeColor: maincolor,
              value: 2,
              groupValue: selectedValue,
              onChanged: (int? value) {
                setState(() {
                  selectedValue = value!;
                  paymentmethod = 'Online';
                });
              },
              title: const Text(
                'Pay Now',
                style: TextStyle(fontFamily: "muli"),
              ),
              subtitle: const Text(
                'Online Payment',
                style: TextStyle(fontFamily: "muli"),
              ),
            )
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(10),
        child: InkWell(
          onTap: () {
            String datetime = DateTime.now().toString();

            log(datetime.toString());

            if (paymentmethod == "Online") {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return Paymentscreen(
                      address: address.toString(),
                      amount: vm.totalPrice.toString(),
                      cart: widget.cart,
                      date: datetime.toString(),
                      name: name.toString(),
                      paymentmethod: paymentmethod.toString(),
                      phone: phone.toString());
                },
              ));
            } else if (paymentmethod == "Cash on delivery") {
              orderPlace(widget.cart, vm.totalPrice.toString(), paymentmethod!,
                  datetime, name!, address!, phone!);
            }
          },
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: maincolor),
            child: const Center(
              child: Text(
                "Checkout",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
