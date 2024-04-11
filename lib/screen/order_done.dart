import 'dart:developer';

import 'package:e_com/helper/datahelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class OrderDone extends StatefulWidget {
  const OrderDone({super.key});

  @override
  State<OrderDone> createState() => _OrderDoneState();
}

class _OrderDoneState extends State<OrderDone> {
  var arg = Get.arguments;
  var promo;
  var data;

  getdata() async {
    data = await DataHelper.dataHelper.getpromocode();
    promo = data.docs.toList();
    log(promo[0]['code'].toString());
  }

  TextEditingController promocode = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
    log(arg.toString());
  }

  GlobalKey<FormState> key2 = GlobalKey<FormState>();
  int? proindex;

  // int? price;

  @override
  Widget build(BuildContext context) {
    log(arg['data']['image'].toString());
    final s = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                  height: s.height * 0.15,
                  width: s.width * 0.28,
                  child: Image.network(
                    arg['data']['image'],
                  ),
                ),
                SizedBox(
                  width: s.width * 0.05,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        width: s.width * 0.6,
                        child: Text(
                          '${arg['data']['name']}',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 18),
                        )),
                    Container(
                        width: s.width * 0.6,
                        child: Text(
                          'Price : ${arg['price']}',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        )),
                    Container(
                        width: s.width * 0.6,
                        child: Text(
                          'Qty : ${arg['qty']}',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        )),
                  ],
                )
              ],
            ),
          ),
          Divider(),
          // SizedBox()
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Add Promo Code : ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Form(
                  key: key2,
                  child: Container(
                    width: s.width * 0.6,
                    child: TextFormField(
                      controller: promocode,
                      validator: (value) {
                        if (proindex == -1) {
                          return 'no promo code found';
                        }
                      },
                      decoration: InputDecoration(labelText: 'Promocode'),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (proindex != -1 && proindex != null) {
                      promocode.clear();
                      proindex = -1;
                    } else {
                      proindex = promo
                          .indexWhere((item) => item['code'] == promocode.text);
                      key2.currentState!.validate();
                      if (promo[proindex]['qty'] == 0) {
                        Get.snackbar(
                            'Sorry!', 'This promocode is not usable now',
                            backgroundColor: Colors.red,
                            colorText: Colors.white);
                        promocode.clear();
                        proindex = -1;
                      }
                    }
                    setState(() {});
                  },
                  child: Container(
                      width: s.width * 0.25,
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Color(0xFF393185)),
                      child: Text(
                        proindex != -1 && proindex != null ? 'Remove' : 'Add',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      )),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomSheet: InkWell(
        onTap: () {
          log('message');
          DataHelper.dataHelper.updproduct(
              id: arg['id'], count: arg['data']['count'] - arg['qty']);
          if (proindex != -1 && proindex != null) {
            DataHelper.dataHelper.updpromo(
                id: data.docs[proindex].reference.id,
                count: promo[proindex]['qty'] - 1);
            Get.offAllNamed('/home');
            Get.snackbar("success", 'your order please successful',
                backgroundColor: Colors.green, colorText: Colors.white);
          } else {
            Get.offAllNamed('/home');
          }
        },
        child: Container(
          width: double.maxFinite,
          height: s.height * 0.08,
          // padding: EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Color(0xFF393185),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20), topLeft: Radius.circular(20))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "${proindex != -1 && proindex != null ? arg['price'] * promo[proindex]['dis'] / 100 : arg['price']} Buy Now",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
