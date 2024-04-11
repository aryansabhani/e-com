import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  var arg = Get.arguments;
  int qty = 1;

  @override
  Widget build(BuildContext context) {
    final s = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF393185),
        centerTitle: true,
        title: Text(
          'E-Commerce',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      bottomSheet: Container(
        height: s.height * 0.1,
        width: double.maxFinite,
        color: Color(0xFF393185),
        padding: EdgeInsets.all(10),
        child: (arg['data']['count'] == 0)
            ? Center(
                child: Text(
                  "Out Of Stock",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              )
            : Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                ++qty;
                              });
                            },
                            child: Icon(
                              Icons.add,
                              size: 24,
                              color: Colors.green,
                            ),
                          ),
                          SizedBox(
                            width: s.width * 0.01,
                          ),
                          Text(
                            '${qty}',
                            style: TextStyle(color: Colors.white, fontSize: 22),
                          ),
                          SizedBox(
                            width: s.width * 0.01,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                if (qty != 1) {
                                  qty--;
                                }
                              });
                            },
                            child: Icon(
                              Icons.remove,
                              size: 24,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),

                      Container(
                        width: 150,
                        child: Text(
                          'Price : ${(arg['data']['price'] * qty)}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      // SizedBox(
                      //   width: s.width * 0.03,
                      // ),
                    ],
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      Get.toNamed('/orderDone',arguments: {
                        'price' : arg['data']['price'] * qty,
                        'data': arg['data'],
                        'id': arg['id'],
                        'qty': qty
                      });
                    },
                    child: Container(
                      height: s.height * 0.1,
                      width: s.width * 0.4,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12)),
                      alignment: Alignment.center,
                      child: Text(
                        "Buy Now",
                        style: TextStyle(
                            fontSize: 24,
                            color: Color(0xFF393185),
                            fontWeight: FontWeight.w500),
                      ),
                      // padding: EdgeInsets.symmetric(horizontal: 30, vertical: 18),
                      // color: Colors.white,
                    ),
                  )
                ],
              ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              height: s.height * 0.5,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    arg['data']['image'],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: s.height * 0.01,
            ),
            Divider(
              color: Color(0xFF393185),
              thickness: s.height * 0.005,
            ),
            SizedBox(
              height: s.height * 0.01,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Name : ",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                  ),
                  Text(
                    "${arg['data']['name']}",
                    style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16),
                  ),
                  Row(
                    children: [
                      Text(
                        "Rating : ",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 20),
                      ),
                      Text(
                        "${arg['data']['rating']}",
                        style: TextStyle(
                            fontWeight: FontWeight.w300, fontSize: 16),
                      ),
                    ],
                  ),
                  Text(
                    "Description : ",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                  ),
                  Text(
                    "${arg['data']['des']}",
                    style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16),
                  ),
                  SizedBox(
                    height: s.height * 0.15,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
