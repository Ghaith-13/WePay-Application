import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:wepay/model/Pay.dart';
import 'package:wepay/model/Payment.dart';
import 'package:wepay/model/Payment.dart';
import 'package:wepay/model/Payment.dart';

class LastPay extends StatefulWidget {
  const LastPay({super.key});

  @override
  State<LastPay> createState() => _LastPayState();
}

class _LastPayState extends State<LastPay> {
  static List<Pay> main_List = [
    Pay("شحن", "رصيد الحساب", "300000", DateTime.now()),
    Pay("شحن", "رصيد الحساب", "300000", DateTime.now()),
    Pay("شحن", "رصيد الحساب", "300000", DateTime.now()),
    Pay("شحن", "رصيد الحساب", "300000", DateTime.now()),
    Pay("شحن", "رصيد الحساب", "300000", DateTime.now()),
    Pay("شحن", "رصيد الحساب", "300000", DateTime.now()),
    Pay("شحن", "رصيد الحساب", "300000", DateTime.now()),
    Pay("شحن", "رصيد الحساب", "300000", DateTime.now()),
    // Pay("شحن", "رصيد الحساب", "300000", DateTime.now()),
  ];
  int i = 0;
  @override
  Widget build(BuildContext context) {
    var model = Provider.of<depositandwithdraw>(context);
    if (i == 0) {
      model.getShipping(context);
      
      i++;
    }
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // SizedBox(height:10.h),
          Text(
            ": آخر عمليات الدفع والتحويل",
            textAlign: TextAlign.start,
            style:
                TextStyle(fontSize: width * 0.05, fontWeight: FontWeight.bold),
          ),
          SizedBox(width: width * 0.05),
        ],
      ),
      SingleChildScrollView(
        child: model.isFull2 == false
            ? Center(child: CircularProgressIndicator()) 
             : model.actions == null
            ? Center(
                child: Lottie.asset('./assets/one.json'),
              )
            : Container(
                height: height * 0.4,
                child: Padding(
                  padding: EdgeInsets.only(bottom: height * 0.019),
                  child: ListView.builder(

                      // margin:EdgeInsets.all(0.0),
                      shrinkWrap: true,
                      itemCount: model.actions.length,
                      //  physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        if (index % 2 == 0) {
                          return Column(
                            children: [
                              SizedBox(
                                height: height * 0.01,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: height * 0.01,
                                    horizontal: width * 0.04),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      width * 0.03), // set the radius here
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromARGB(255, 0, 0, 0)
                                          .withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: Offset(0, 3),
                                    ),
                                  ], // set the shadow here
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Color.fromARGB(255, 255, 255, 255),
                                      Color.fromARGB(255, 145, 145, 145),
                                    ], // set the gradient colors here
                                  ),
                                ),
                                width: width * 0.9,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "التاريخ والوقت",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: width * 0.04),
                                        ),
                                        Text(
                                          '${DateFormat('EEE,MMM dd,yyy_ hh:mm a').format(DateTime.parse(model.actions[index]['createdAt']))}',
                                          style:
                                              TextStyle(fontSize: width * 0.03),
                                        ),
                                        SizedBox(height: height * 0.02),
                                        Text(
                                          "حالة النشاط",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: width * 0.04),
                                        ),
                                        model.actions[index]["status"] == true
                                            ? Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                    Text("تمت معالجته"),
                                                    SizedBox(
                                                        width: width * 0.01),
                                                    Icon(Icons.check_circle,
                                                        color: Colors.green),
                                                    SizedBox(
                                                        width: width * 0.01),
                                                  ])
                                            : Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text("قيد المعالجة"),
                                                  SizedBox(width: width * 0.01),
                                                  Icon(Icons.hourglass_bottom,
                                                      color: Colors.black),
                                                  SizedBox(width: width * 0.01),
                                                ],
                                              ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "نوع النشاط  ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: width * 0.04),
                                        ),
                                        Text(
                                            '${model.actions[index]['senderAction']}'),
                                        Container(
                                          width: width * 0.3,
                                          alignment: Alignment.center,
                                          child: Text(
                                            '${model.actions[index]['senderDetails']}',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: width * 0.028),
                                          ),
                                        ),
                                        SizedBox(height: height * 0.01),
                                        Text(
                                          ":قيمة التحويل  ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: width * 0.04),
                                        ),
                                        Text(
                                            '${model.actions[index]['amountValue']}' +
                                                " " +
                                                "SYP"),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: height * 0.01,
                              )
                            ],
                          );
                        } else {
                          return Column(
                            children: [
                              SizedBox(
                                height: height * 0.01,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: height * 0.01,
                                    horizontal: width * 0.04),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      width * 0.03), // set the radius here
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromARGB(255, 0, 0, 0)
                                          .withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: Offset(0, 3),
                                    ),
                                  ], // set the shadow here
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Color.fromARGB(250, 58, 165, 117),
                                      Color.fromARGB(255, 30, 84, 59),
                                    ], // set the gradient colors here
                                  ),
                                ),
                                width: width * 0.9,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "التاريخ والوقت",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: width * 0.04),
                                        ),
                                        Text(
                                          '${DateFormat('EEE,MMM dd,yyy_ hh:mm a').format(DateTime.parse(model.actions[index]['createdAt']))}',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: width * 0.03),
                                        ),
                                        SizedBox(height: height * 0.02),
                                        Text(
                                          "حالة النشاط",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: width * 0.04),
                                        ),
                                        model.actions[index]["status"] == true
                                            ? Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                    Text("تمت معالجته",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white)),
                                                    SizedBox(
                                                        width: width * 0.01),
                                                    Icon(Icons.check_circle,
                                                        color: Colors.green),
                                                    SizedBox(
                                                        width: width * 0.01),
                                                  ])
                                            : Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text("قيد المعالجة",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  SizedBox(width: width * 0.01),
                                                  Icon(Icons.hourglass_bottom,
                                                      color: Colors.white),
                                                  SizedBox(width: width * 0.01),
                                                ],
                                              ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "نوع النشاط  ",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: width * 0.04),
                                        ),
                                        Text(
                                          '${model.actions[index]['senderAction']}',
                                          style: TextStyle(color: Colors.white),
                                        ),

                                        Container(
                                          width: width * 0.3,
                                          alignment: Alignment.center,
                                          child: Text(
                                            '${model.actions[index]['senderDetails']}',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: width * 0.03),
                                          ),
                                        ),
                                        SizedBox(height: height * 0.01),
                                        Text(
                                          ":قيمة التحويل ",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: width * 0.04),
                                        ),
                                        //amountValue
                                        Text(
                                          '${model.actions[index]['amountValue']}' +
                                              " " +
                                              "SYP",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: height * 0.01,
                              )
                            ],
                          );
                        }
                      }),
                ),
              ),
      ),
    ]);
  }
}
