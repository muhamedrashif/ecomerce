import 'package:ecomerce/websirvice/webservice.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer';

class OrderdetailsPage extends StatefulWidget {
  const OrderdetailsPage({super.key});

  @override
  State<OrderdetailsPage> createState() => _OrderdetailsPageState();
}

class _OrderdetailsPageState extends State<OrderdetailsPage> {
  String? username;
  void initState() {
    super.initState();
    _loadUsername();
  }

  void _loadUsername() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username');
    });
    log("isloggedin =" + username.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
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
          "Order Details",
          style: TextStyle(
            fontSize: 25,
            color: Colors.black,
          ),
        ),
      ),
      body: FutureBuilder(
          future: Webservice().fetchOrderDetails(username.toString()),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    log(snapshot.data!.length.toString());
                    final order_details = snapshot.data![index];

                    return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 0,
                          color: const Color.fromARGB(255, 214, 203, 203),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          child: ExpansionTile(
                            trailing: const Icon(Icons.arrow_drop_down),
                            textColor: Colors.black,
                            collapsedTextColor: Colors.black,
                            iconColor: Colors.red.shade900,
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                    DateFormat.yMMMEd()
                                        .format(order_details.date),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500)),
                                Text(order_details.paymentmethod.toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.green.shade900,
                                        fontWeight: FontWeight.w300)),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                    order_details.totalamount.toString() +
                                        " /-",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.red.shade900,
                                        fontWeight: FontWeight.w300)),
                              ],
                            ),
                            children: [
                              ListView.separated(
                                  shrinkWrap: true,
                                  itemCount: order_details.products.length,
                                  padding: const EdgeInsets.only(top: 25),
                                  physics: const NeverScrollableScrollPhysics(),
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return const SizedBox(
                                      height: 10,
                                    );
                                  },
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0)),
                                      child: SizedBox(
                                        height: 100,
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              height: 80,
                                              width: 100,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 9),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                20)),
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                            Webservice()
                                                                    .imageurl +
                                                                order_details
                                                                    .products[
                                                                        index]
                                                                    .image),
                                                        fit: BoxFit.fill),
                                                  ),
                                                  //child:
                                                ),
                                              ),
                                            ),
                                            Flexible(
                                                child: Padding(
                                              padding:
                                                  const EdgeInsets.all(6.0),
                                              child: Wrap(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      order_details
                                                          .products[index]
                                                          .productname,
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          color: Colors
                                                              .grey.shade600,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8, right: 8),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          order_details
                                                              .products[index]
                                                              .price
                                                              .toString(),
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .red.shade900,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                        Text(
                                                          order_details
                                                                  .products[
                                                                      index]
                                                                  .quantity
                                                                  .toString() +
                                                              " X",
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              color: Colors.grey
                                                                  .shade600,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ))
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            ],
                          ),
                        ));
                  });
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
