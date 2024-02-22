import 'package:ecomerce/constrants.dart';
import 'package:ecomerce/screens/categoty_products/categoty_products.dart';
import 'package:ecomerce/screens/detailscreen/detailscreen.dart';
import 'package:ecomerce/websirvice/webservice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'widgets/drawerwidget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        toolbarHeight: 60,
        elevation: 0,
        centerTitle: true,
        backgroundColor: maincolor,
        title: Text(
          "E-COMMERCE",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      drawer: DrawerWidget(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Cartegory",
                  style: TextStyle(
                      fontSize: 20,
                      color: maincolor,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            FutureBuilder(
                future: Webservice().fetchCategory(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      height: 80,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.all(8),
                            child: InkWell(
                              onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                          builder: (context) {
                                            
                                            return Category_productspage(
                                              catid: snapshot.data![index].id,
                                             
                                               catname: snapshot.data![index].category
                                        );
                                          },
                                        ));
                              },
                              child: Container(
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color.fromARGB(37, 5, 2, 39)),
                                child: Center(
                                  child: Text(
                                    snapshot.data![index].category,
                                    style: TextStyle(
                                        color: maincolor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
            SizedBox(
              height: 20,
            ),
            Text(
              "Offer products",
              style: TextStyle(
                  fontSize: 18, color: maincolor, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),

            //view products
            Expanded(
                child: FutureBuilder(
                    future: Webservice().fetchproducts(),
                    builder: (context, snapshot) {
                      //log
                      if (snapshot.hasData) {
                        return Container(
                          child: MasonryGridView.builder(
                            gridDelegate:
                                SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2),
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              final procduct = snapshot.data![index];
                              return InkWell(
                                onTap: () {
                                    Navigator.push(context,MaterialPageRoute(builder: ((context){
                                               return DetailsPage(
                                                id: procduct.id, 
                                               name: procduct.productname,
                                                price:procduct.price.toString() , 
                                                image: Webservice().imageurl+ procduct.image,
                                                 description:procduct.description );
                                            
          
                                             })));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Column(
                                      children: [
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
                                              // "https://ludic.life/cdn/shop/files/nova-greenpdp2_8ddb40ba-07f6-41f4-9e9e-e5a1f6980386.jpg?v=1697718006&width=1100"
                                              Webservice().imageurl +
                                                  procduct.image,
                                            )),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                 procduct. productname,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color:
                                                          Colors.grey.shade600,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'Rs. '+procduct.price.toString(),
                                                  style: TextStyle(
                                                      color:
                                                          Colors.red.shade900,
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }
                      return Center(child: CircularProgressIndicator());
                    }))
          ],
        ),
      ),
    );
  }
}
