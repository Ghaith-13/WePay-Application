import "package:flutter/material.dart";
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:wepay/BudgetMangment/InsertPayment.dart';
import 'package:wepay/model/Budgetmangment.dart';

class Tab1 extends StatelessWidget {
  final Tabstate;
  const Tab1({super.key, required this.Tabstate});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    var model = Provider.of<budgetmanage>(context);
    var model2 = Provider.of<tab3model>(context);

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(top: height * 0.01),
        child: Column(
          children: [
            //title recent activity
            Container(
              alignment: Alignment.centerRight,
              child: Text(
                " : آخر الأنشطة ",
                style: TextStyle(
                    color: Color.fromARGB(250, 58, 165, 117),
                    fontWeight: FontWeight.bold,
                    fontSize: width * 0.06),
              ),
            ),

            SizedBox(
              height: height * 0.02,
            ),

            //Recent Activity
            Container(
              padding: EdgeInsets.all(width * 0.04),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromARGB(255, 227, 227, 227),
                      Color.fromARGB(255, 205, 205, 205),
                    ],
                  ),
                  borderRadius:
                      BorderRadius.all(Radius.circular(width * 0.03))),
              width: width * 0.95,
              height: height * 0.6,
              child: Column(
                children: [
                  model.lastActivities == null
                      ? Container(
                          height: height * 0.5,
                          child: Center(
                            child: Lottie.asset('./assets/one.json'),
                          ),
                        )
                      : Container(
                          width: width * 0.9,
                          height: height * 0.5,
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            Color.fromARGB(255, 120, 220, 175),
                                            Color.fromARGB(255, 30, 84, 59),
                                          ],
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(width * 0.03))),
                                    width: width * 0.9,
                                    height: height * 0.08,
                                    child: Padding(
                                      padding: EdgeInsets.all(width * 0.03),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "${model.lastActivities[index]['amountValue']} SYP",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          SizedBox(
                                            width: width * 0.05,
                                          ),
                                          Expanded(
                                            child: Align(
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                model.lastActivities[index]
                                                            ['sender'] ==
                                                        model.userid
                                                    ? "${model.lastActivities[index]['senderDetails']}"
                                                    : "${model.lastActivities[index]['reciverDetails']}",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.02,
                                  ),
                                ],
                              );
                            },
                            itemCount: model.lastActivities == null
                                ? 0
                                : model.lastActivities.length,
                          ),
                        ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Tabstate.animateTo(1);
                      },
                      child: const Text("عرض الكل "),
                    ),
                  )
                ],
              ),
            ),
            Image.asset('assets/divider.png'),

            Container(
              padding: EdgeInsets.only(right: width * 0.03),
              alignment: Alignment.centerRight,
              child: Text(
                "أهم المدفوعات المستحقة",
                style: TextStyle(
                    color: Color.fromARGB(250, 58, 165, 117),
                    fontWeight: FontWeight.bold,
                    fontSize: width * 0.06),
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            //Recent payment
            Container(
              padding: EdgeInsets.all(width * 0.04),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromARGB(255, 227, 227, 227),
                      Color.fromARGB(255, 205, 205, 205),
                    ],
                  ),
                  borderRadius:
                      BorderRadius.all(Radius.circular(width * 0.03))),
              width: width * 0.95,
              height: height * 0.8,
              child: Column(
                children: [
                  model.lastPayments == null || model.lastPayments.length == 0
                      ? Container(
                          width: width * 0.9,
                          height: height * 0.69,
                          child: Center(
                            child: Lottie.asset('./assets/one.json'),
                          ),
                        )
                      : Container(
                          width: width * 0.9,
                          height: height * 0.69,
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            Color.fromARGB(255, 120, 220, 175),
                                            Color.fromARGB(255, 30, 84, 59),
                                          ],
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(width * 0.03))),
                                    width: width * 0.9,
                                    height: height * 0.2,
                                    child: Padding(
                                        padding: EdgeInsets.all(width * 0.04),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: height * 0.007),
                                                  child: Text(
                                                    "${model.lastPayments[index]['paymentValue']} SYP",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                Text(
                                                  model.lastPayments[index]
                                                      ['paymentInfo'],
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )
                                              ],
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
                                                      ": آخر موعد للدفع",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white),
                                                    ),
                                                    Text(
                                                      "${DateTime.parse(model.lastPayments[index]['paymentDate']).year}/${DateTime.parse(model.lastPayments[index]['paymentDate']).month}/${DateTime.parse(model.lastPayments[index]['paymentDate']).day}",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white),
                                                    ),
                                                  ],
                                                ),

                                                //paidStatus isPayable isMonthlyPayable
                                                DateTime.now().isBefore(
                                                        DateTime.parse(model
                                                                .lastPayments[index]
                                                            ['paymentDate']))
                                                    ? model.lastPayments[index]
                                                                ['isPayable'] ==
                                                            1
                                                        ? model.lastPayments[index][
                                                                    'paidStatus'] ==
                                                                false
                                                            ? model.lastPayments[index]['isMonthlyPayable'] ==
                                                                    1
                                                                ? ElevatedButton(
                                                                    style: ElevatedButton.styleFrom(
                                                                        padding:
                                                                            EdgeInsets.symmetric(horizontal: width * 0.06),
                                                                        primary: Colors.white),
                                                                    onPressed: () {
                                                                      model2.payNow(
                                                                          model.lastPayments[index]
                                                                              [
                                                                              '_id'],
                                                                          context);
                                                                    },
                                                                    child: Text(
                                                                      "دفع القسط الشهري",
                                                                      style:
                                                                          TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        color: Color.fromARGB(
                                                                            250,
                                                                            58,
                                                                            165,
                                                                            117),
                                                                      ),
                                                                    ))
                                                                : ElevatedButton(
                                                                    style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(horizontal: width * 0.06), primary: Colors.white),
                                                                    onPressed: () {
                                                                      model2.payNow(
                                                                          model.lastPayments[index]
                                                                              [
                                                                              '_id'],
                                                                          context);
                                                                    },
                                                                    child: Text(
                                                                      "ادفع الان",
                                                                      style:
                                                                          TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        color: Color.fromARGB(
                                                                            250,
                                                                            58,
                                                                            165,
                                                                            117),
                                                                      ),
                                                                    ))
                                                            : Text("عدد الأشهر المتبقية : ${model.lastPayments[index]['numberOfMonthsLeft']}  \n قيمة القسط : ${model.lastPayments[index]['monthlyValue']}  \n تم الدفع هذا الشهر", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))
                                                        : model.lastPayments[index]['isMonthlyPayable'] == 1
                                                            ? Text("عدد الأشهر المتبقية : ${model.lastPayments[index]['numberOfMonthsLeft']}  \n قيمة القسط : ${model.lastPayments[index]['monthlyValue']}  \n عدد الأيام المتبقية للدفعة ${model.lastPayments[index]['daysDiff']}", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))
                                                            : Text("دفع لمرة واحدة يدوياً", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))
                                                    : Text("لقد تجاوزت آخر موعد للدفع", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                              ],
                                            )
                                          ],
                                        )),
                                  ),
                                  SizedBox(
                                    height: height * 0.022,
                                  ),
                                ],
                              );
                            },
                            itemCount: model.lastPayments == null
                                ? 0
                                : model.lastPayments.length,
                          )),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.015),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    transitionDuration:
                                        const Duration(seconds: 1),
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
                                      return ScaleTransition(
                                        alignment: Alignment.center,
                                        scale: animation,
                                        child: child,
                                      );
                                    },
                                    pageBuilder: (context, animation,
                                        secondaryAnimation) {
                                      return InsertPayment(model: model);
                                    },
                                  ));
                            },
                            child: const Text("إضافة "),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Tabstate.animateTo(2);
                            },
                            child: const Text("عرض الكل"),
                          ),
                        ],
                      ),
                    ),
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
