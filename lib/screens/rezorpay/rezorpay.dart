import 'dart:convert';
import 'dart:developer';
import 'package:ecomerce/provider/cartprovider.dart';
import 'package:ecomerce/screens/homescreen/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class Paymentscreen extends StatefulWidget {
  List<CartProduct> cart;
  String amount;
  String paymentmethod;
  String date;
  String name;
  String address;
  String phone;
  Paymentscreen({
    required this.address,
    required this.amount,
    required this.cart,
    required this.date,
    required this.name,
    required this.paymentmethod,
    required this.phone,
  });

  @override
  State<Paymentscreen> createState() => _PaymentscreenState();
}

class _PaymentscreenState extends State<Paymentscreen> {
  Razorpay? razorpay;
  TextEditingController textEditingController = new TextEditingController();
  @override
  void initState() {
    super.initState();
    _loadusername();
    razorpay = Razorpay();
    razorpay!.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlepaymentsuccess);
    razorpay!.on(Razorpay.EVENT_PAYMENT_ERROR, _handlepaymentsuccess);
    razorpay!.on(Razorpay.EVENT_EXTERNAL_WALLET, _handlepaymentsuccess);
    flutterpayment("abcd", 10);
  }

  @override
  void dispose() {
    super.dispose();
    razorpay!.clear();
  }

  String? username;
  void _loadusername() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username');
    });

    log("isloggedin=====" + username.toString());
  }

  orderplace(
    List<CartProduct> cart,
    String amount,
    String paymentmethod,
    String date,
    String name,
    String address,
    String phone,
  ) async {
    try {
      String jsondata = jsonEncode(cart);
      log('jsondata=${jsondata}');

      final vm = Provider.of<Cart>(context, listen: false);

      final response = await http.post(
          Uri.parse("http://bootcamp.cyralearnings.com/order.php"),
          body: {
            "username": username,
            "amount": amount,
            "paymentmethod": paymentmethod,
            "date": date,
            "quantity": vm.count.toString(),
            "cart": jsondata,
            "name": name,
            "address": address,
            "phone": phone,
          });
      if (response.statusCode == 200) {
        log("kkk" + response.body);
        if (response.body.contains("Success")) {
          vm.getitems.clear();
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            duration: Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
            padding: EdgeInsets.all(15.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            content: Text(
              'YOUR ORDER IS SUCCESSFULLY COMPLETED',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ));
          Navigator.push(context, MaterialPageRoute(builder: ((context) {
            return const HomeScreen();
          })));
        }
      }
    } catch (e) {
      log("======" + e.toString());
    }
  }

  void flutterpayment(String orderId, int t) {
    var options = {
      "key": "rzp_test_Gu8QQnacB9W3Uf",
      "amount": t * 100,
      'name': 'rashif',
      'currency': 'INR',
      'description': 'maligai',
      'external': {
        'wallets': ['paytm']
      },
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      "prefill": {"contact": 7356723212, "emai": "rashifrashi2019@gmail.com"},
    };
    try {
      razorpay!.open(options);
    } catch (e) {
      log('error:e');
    }
  }

  void _handlepaymentsuccess(PaymentSuccessResponse response) {
    response.orderId;

    successmethod(response.paymentId.toString());
  }

  void _handlepaymenterror(PaymentFailureResponse response) {
    log("error===" + response.message.toString());
  }

  void _handleexternalwallet(ExternalWalletResponse response) {
    log("wallet----");
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(),
    );
  }

  void successmethod(String paymentId) {
    orderplace(widget.cart, widget.amount.toString(), widget.paymentmethod,
        widget.date, widget.name, widget.address, widget.phone);
  }
}
