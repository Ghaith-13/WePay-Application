import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:wepay/model/Pay.dart';
import 'package:wepay/model/Payment.dart';
import 'package:wepay/model/Payment.dart';
import 'package:wepay/model/Payment.dart';

import '../../model/Payment.dart';
import '../../model/Payment.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  depositandwithdraw x = new depositandwithdraw();
  @override
  int i = 0;
  Widget build(BuildContext context) {
    var model = Provider.of<depositandwithdraw>(context);
    if (i == 0) {
      model.getShipping(context);
      i++;
    }
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => depositandwithdraw(),
          )
        ],
        child:model.getrole()!='admin'? Container(
          padding: EdgeInsets.all(width * 0.025),
          width: width * 0.9,
          margin: EdgeInsets.only(
            top: height * 0.02,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(width * 0.03)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: const Offset(
                  0.0,
                  5.0,
                ),
                blurRadius: 10.0,
                spreadRadius: 2.0,
              ), //BoxShadow
              BoxShadow(
                color: Colors.white,
                offset: const Offset(0.0, 0.0),
                blurRadius: 0.0,
                spreadRadius: 0.0,
              ), //BoxShadow
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(children: [
                    Text(
                      "إجمالي الدخل",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: width * 0.04),
                    ),
                    Text('${model.totalIncome}',
                        style: TextStyle(
                            color: Colors.black, fontSize: width * 0.03)),
                  ]),
                  VerticalDivider(
                    color: Color.fromARGB(255, 104, 101, 101),
                    // thickness: 1.sp,
                  ),
                  Column(children: [
                    Text("إجمالي الصرف",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: width * 0.04)),
                    Text('${model.totalPayment}',
                        style: TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 1),
                            fontSize: width * 0.03)),
                  ])
                ],
              ),
              Center(
                child: Column(children: [
                  Text("رصيد الحساب",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: width * 0.04)),
                  Text('${model.Balance}',
                      style: TextStyle(
                          color: Colors.black, fontSize: width * 0.03)),
                ]),
              ),
              Divider(
                color: Colors.black,
              ),
              SizedBox(height: height * 0.01),
              ElevatedButton(
                onPressed: () {
                  Provider.of<depositandwithdraw>(context, listen: false)
                      .onClick(1);
                  Provider.of<depositandwithdraw>(context, listen: false)
                      .onClick2(4);
                },
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.25, vertical: height * 0.019),
                    shape: RoundedRectangleBorder(
                      // color:Color.fromARGB(255, 82, 173, 117),

                      borderRadius: BorderRadius.circular(width * 0.3),
                    )),

                // color:Colors.white,

                child: Text(
                  "الدفع والتحويل",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(
                height: height * 0.008,
              ),
              ElevatedButton(
                onPressed: () async {
                  Provider.of<depositandwithdraw>(context, listen: false)
                      .onClick(3);
                  Provider.of<depositandwithdraw>(context, listen: false)
                      .onClick2(2);
                },
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.26, vertical: height * 0.019),
                    shape: RoundedRectangleBorder(
                      // color:Color.fromARGB(255, 82, 173, 117),

                      borderRadius: BorderRadius.circular(width * 0.3),
                    )),

                // color:Colors.white,

                child: Text(
                  "شحن الرصيد",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(
                height: height * 0.008,
              ),
              ElevatedButton(
                onPressed: () async {
                  Provider.of<depositandwithdraw>(context, listen: false)
                      .onClick(5);
                  Provider.of<depositandwithdraw>(context, listen: false)
                      .onClick2(3);
                },
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.26, vertical: height * 0.019),
                    shape: RoundedRectangleBorder(
                      // color:Color.fromARGB(255, 82, 173, 117),

                      borderRadius: BorderRadius.circular(width * 0.3),
                    )),

                // color:Colors.white,

                child: Text(
                  "سحب الرصيد",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ):Container(
          padding: EdgeInsets.all(width * 0.025),
          width: width * 0.9,
          margin: EdgeInsets.only(
            top: height * 0.02,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(width * 0.03)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: const Offset(
                  0.0,
                  5.0,
                ),
                blurRadius: 10.0,
                spreadRadius: 2.0,
              ), //BoxShadow
              BoxShadow(
                color: Colors.white,
                offset: const Offset(0.0, 0.0),
                blurRadius: 0.0,
                spreadRadius: 0.0,
              ), //BoxShadow
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(children: [
                    Text(
                      "إجمالي الدخل",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: width * 0.04),
                    ),
                    Text('${model.totalIncome}',
                        style: TextStyle(
                            color: Colors.black, fontSize: width * 0.03)),
                  ]),
                  VerticalDivider(
                    color: Color.fromARGB(255, 104, 101, 101),
                    // thickness: 1.sp,
                  ),
                  Column(children: [
                    Text("إجمالي الصرف",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: width * 0.04)),
                    Text('${model.totalPayment}',
                        style: TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 1),
                            fontSize: width * 0.03)),
                  ])
                ],
              ),
              Center(
                child: Column(children: [
                  Text("رصيد الحساب",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: width * 0.04)),
                  Text('${model.Balance}',
                      style: TextStyle(
                          color: Colors.black, fontSize: width * 0.03)),
                ]),
              ),
              Divider(
                color: Colors.black,
              ),
              SizedBox(height: height * 0.01),
              ElevatedButton(
                onPressed: () {
                  Provider.of<depositandwithdraw>(context, listen: false)
                      .onClick(1);
                  Provider.of<depositandwithdraw>(context, listen: false)
                      .onClick2(4);
                },
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.25, vertical: height * 0.019),
                    shape: RoundedRectangleBorder(
                      // color:Color.fromARGB(255, 82, 173, 117),

                      borderRadius: BorderRadius.circular(width * 0.3),
                    )),

                // color:Colors.white,

                child: Text(
                  "الدفع والتحويل",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(
                height: height * 0.008,
              ),
              ElevatedButton(
                onPressed: () async {
  Provider.of<depositandwithdraw>(context, listen: false)
                      .onClick(0);
                  Provider.of<depositandwithdraw>(context, listen: false)
                      .onClick2(5);
                },
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.26, vertical: height * 0.019),
                    shape: RoundedRectangleBorder(
                      // color:Color.fromARGB(255, 82, 173, 117),

                      borderRadius: BorderRadius.circular(width * 0.3),
                    )),

                // color:Colors.white,

                child: Text(
                  "طلبات الشحن",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(
                height: height * 0.008,
              ),
              ElevatedButton(
                onPressed: () async {
                 Provider.of<depositandwithdraw>(context, listen: false)
                      .onClick(0);
                  Provider.of<depositandwithdraw>(context, listen: false)
                      .onClick2(6);
                },
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.26, vertical: height * 0.019),
                    shape: RoundedRectangleBorder(
                      // color:Color.fromARGB(255, 82, 173, 117),

                      borderRadius: BorderRadius.circular(width * 0.3),
                    )),

                // color:Colors.white,

                child: Text(
                  "طلبات السحب",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ));
  }
}
