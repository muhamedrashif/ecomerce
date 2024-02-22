import 'dart:developer';

import 'package:ecomerce/screens/detailscreen/detailscreen.dart';
import 'package:ecomerce/websirvice/webservice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

// ignore: must_be_immutable
class Category_productspage extends StatefulWidget {
  String catname;
  int catid;
  Category_productspage({required this.catid, required this.catname});

  @override
  State<Category_productspage> createState() => _Category_productspageState();
}

class _Category_productspageState extends State<Category_productspage> {
  @override
  Widget build(BuildContext context) {
    log("catname = " + widget.catname.toString());
    log("catid  = " + widget.catid.toString());
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
        title: Text(
          widget.catname,
          //"Category name",
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
      ),
      body: FutureBuilder(
          future: Webservice().fetchCatProducts(widget.catid),
          builder: (context, snapshot) {
            //log("length =="+ snapshot.data!.length.tostring());
            if (snapshot.hasData) {
              return MasonryGridView.builder(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    final procduct = snapshot.data![index];
                    return InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: ((context) {
                            return DetailsPage(
                              id: procduct.id,
                              name: procduct.productname,
                              image: Webservice().imageurl + procduct.image,
                              price: procduct.price.toString(),
                              description: procduct.description,
                            );
                          })));
                        },
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Column(children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15),
                                    ),
                                    child: Container(
                                      constraints: const BoxConstraints(
                                          minHeight: 100, maxHeight: 250),
                                      child: Image(
                                          image: NetworkImage(
                                        Webservice().imageurl + procduct.image,
                                        // "   "
                                      )),
                                    ),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(children: [
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            procduct.productname,
                                            // "shoes",
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: Colors.grey.shade600,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  'Rs. ',
                                                  style: TextStyle(
                                                      color:
                                                          Colors.red.shade900,
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                SizedBox(
                                                  width: 2,
                                                ),
                                                Text(
                                                  procduct.price.toString(),
                                                  style: TextStyle(
                                                      color:
                                                          Colors.red.shade900,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                )
                                              ],
                                            )
                                          ],
                                        )
                                      ]))
                                ]))));
                  });
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
