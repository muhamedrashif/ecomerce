import 'package:ecomerce/constrants.dart';
import 'package:ecomerce/provider/cartprovider.dart';
import 'package:ecomerce/screens/checkout_screen/checkout_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CartPage extends StatelessWidget {
  List<CartProduct> cartlist = [];

  CartPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          backgroundColor: Colors.grey.shade100,
          elevation: 0,
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
            "Cart",
            style: TextStyle(
              fontSize: 25,
              color: Colors.black,
            ),
          ),
          //delete area has be show
          actions: [
             context.watch<Cart>().getitems.isEmpty
             ? const SizedBox()
             :
            IconButton(
                onPressed: () {
                   context.read<Cart>().clearCart();
                },
                icon: const Icon(
                  Icons.delete,
                  color: Color.fromARGB(255, 56, 55, 55),
                )),
          ],
        ),
        body:
            context.watch<Cart>().getitems.isEmpty
            ? Center(
              child: Text("Empty Cart"),
            )
            :
            Consumer<Cart>(builder: (context, cart, child) {
          cartlist = cart.getitems;
          return ListView.builder(
              itemCount: cart.count,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.8)),
                    child: SizedBox(
                        height: 100,
                        child: Row(children: [
                          SizedBox(
                            height: 80,
                            width: 100,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 9),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          // "https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcQ_nZPlPRPyaRTQ57oi4Nal0zvhUuCdq5bM1f84nMXxnCEz05mUV-DzGUf349qwTl4XlUYcF7bN78r8O8ZMhY3_a777FeU_SFAU2NjC3A2-3j5qdX1xZpeI&usqp=CAc",
                                          cart.getitems[index].imageUrl),
                                      fit: BoxFit.fill),
                                ),
                                //child:
                              ),
                            ),
                          ),
                          Flexible(
                              child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Wrap(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    //  "Product name",
                                    cartlist[index].name,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        // "2000",
                                        cartlist[index].price.toString(),
                                        style: TextStyle(
                                            color: Colors.red.shade900,
                                            fontSize: 17,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Container(
                                        height: 35,
                                        decoration: BoxDecoration(
                                            color: Colors.grey.shade200,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child:
                                            Row(
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  cart.getitems[index].qty == 1
                                                      ? cart.removeItem(
                                                          cart.getitems[index])
                                                      : cart.reduceByOne(
                                                          cart.getitems[index]);
                                                },
                                                icon: cartlist[index].qty == 1
                                                    ? Icon(
                                                        Icons.delete,
                                                        size: 18,
                                                      )
                                                    : Icon(
                                                        Icons.remove,
                                                        size: 18,
                                                      )),
                                            Text(
                                              cartlist[index].qty.toString(),
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.red.shade900,
                                              ),
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  cart.increment(
                                                      cart.getitems[index]);
                                                },
                                                icon: const Icon(
                                                  Icons.add,
                                                  size: 18,
                                                )),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ))
                        ])),
                  ),
                );
              });
        }),
        bottomSheet: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total :" + context.watch<Cart>().totalPrice.toString(),
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.red.shade900,
                  fontWeight: FontWeight.bold,
                ),
              ),
              InkWell(
                onTap: () {
                  context.read<Cart>().getitems.isEmpty
                      ? ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(
                          duration: Duration(seconds: 3),
                          behavior: SnackBarBehavior.floating,
                          padding: EdgeInsets.all(15.0),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          content: Text(
                            "Cart is Empty !!!",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ))

                      // log("cartlist --" +cartlist.toString());
                      : Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                          return CheckoutScreen(cart: cartlist);
                        }));
                },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width / 2.2,
                  decoration: BoxDecoration(
                      color: maincolor,
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: Text(
                      "Order Now",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
