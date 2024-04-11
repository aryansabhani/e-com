import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:skeletonizer/skeletonizer.dart';

import '../helper/datahelper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // getdata() async {
  //   log('message');
  //   String api = 'https://fakestoreapi.com/products';
  //   var res = await http.get(Uri.parse(api));
  //   log(res.statusCode.toString());
  //   List body = jsonDecode(res.body);
  //   log(body.toString());
  //   for (int i = 0; i < body.length; i++) {
  //     await DataHelper.dataHelper.addTodo(
  //         id: body[i]['id'].toString(),
  //         name: body[i]['title'],
  //         price: double.parse(body[i]['price'].toString()),
  //         des: body[i]['description'],
  //         category: body[i]['category'],
  //         image: body[i]['image'],
  //         rating: body[i]['rating']['rate'].toString(),
  //         count: int.parse(body[i]['rating']['count'].toString()));
  //     log('${body[i]['id']}');
  //   }
  //   log("over loop");
  // }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getdata();
  }

  @override
  Widget build(BuildContext context) {
    final s = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Get.isDarkMode ? null :  Color(0xFF393185),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {
            Get.changeThemeMode(
              Get.isDarkMode ? ThemeMode.light : ThemeMode.dark,
            );
            setState(() {

            });}, icon: Icon(Get.isDarkMode ?Icons.sunny :Icons.dark_mode_outlined,color: Colors.white,))
        ],
        title: Text(
          'E-Commerce',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      // backgroundColor: !Get.isDarkMode ? Colors.grey.shade200 ,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: StreamBuilder<QuerySnapshot>(
            stream: DataHelper.dataHelper.getdata(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List product = snapshot.data?.docs.toList() as List;
                // tdata = todos;
                // log('${snapshot.data?.docs[index].reference.id}');

                return product.length == 0
                    ? Center(
                        child: Text(
                          "No Product Found",
                          style: TextStyle(
                              // color: Colors.black.withOpacity(0.6),
                              fontSize: 22),
                        ),
                      )
                    : GridView.builder(
                        itemCount: product.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 2.5 / 4),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Get.toNamed('/detail', arguments: {
                                'data': product[index],
                                'id': snapshot.data?.docs[index].reference.id
                              });
                            },
                            child: Container(
                              // height: s.height * 0.50,
                              decoration: BoxDecoration(
                                  // color: Colors.white,
                                  border: Border.all(color: Get.isDarkMode ? Colors.white :  Colors.black ),
                                  borderRadius: BorderRadius.circular(12)),
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(2),
                                    // color: Color(0xFF393185),
                                    child: Image.network(
                                      "${product[index]['image']}",
                                      height: s.height * 0.20,
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      '${product[index]['name']}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                      maxLines: 1,
                                      overflow: TextOverflow.clip,
                                    ),
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: [
                                        Text(
                                          'Price : ${product[index]['price']}',
                                          maxLines: 1,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500),
                                          overflow: TextOverflow.clip,
                                        ),
                                        Spacer(),
                                        Container(
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              // border: Border.all(),
                                              color: Color(0xFF393185)),
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.all(4),
                                          child: Icon(
                                            Icons.arrow_forward_ios_outlined,
                                            size: 16,
                                            color: Colors.white,
                                            // color: Colors.white,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Spacer(),

                                ],
                              ),
                            ),
                          );
                        },
                      );
              } else {
                return Center(
                  child: Skeletonizer(
                    effect: ShimmerEffect(),
                    child: GridView.builder(
                      itemCount: 6,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 3 / 4),
                      itemBuilder: (context, index) {
                        return Card(
                          child: Container(
                            // height: s.height * 0.50,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                // border: Border.all(color: Color(0xFF393185)),
                                borderRadius: BorderRadius.circular(12)),
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(2),
                                  // color: Color(0xFF393185),
                                  height: s.height * 0.20,
                                  // child: Image.network(
                                  //   "",
                                  //   fit: BoxFit.fitWidth,
                                  // ),
                                ),
                                SizedBox(
                                  height: s.height * 0.01,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'afgafgvb',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                    maxLines: 1,
                                    overflow: TextOverflow.clip,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    children: [
                                      Text(
                                        'Price : 205',
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500),
                                        overflow: TextOverflow.clip,
                                      ),
                                      Spacer(),
                                      Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            // border: Border.all(),
                                            color: Color(0xFF393185)),
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.all(4),
                                        child: Icon(
                                          Icons.arrow_forward_ios_outlined,
                                          size: 16,
                                          color: Colors.white,
                                          // color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              }
            }),
      ),
    );
  }
}
