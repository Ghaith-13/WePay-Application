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

class widthdraweAdmin extends StatefulWidget {
  const widthdraweAdmin({super.key});

  @override
  State<widthdraweAdmin> createState() => _widthdraweAdminState();
}

class _widthdraweAdminState extends State<widthdraweAdmin> {
  int i = 0;

  @override
  Widget build(BuildContext context) {
    var model = Provider.of<depositandwithdraw>(context);
    if (i == 0) {
      model.getAllWithdrawRequests(context);
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
            ":آخر طلبات السحب ",
            textAlign: TextAlign.start,
            style:
                TextStyle(fontSize: width * 0.05, fontWeight: FontWeight.bold),
          ),
          SizedBox(width: width * 0.05),
        ],
      ),
      
      SingleChildScrollView(
        child: model.isFull1 == false
            ? 
            Center(child: CircularProgressIndicator())
            : model.actions2 == null
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
                          itemCount: model.actions2.length,
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
                                    child: model.actions2[index]
                                                ['processType'] ==
                                            'سحب-بيمو'
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
                                                        "قيمة المبلغ المراد سحبه",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize:
                                                                width * 0.043),
                                                      ),
                                                      Text(
                                                        '${model.actions2[index]['amountValue']}',
                                                        style: TextStyle(
                                                            fontSize:
                                                                width * 0.03),
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    children: [
                                                      Text(
                                                        "طريقة السحب",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize:
                                                                width * 0.043),
                                                      ),
                                                      Text(
                                                        '${model.actions2[index]['processType']}',
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
                                                '${DateFormat('EEE,MMM dd,yyy_ hh:mm a').format(DateTime.parse(model.actions2[index]['createdAt']))}',
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
                                                        " رقم حساب بنك بيمو للمستقبل  ",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize:
                                                                width * 0.04),
                                                      ),
                                                      Text(
                                                        '${model.actions2[index]['accountID']}',
                                                        style: TextStyle(
                                                            fontSize:
                                                                width * 0.03),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: height * 0.01),
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  foregroundColor: Colors.white,
                                                ),
                                                child:
                                                    const Text("معالجة الطلب"),
                                                onPressed: () async {
                                                  model.withdrawResponse(
                                                      context,
                                                      model.actions2[index]
                                                          ['_id']);
                                                  setState(() {});
                                                },
                                              ),
                                            ],
                                          )
                                        : model.actions2[index]
                                                    ['processType'] ==
                                                'سحب-كاش'
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
                                                            "قيمة المبلغ المراد سحبه",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize:
                                                                    width *
                                                                        0.043),
                                                          ),
                                                          Text(
                                                            '${model.actions2[index]['amountValue']}',
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
                                                            "طريقة السحب",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize:
                                                                    width *
                                                                        0.043),
                                                          ),
                                                          Text(
                                                            '${model.actions2[index]['processType']}',
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
                                                    '${DateFormat('EEE,MMM dd,yyy_ hh:mm a').format(DateTime.parse(model.actions2[index]['createdAt']))}',
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
                                                            " رقم المستقبل",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize:
                                                                    width *
                                                                        0.043),
                                                          ),
                                                          Text(
                                                            '${model.actions2[index]['reciverPhone']}',
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
                                                            " نوع حساب المستقبل    ",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize:
                                                                    width *
                                                                        0.04),
                                                          ),
                                                          Text(
                                                            '${model.actions2[index]['cashType']}',
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
                                                      model.withdrawResponse(
                                                          context,
                                                          model.actions2[index]
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
                                                            "قيمة المبلغ المراد سحبه",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize:
                                                                    width *
                                                                        0.043),
                                                          ),
                                                          Text(
                                                            '${model.actions2[index]['amountValue']}',
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
                                                            "طريقة السحب",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize:
                                                                    width *
                                                                        0.043),
                                                          ),
                                                          Text(
                                                            '${model.actions2[index]['processType']}',
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
                                                    '${DateFormat('EEE,MMM dd,yyy_ hh:mm a').format(DateTime.parse(model.actions2[index]['createdAt']))}',
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
                                                            " اسم المستقبل",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize:
                                                                    width *
                                                                        0.043),
                                                          ),
                                                          Text(
                                                            '${model.actions2[index]['reciverName']}',
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
                                                            " رقم المستقبل  ",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize:
                                                                    width *
                                                                        0.04),
                                                          ),
                                                          Text(
                                                            '${model.actions2[index]['reciverPhone']}',
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
                                                            .center,
                                                    children: [
                                                      Column(
                                                        children: [
                                                          Text(
                                                            " عنوان المستقبل",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize:
                                                                    width *
                                                                        0.043),
                                                          ),
                                                          Text(
                                                            '${model.actions2[index]['reciverCity']}',
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
                                                          model.withdrawResponse(
                                                              context,
                                                              model.actions2[
                                                                      index]
                                                                  ['_id']);
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
                                          Color.fromARGB(250, 58, 165, 117),
                                          Color.fromARGB(255, 30, 84, 59),
                                        ], // set the gradient colors here
                                      ),
                                    ),
                                    width: width * 0.9,
                                    child: model.actions2[index]
                                                ['processType'] ==
                                            'سحب-بيمو'
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
                                                        "قيمة المبلغ المراد سحبه",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize:
                                                                width * 0.043,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      Text(
                                                        '${model.actions2[index]['amountValue']}',
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
                                                        "طريقة السحب",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize:
                                                                width * 0.043,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      Text(
                                                        '${model.actions2[index]['processType']}',
                                                        style: TextStyle(
                                                            fontSize:
                                                                width * 0.03,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                "التاريخ والوقت",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: width * 0.043,
                                                    color: Colors.white),
                                              ),
                                              Text(
                                                '${DateFormat('EEE,MMM dd,yyy_ hh:mm a').format(DateTime.parse(model.actions2[index]['createdAt']))}',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: width * 0.03),
                                              ),
                                              SizedBox(height: height * 0.02),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Column(
                                                    children: [
                                                      Text(
                                                        " رقم حساب بنك بيمو للمستقبل  ",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize:
                                                                width * 0.04,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      Text(
                                                        '${model.actions2[index]['accountID']}',
                                                        style: TextStyle(
                                                            fontSize:
                                                                width * 0.03,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: height * 0.01),
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  foregroundColor: Colors.green,
                                                  backgroundColor: Colors.white,
                                                ),
                                                child:
                                                    const Text("معالجة الطلب"),
                                                onPressed: () async {
                                                  model.withdrawResponse(
                                                      context,
                                                      model.actions2[index]
                                                          ['_id']);
                                                  setState(() {});
                                                },
                                              ),
                                            ],
                                          )
                                        : model.actions2[index]
                                                    ['processType'] ==
                                                'سحب-كاش'
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
                                                            "قيمة المبلغ المراد سحبه",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize:
                                                                    width *
                                                                        0.043,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          Text(
                                                            '${model.actions2[index]['amountValue']}',
                                                            style: TextStyle(
                                                                fontSize:
                                                                    width *
                                                                        0.03,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ],
                                                      ),
                                                      Column(
                                                        children: [
                                                          Text(
                                                            "طريقة السحب",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize:
                                                                    width *
                                                                        0.043,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          Text(
                                                            '${model.actions2[index]['processType']}',
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
                                                    '${DateFormat('EEE,MMM dd,yyy_ hh:mm a').format(DateTime.parse(model.actions2[index]['createdAt']))}',
                                                    style: TextStyle(
                                                        color: Colors.white,
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
                                                            " رقم المستقبل",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize:
                                                                    width *
                                                                        0.043,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          Text(
                                                            '${model.actions2[index]['reciverPhone']}',
                                                            style: TextStyle(
                                                                fontSize:
                                                                    width *
                                                                        0.03,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ],
                                                      ),
                                                      Column(
                                                        children: [
                                                          Text(
                                                            " نوع حساب المستقبل    ",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize:
                                                                    width *
                                                                        0.04,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          Text(
                                                            '${model.actions2[index]['cashType']}',
                                                            style: TextStyle(
                                                                fontSize:
                                                                    width *
                                                                        0.03,
                                                                color: Colors
                                                                    .white),
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
                                                          Colors.white,
                                                    ),
                                                    child: const Text(
                                                        "معالجة الطلب"),
                                                    onPressed: () {
                                                      model.withdrawResponse(
                                                          context,
                                                          model.actions2[index]
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
                                                            "قيمة المبلغ المراد سحبه",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize:
                                                                    width *
                                                                        0.043,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          Text(
                                                            '${model.actions2[index]['amountValue']}',
                                                            style: TextStyle(
                                                                fontSize:
                                                                    width *
                                                                        0.03,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ],
                                                      ),
                                                      Column(
                                                        children: [
                                                          Text(
                                                            "طريقة السحب",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize:
                                                                    width *
                                                                        0.043,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          Text(
                                                            '${model.actions2[index]['processType']}',
                                                            style: TextStyle(
                                                                fontSize:
                                                                    width *
                                                                        0.03,
                                                                color: Colors
                                                                    .white),
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
                                                        fontSize: width * 0.043,
                                                        color: Colors.white),
                                                  ),
                                                  Text(
                                                    '${DateFormat('EEE,MMM dd,yyy_ hh:mm a').format(DateTime.parse(model.actions2[index]['createdAt']))}',
                                                    style: TextStyle(
                                                        color: Colors.white,
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
                                                            " اسم المستقبل",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize:
                                                                    width *
                                                                        0.043,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          Text(
                                                            '${model.actions2[index]['reciverName']}',
                                                            style: TextStyle(
                                                                fontSize:
                                                                    width *
                                                                        0.03,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ],
                                                      ),
                                                      Column(
                                                        children: [
                                                          Text(
                                                            " رقم المستقبل  ",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize:
                                                                    width *
                                                                        0.04,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          Text(
                                                            '${model.actions2[index]['reciverPhone']}',
                                                            style: TextStyle(
                                                                fontSize:
                                                                    width *
                                                                        0.03,
                                                                color: Colors
                                                                    .white),
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
                                                            .center,
                                                    children: [
                                                      Column(
                                                        children: [
                                                          Text(
                                                            " عنوان المستقبل",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize:
                                                                    width *
                                                                        0.043,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          Text(
                                                            '${model.actions2[index]['reciverCity']}',
                                                            style: TextStyle(
                                                                fontSize:
                                                                    width *
                                                                        0.03,
                                                                color: Colors
                                                                    .white),
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
                                                              Colors.green,
                                                          backgroundColor:
                                                              Colors.white,
                                                        ),
                                                        child: const Text(
                                                            "معالجة الطلب"),
                                                        onPressed: () {
                                                          model.withdrawResponse(
                                                              context,
                                                              model.actions2[
                                                                      index]
                                                                  ['_id']);
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
                            }
                          }),
                    ),
                  ),
      ),
    ]);
  }
}
