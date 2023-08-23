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
import 'dart:async';

class rechargeAdmin extends StatefulWidget {
  const rechargeAdmin({super.key});

  @override
  State<rechargeAdmin> createState() => _rechargeAdminState();
}

class _rechargeAdminState extends State<rechargeAdmin> {
  bool _showImage = false;

  void _toggleImage() {
    setState(() {
      _showImage = !_showImage;
    });
  }

  int i = 0;

  @override
  Widget build(BuildContext context) {
    var model = Provider.of<depositandwithdraw>(context);
    if (i == 0) {
      model.getAlldepositRequests(context);
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
            ":آخر طلبات الشحن ",
            textAlign: TextAlign.start,
            style:
                TextStyle(fontSize: width * 0.05, fontWeight: FontWeight.bold),
          ),
          SizedBox(width: width * 0.05),
        ],
      ),
      SingleChildScrollView(
        child: model.isFull == false
            ? Center(child: CircularProgressIndicator())
            : model.actions1 == null
                ? Center(
                    child: Lottie.asset('./assets/one.json'),
                  )
                : Container(
                    height: height * 0.5,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: height * 0.019),
                      child: ListView.builder(

                          // margin:EdgeInsets.all(0.0),
                          shrinkWrap: true,
                          itemCount: model.actions1.length,
                          //  physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            if (index % 2 == 0) {
                              return Column(children: [
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
                                    child: model.actions1[index]
                                                ['processType'] ==
                                            'شحن-بيمو'
                                        ? Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    children: [
                                                      Text(
                                                        "قيمة المبلغ المرسل",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize:
                                                                width * 0.043),
                                                      ),
                                                      Text(
                                                        '${model.actions1[index]['amountValue']}',
                                                        style: TextStyle(
                                                            fontSize:
                                                                width * 0.03),
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    children: [
                                                      Text(
                                                        "طريقة الشحن",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize:
                                                                width * 0.043),
                                                      ),
                                                      Text(
                                                        '${model.actions1[index]['processType']}',
                                                        style: TextStyle(
                                                            fontSize:
                                                                width * 0.03),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                "التاريخ والوقت",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: width * 0.043),
                                              ),
                                              Text(
                                                '${DateFormat('EEE,MMM dd,yyy_ hh:mm a').format(DateTime.parse(model.actions1[index]['createdAt']))}',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: width * 0.03),
                                              ),
                                              SizedBox(height: height * 0.02),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    children: [
                                                      Text(
                                                        " اسم المرسل",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize:
                                                                width * 0.043),
                                                      ),
                                                      Text(
                                                        '${model.actions1[index]['senderName']}',
                                                        style: TextStyle(
                                                            fontSize:
                                                                width * 0.03),
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    children: [
                                                      Text(
                                                        " رقم حساب بنك بيمو للمرسل  ",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize:
                                                                width * 0.04),
                                                      ),
                                                      Text(
                                                        '${model.actions1[index]['accountID']}',
                                                        style: TextStyle(
                                                            fontSize:
                                                                width * 0.03),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  foregroundColor: Colors.white,
                                                ),
                                                child:
                                                    const Text("معالجة الطلب"),
                                                onPressed: () async {
                                                  model.depositResponse(
                                                      context,
                                                      model.actions1[index]
                                                          ['_id']);
                                                  setState(() {});
                                                },
                                              ),
                                            ],
                                          )
                                        : model.actions1[index]
                                                    ['processType'] ==
                                                'شحن-كاش'
                                            ? Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Column(
                                                        children: [
                                                          Text(
                                                            "قيمة المبلغ المرسل",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize:
                                                                    width *
                                                                        0.043),
                                                          ),
                                                          Text(
                                                            '${model.actions1[index]['amountValue']}',
                                                            style: TextStyle(
                                                                fontSize:
                                                                    width *
                                                                        0.03),
                                                          ),
                                                        ],
                                                      ),
                                                      Column(
                                                        children: [
                                                          Text(
                                                            "طريقة الشحن",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize:
                                                                    width *
                                                                        0.043),
                                                          ),
                                                          Text(
                                                            '${model.actions1[index]['processType']}',
                                                            style: TextStyle(
                                                                fontSize:
                                                                    width *
                                                                        0.03),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Text(
                                                    "التاريخ والوقت",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize:
                                                            width * 0.043),
                                                  ),
                                                  Text(
                                                    '${DateFormat('EEE,MMM dd,yyy_ hh:mm a').format(DateTime.parse(model.actions1[index]['createdAt']))}',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: width * 0.03),
                                                  ),
                                                  SizedBox(
                                                      height: height * 0.02),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Column(
                                                        children: [
                                                          Text(
                                                            " رقم المرسل",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize:
                                                                    width *
                                                                        0.043),
                                                          ),
                                                          Text(
                                                            '${model.actions1[index]['senderPhone']}',
                                                            style: TextStyle(
                                                                fontSize:
                                                                    width *
                                                                        0.03),
                                                          ),
                                                        ],
                                                      ),
                                                      Column(
                                                        children: [
                                                          Text(
                                                            " رقم عملية التحويل  ",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize:
                                                                    width *
                                                                        0.04),
                                                          ),
                                                          Text(
                                                            '${model.actions1[index]['processNumber']}',
                                                            style: TextStyle(
                                                                fontSize:
                                                                    width *
                                                                        0.03),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                      height: height * 0.02),
                                                  ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      foregroundColor:
                                                          Colors.white,
                                                    ),
                                                    child: const Text(
                                                        "معالجة الطلب"),
                                                    onPressed: () {
                                                      model.depositResponse(
                                                          context,
                                                          model.actions1[index]
                                                              ['_id']);
                                                      // model.getAlldepositRequests(context);
                                                      print("jdhj");
                                                    },
                                                  ),
                                                ],
                                              )
                                            : Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Column(
                                                        children: [
                                                          Text(
                                                            "قيمة المبلغ المرسل",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize:
                                                                    width *
                                                                        0.043),
                                                          ),
                                                          Text(
                                                            '${model.actions1[index]['amountValue']}',
                                                            style: TextStyle(
                                                                fontSize:
                                                                    width *
                                                                        0.03),
                                                          ),
                                                        ],
                                                      ),
                                                      Column(
                                                        children: [
                                                          Text(
                                                            "طريقة الشحن",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize:
                                                                    width *
                                                                        0.043),
                                                          ),
                                                          Text(
                                                            '${model.actions1[index]['processType']}',
                                                            style: TextStyle(
                                                                fontSize:
                                                                    width *
                                                                        0.03),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Text(
                                                    "التاريخ والوقت",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize:
                                                            width * 0.043),
                                                  ),
                                                  Text(
                                                    '${DateFormat('EEE,MMM dd,yyy_ hh:mm a').format(DateTime.parse(model.actions1[index]['createdAt']))}',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: width * 0.03),
                                                  ),
                                                  SizedBox(
                                                      height: height * 0.01),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Column(
                                                        children: [
                                                          Text(
                                                            " اسم المرسل",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize:
                                                                    width *
                                                                        0.043),
                                                          ),
                                                          Text(
                                                            '${model.actions1[index]['senderName']}',
                                                            style: TextStyle(
                                                                fontSize:
                                                                    width *
                                                                        0.03),
                                                          ),
                                                        ],
                                                      ),
                                                      Column(
                                                        children: [
                                                          Text(
                                                            " رقم المرسل  ",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize:
                                                                    width *
                                                                        0.04),
                                                          ),
                                                          Text(
                                                            '${model.actions1[index]['senderPhone']}',
                                                            style: TextStyle(
                                                                fontSize:
                                                                    width *
                                                                        0.03),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                      height: height * 0.02),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Column(
                                                        children: [
                                                          Text(
                                                            " عنوان المرسل",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize:
                                                                    width *
                                                                        0.043),
                                                          ),
                                                          Text(
                                                            '${model.actions1[index]['senderCity']}',
                                                            style: TextStyle(
                                                                fontSize:
                                                                    width *
                                                                        0.03),
                                                          ),
                                                        ],
                                                      ),
                                                      Column(
                                                        children: [
                                                          Text(
                                                            " رقم عملية الإرسال  ",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize:
                                                                    width *
                                                                        0.04),
                                                          ),
                                                          Text(
                                                            '${model.actions1[index]['processNumber']}',
                                                            style: TextStyle(
                                                                fontSize:
                                                                    width *
                                                                        0.03),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                      height: height * 0.02),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          foregroundColor:
                                                              Colors.white,
                                                        ),
                                                        child: const Text(
                                                            "معالجة الطلب"),
                                                        onPressed: () {
                                                          model.depositResponse(
                                                              context,
                                                              model.actions1[
                                                                      index]
                                                                  ['_id']);
                                                        },
                                                      ),
                                                      ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          foregroundColor:
                                                              Colors.white,
                                                        ),
                                                        child: const Text(
                                                            " عرض الوصل"),
                                                        onPressed: () {
                                                          showDialog(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return Dialog(
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              16.0),
                                                                ),
                                                                child: Stack(
                                                                  alignment:
                                                                      Alignment
                                                                          .topRight,
                                                                  children: [
                                                                    GestureDetector(
                                                                      child:
                                                                          Container(
                                                                        width: double
                                                                            .infinity,
                                                                        height:
                                                                            500,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.only(
                                                                            topLeft:
                                                                                Radius.circular(16.0),
                                                                            topRight:
                                                                                Radius.circular(16.0),
                                                                          ),
                                                                          image:
                                                                              DecorationImage(
                                                                            image:
                                                                                NetworkImage(
                                                                              model.actions1[index]['processImageUrl'],
                                                                            ),
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    IconButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                      },
                                                                      icon: Icon(
                                                                          Icons
                                                                              .close),
                                                                    ),
                                                                  ],
                                                                ),
                                                              );
                                                            },
                                                          );

                                                          /////////
                                                        },
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              )),
                                SizedBox(
                                  height: height * 0.03,
                                )
                              ]);
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
                                            width *
                                                0.03), // set the radius here
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
                                      child: model.actions1[index]
                                                  ['processType'] ==
                                              'شحن-بيمو'
                                          ? Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Text(
                                                          "قيمة المبلغ المرسل",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.white,
                                                              fontSize: width *
                                                                  0.043),
                                                        ),
                                                        Text(
                                                          '${model.actions1[index]['amountValue']}',
                                                          style: TextStyle(
                                                              fontSize:
                                                                  width * 0.03,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ],
                                                    ),
                                                    Column(
                                                      children: [
                                                        Text(
                                                          "طريقة الشحن",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.white,
                                                              fontSize: width *
                                                                  0.043),
                                                        ),
                                                        Text(
                                                          '${model.actions1[index]['processType']}',
                                                          style: TextStyle(
                                                            fontSize:
                                                                width * 0.03,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  "التاريخ والوقت",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: width * 0.043),
                                                ),
                                                Text(
                                                  '${DateFormat('EEE,MMM dd,yyy_ hh:mm a').format(DateTime.parse(model.actions1[index]['createdAt']))}',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: width * 0.03),
                                                ),
                                                SizedBox(height: height * 0.02),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Text(
                                                          " اسم المرسل",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.white,
                                                              fontSize: width *
                                                                  0.043),
                                                        ),
                                                        Text(
                                                          '${model.actions1[index]['senderName']}',
                                                          style: TextStyle(
                                                            fontSize:
                                                                width * 0.03,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Column(
                                                      children: [
                                                        Text(
                                                          " رقم حساب البنك   ",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize:
                                                                  width * 0.04),
                                                        ),
                                                        Text(
                                                          '${model.actions1[index]['accountID']}',
                                                          style: TextStyle(
                                                            fontSize:
                                                                width * 0.03,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: height * 0.02),
                                                ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          foregroundColor:
                                                              Colors.green,
                                                          backgroundColor:
                                                              Colors.white),
                                                  child: const Text(
                                                      "معالجة الطلب"),
                                                  onPressed: () {},
                                                ),
                                              ],
                                            )
                                          : model.actions1[index]
                                                      ['processType'] ==
                                                  'شحن-كاش'
                                              ? Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Column(
                                                          children: [
                                                            Text(
                                                              "قيمة المبلغ المرسل",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      width *
                                                                          0.043),
                                                            ),
                                                            Text(
                                                              '${model.actions1[index]['amountValue']}',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      width *
                                                                          0.03),
                                                            ),
                                                          ],
                                                        ),
                                                        Column(
                                                          children: [
                                                            Text(
                                                              "طريقة الشحن",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      width *
                                                                          0.043),
                                                            ),
                                                            Text(
                                                              '${model.actions1[index]['processType']}',
                                                              style: TextStyle(
                                                                fontSize:
                                                                    width *
                                                                        0.03,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    Text(
                                                      "التاريخ والوقت",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white,
                                                          fontSize:
                                                              width * 0.043),
                                                    ),
                                                    Text(
                                                      '${DateFormat('EEE,MMM dd,yyy_ hh:mm a').format(DateTime.parse(model.actions1[index]['createdAt']))}',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize:
                                                              width * 0.03),
                                                    ),
                                                    SizedBox(
                                                        height: height * 0.02),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Column(
                                                          children: [
                                                            Text(
                                                              " رقم المرسل",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      width *
                                                                          0.043),
                                                            ),
                                                            Text(
                                                              '${model.actions1[index]['senderPhone']}',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize:
                                                                    width *
                                                                        0.03,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Column(
                                                          children: [
                                                            Text(
                                                              " رقم عملية التحويل  ",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      width *
                                                                          0.04),
                                                            ),
                                                            Text(
                                                              '${model.actions1[index]['processNumber']}',
                                                              style: TextStyle(
                                                                fontSize:
                                                                    width *
                                                                        0.03,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                        height: height * 0.02),
                                                    ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              foregroundColor:
                                                                  Colors.green,
                                                              backgroundColor:
                                                                  Colors.white),
                                                      child: const Text(
                                                          "معالجة الطلب"),
                                                      onPressed: () {
                                                        model.depositResponse(
                                                            context,
                                                            model.actions1[
                                                                index]['_id']);
                                                      },
                                                    ),
                                                  ],
                                                )
                                              : Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Column(
                                                          children: [
                                                            Text(
                                                              "قيمة المبلغ المرسل",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      width *
                                                                          0.043),
                                                            ),
                                                            Text(
                                                              '${model.actions1[index]['amountValue']}',
                                                              style: TextStyle(
                                                                fontSize:
                                                                    width *
                                                                        0.03,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Column(
                                                          children: [
                                                            Text(
                                                              "طريقة الشحن",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      width *
                                                                          0.043),
                                                            ),
                                                            Text(
                                                              '${model.actions1[index]['processType']}',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      width *
                                                                          0.03),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    Text(
                                                      "التاريخ والوقت",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize:
                                                              width * 0.043),
                                                    ),
                                                    Text(
                                                      '${DateFormat('EEE,MMM dd,yyy_ hh:mm a').format(DateTime.parse(model.actions1[index]['createdAt']))}',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize:
                                                              width * 0.03),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Column(
                                                          children: [
                                                            Text(
                                                              " اسم المرسل",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      width *
                                                                          0.043),
                                                            ),
                                                            Text(
                                                              '${model.actions1[index]['senderName']}',
                                                              style: TextStyle(
                                                                fontSize:
                                                                    width *
                                                                        0.03,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Column(
                                                          children: [
                                                            Text(
                                                              " رقم المرسل  ",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      width *
                                                                          0.04),
                                                            ),
                                                            Text(
                                                              '${model.actions1[index]['senderPhone']}',
                                                              style: TextStyle(
                                                                fontSize:
                                                                    width *
                                                                        0.03,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                        height: height * 0.02),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Column(
                                                          children: [
                                                            Text(
                                                              " عنوان المرسل",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      width *
                                                                          0.043),
                                                            ),
                                                            Text(
                                                              '${model.actions1[index]['senderCity']}',
                                                              style: TextStyle(
                                                                fontSize:
                                                                    width *
                                                                        0.03,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Column(
                                                          children: [
                                                            Text(
                                                              " رقم عملية الإرسال  ",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      width *
                                                                          0.04),
                                                            ),
                                                            Text(
                                                              '${model.actions1[index]['processNumber']}',
                                                              style: TextStyle(
                                                                fontSize:
                                                                    width *
                                                                        0.03,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                        height: height * 0.02),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                                  foregroundColor:
                                                                      Colors
                                                                          .green,
                                                                  backgroundColor:
                                                                      Colors
                                                                          .white),
                                                          child: const Text(
                                                              "معالجة الطلب"),
                                                          onPressed: () {
                                                            model.depositResponse(
                                                                context,
                                                                model.actions1[
                                                                        index]
                                                                    ['_id']);
                                                            setState(() {});
                                                          },
                                                        ),
                                                        ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                                  foregroundColor:
                                                                      Colors
                                                                          .green,
                                                                  backgroundColor:
                                                                      Colors
                                                                          .white),
                                                          child: const Text(
                                                              " عرض الوصل"),
                                                          onPressed: () {
                                                            showDialog(
                                                              context: context,
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                return Dialog(
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            16.0),
                                                                  ),
                                                                  child: Stack(
                                                                    alignment:
                                                                        Alignment
                                                                            .topRight,
                                                                    children: [
                                                                      GestureDetector(
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              double.infinity,
                                                                          height:
                                                                              500,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.only(
                                                                              topLeft: Radius.circular(16.0),
                                                                              topRight: Radius.circular(16.0),
                                                                            ),
                                                                            image:
                                                                                DecorationImage(
                                                                              image: NetworkImage(
                                                                                model.actions1[index]['processImageUrl'],
                                                                              ),
                                                                              fit: BoxFit.cover,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      IconButton(
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                        },
                                                                        icon: Icon(
                                                                            Icons.close),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                );
                                                              },
                                                            );

                                                            /////////
                                                          },
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                )),
                                  SizedBox(
                                    height: height * 0.03,
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
