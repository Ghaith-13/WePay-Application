import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:wepay/model/Pay.dart';
import 'package:wepay/model/Payment.dart';
import 'package:wepay/model/Payment.dart';
import 'package:wepay/model/Payment.dart';
import 'package:intl/intl.dart';
class LastRecharge extends StatefulWidget {
  const LastRecharge({super.key});

  @override
  State<LastRecharge> createState() => _LastRechargeState();
}

class _LastRechargeState extends State<LastRecharge> {
  static List<Pay> main_List = [
    Pay("شحن", "رصيد الحساب", "300000", DateTime.now()),
    Pay("شحن", "رصيد الحساب", "300000", DateTime.now()),
    Pay("شحن", "رصيد الحساب", "300000", DateTime.now()),
    Pay("شحن", "رصيد الحساب", "300000", DateTime.now()),
    // Pay("شحن", "رصيد الحساب", "300000", DateTime.now()),
  ];

  @override
  int i=0;
   Widget build(BuildContext context) {
    var model = Provider.of<depositandwithdraw>(context);
    
    if (i == 0) {
      model.getActionsForWithdraw(context,'deposit');
      print("rounia");
      print(model.showactions1);
      i++;
    }
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            ": آخر عمليات  الشحن",
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 20.w),
        ],
      ),
      SizedBox(
        height: 12.h,
      ),
      SingleChildScrollView(
        child: model.showactions1 == false
            ? Center(
                child: Lottie.asset('./assets/one.json'),
              )
            : model.actionsForWithdraw1 == null
                ? Center(child: CircularProgressIndicator())
                : Container(
                    height: height * 0.5,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: height * 0.019),
                      child: ListView.builder(

                          // margin:EdgeInsets.all(0.0),
                          shrinkWrap: true,
                          itemCount: model.actionsForWithdraw1.length,
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
                                               '${DateFormat('EEE,MMM dd,yyy_ hh:mm a').format(DateTime.parse(model.actionsForWithdraw1[index]['createdAt']))}',
                                              style: TextStyle(
                                                  fontSize: width * 0.03),
                                            ),
                                            Text(
                                              "حالة النشاط",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: width * 0.04),
                                            ),
                                            Text(
                                              model.actionsForWithdraw1[index]
                                                          ["status"] ==
                                                      true
                                                  ? "تمت المعالجة"
                                                  : "قيد المعالجة",
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
                                                '${model.actionsForWithdraw1[index]['reciverAction']}'),
                                            Container(
                                              width: width * 0.3,
                                              alignment: Alignment.center,
                                              child: Text(
                                                '${model.actionsForWithdraw1[index]['reciverDetails']}',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: width * 0.03),
                                              ),
                                            ),
                                            Text(
                                              "قيمة التحويل :",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: width * 0.04),
                                            ),
                                            Text(
                                              '${model.actionsForWithdraw1[index]['amountValue']}',
                                              style: TextStyle(
                                                  color: Colors.black),
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
                            } else  {
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
                                              '${model.actionsForWithdraw1[index]['createdAt']}',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: width * 0.03),
                                            ),
                                            Text(
                                              "حالة النشاط",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: width * 0.04),
                                            ),
                                            Text(
                                              model.actionsForWithdraw1[index]
                                                          ["status"] ==
                                                      true
                                                  ? "تمت المعالجة"
                                                  : "قيد المعالجة",
                                              style: TextStyle(
                                                  color: Colors.white),
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
                                              '${model.actionsForWithdraw1[index]['reciverAction']}',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),

                                            Container(
                                              width: width * 0.3,
                                              alignment: Alignment.center,
                                              child: Text(
                                                '${model.actionsForWithdraw1[index]['reciverDetails']}',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Color.fromARGB(255, 248, 246, 246),
                                                    fontSize: width * 0.03),
                                              ),
                                            ),
                                            Text(
                                              "قيمة التحويل :",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: width * 0.04),
                                            ),
                                            //amountValue
                                            Text(
                                              '${model.actionsForWithdraw1[index]['amountValue']}',
                                              style: TextStyle(
                                                  color: Colors.white),
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
