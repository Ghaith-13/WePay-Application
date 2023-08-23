import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:provider/provider.dart';
import 'package:wepay/model/Budgetmangment.dart';

class Tab3 extends StatefulWidget {
  const Tab3({Key? key}) : super(key: key);

  @override
  _Tab3State createState() => _Tab3State();
}

class _Tab3State extends State<Tab3> {
  int _currentPage = 0;

  var Colorbutton1 = Color.fromARGB(255, 217, 217, 217);
  var Colorbutton2 = Color.fromARGB(250, 58, 165, 117);
  var Colorbutton3 = Color.fromARGB(250, 58, 165, 117);
  var Colorbutton4 = Color.fromARGB(250, 58, 165, 117);
  var Colorbutton5 = Color.fromARGB(250, 58, 165, 117);
  var TextColorButton1 = Color.fromARGB(250, 58, 165, 117);
  var TextColorButton2 = Color.fromARGB(255, 255, 255, 255);
  var TextColorButton3 = Color.fromARGB(255, 255, 255, 255);
  var TextColorButton4 = Color.fromARGB(255, 255, 255, 255);
  var TextColorButton5 = Color.fromARGB(255, 255, 255, 255);
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("من الأقدم للأحدث"), value: "OTN"),
      DropdownMenuItem(child: Text("من الأحدث للأقدم"), value: "NTO"),
    ];
    return menuItems;
  }

  List<DropdownMenuItem<String>> get dropdownItems2 {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("من الأرخص للأغلى"), value: "CTE"),
      DropdownMenuItem(child: Text("من الأغلى للأرخص"), value: "ETC"),
    ];
    return menuItems;
  }

  String selectedValue1 = "OTN";
  String selectedValue2 = "CTE";

  @override
  int i = 0;
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    var model = Provider.of<tab3model>(context);
    if (i == 0) {
      model.fetchData(context);

      i++;
    }
    var pages = List.generate(
      model.data == null ? 0 : ((model.data.length ?? 0) / 3).ceil(),
      (index) {
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.03),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DropdownButton(
                      value: selectedValue1,
                      onChanged: (String? newValue) {
                        model.sortByDate(newValue);
                        setState(() {
                          selectedValue1 = newValue!;
                        });
                      },
                      items: dropdownItems),
                  DropdownButton(
                      value: selectedValue2,
                      onChanged: (String? newValue) {
                        model.sortByPrice(newValue);
                        setState(() {
                          selectedValue2 = newValue!;
                        });
                      },
                      items: dropdownItems2),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Container(
                width: width * 0.95,
                height: height * 0.525,
                child: ListView.builder(
                  itemBuilder: (context, index2) {
                    // model.fetchdataforeachpage();
                    return Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
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
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color.fromARGB(255, 120, 220, 175),
                                  Color.fromARGB(255, 30, 84, 59),
                                ],
                              ),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(width * 0.05))),
                          width: width * 0.95,
                          child: Padding(
                              padding: EdgeInsets.all(width * 0.02),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      model.result[index][index2]
                                                      ['isPayable'] ==
                                                  1 &&
                                              model.result[index][index2]
                                                      ['paidStatus'] ==
                                                  false &&
                                              DateTime.now().isBefore(
                                                  DateTime.parse(model
                                                          .result[index][index2]
                                                      ['paymentDate']))
                                          ? ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: width * 0.06),
                                                  primary: Colors.white),
                                              onPressed: () {
                                                model.payNow(
                                                    model.result[index][index2]
                                                        ['_id'],
                                                    context);
                                              },
                                              child: Text(
                                                "ادفع الآن",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromARGB(
                                                      250, 58, 165, 117),
                                                ),
                                              ),
                                            )
                                          : Text(""),
                                      SizedBox(
                                        height: height * 0.01,
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.white),
                                        onPressed: () {
                                          model.DeletePayment(
                                              model.result[index][index2]
                                                  ['_id'],
                                              context);
                                        },
                                        child: Text(
                                          "حذف الدفعة",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                250, 58, 165, 117),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "نوع الدفعة : ${model.result[index][index2]['paymentType']}",
                                        style: TextStyle(
                                            fontSize: width * 0.025,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "SYP قسط الدفعة : ${model.result[index][index2]['paymentValue']}",
                                        style: TextStyle(
                                            fontSize: width * 0.025,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "اسم الدفعة :${model.result[index][index2]['paymentInfo']}",
                                        style: TextStyle(
                                            fontSize: width * 0.025,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "آخر موعد للدفع : ${DateTime.parse(model.result[index][index2]['paymentDate']).year}/${DateTime.parse(model.result[index][index2]['paymentDate']).month}/${DateTime.parse(model.result[index][index2]['paymentDate']).day}",
                                        style: TextStyle(
                                            fontSize: width * 0.025,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                          textAlign: TextAlign.right,
                                          DateTime.now().isBefore(DateTime.parse(
                                                  model.result[index][index2]
                                                      ['paymentDate']))
                                              ? model.result[index][index2]['isMonthlyPayable'] ==
                                                      0
                                                  ? model.result[index][index2]
                                                              ['isPayable'] ==
                                                          1
                                                      ? "دفع لمرة واحدة عبر موقعنا"
                                                      : "دفع لمرة واحدة يدوياً"
                                                  : model.result[index][index2]
                                                              ['isPayable'] ==
                                                          1
                                                      ? model.result[index][index2]['paidStatus'] ==
                                                              false
                                                          ? "عدد الأشهر المتبقية : ${model.result[index][index2]['numberOfMonthsLeft']}  \n قيمة القسط : ${model.result[index][index2]['monthlyValue']}  \n عدد الأيام المتبقية للدفعة ${model.result[index][index2]['daysDiff']}"
                                                          : "عدد الأشهر المتبقية : ${model.result[index][index2]['numberOfMonthsLeft']} \n قيمة القسط : ${model.result[index][index2]['monthlyValue']} تم الدفع هذا الشهر"
                                                      : "عدد الأشهر المتبقية : ${model.result[index][index2]['numberOfMonthsLeft']} \n قيمة القسط : ${model.result[index][index2]['monthlyValue']} تم الدفع هذا الشهر"
                                              : "لقد تجاوزت آخر موعد للدفع",
                                          style: TextStyle(
                                              fontSize: width * 0.025,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold))
                                    ],
                                  ),
                                ],
                              )),
                        ),
                        SizedBox(
                          height: height * 0.05,
                        ),
                      ],
                    );
                  },
                  itemCount: model.result[index].length,
                ),
              ),
            )
          ],
        );
      },
    );

    return Scaffold(
      body: model.data == null
          ? Center(
              child: Lottie.asset('./assets/one.json'),
            )
          : Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    height: height * 0.1,
                    child: Row(
                      children: [
                        SizedBox(
                          width: width * 0.03,
                        ),
                        ElevatedButton(
                          style:
                              ElevatedButton.styleFrom(primary: Colorbutton1),
                          onPressed: () {
                            model.sort("all");
                            setState(() {
                              Colorbutton2 = Color.fromARGB(250, 58, 165, 117);
                              Colorbutton1 = Color.fromARGB(255, 217, 217, 217);
                              Colorbutton3 = Color.fromARGB(250, 58, 165, 117);
                              Colorbutton4 = Color.fromARGB(250, 58, 165, 117);
                              Colorbutton5 = Color.fromARGB(250, 58, 165, 117);

                              TextColorButton1 =
                                  Color.fromARGB(250, 58, 165, 117);
                              TextColorButton2 =
                                  Color.fromARGB(255, 255, 255, 255);
                              TextColorButton3 =
                                  Color.fromARGB(255, 255, 255, 255);
                              TextColorButton4 =
                                  Color.fromARGB(255, 255, 255, 255);
                              TextColorButton5 =
                                  Color.fromARGB(255, 255, 255, 255);
                            });
                          },
                          child: Text(
                            "كل الدفوعات",
                            style: TextStyle(
                                color: TextColorButton1,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          width: width * 0.02,
                        ),
                        ElevatedButton(
                          style:
                              ElevatedButton.styleFrom(primary: Colorbutton2),
                          onPressed: () {
                            model.sort("دين");
                            setState(() {
                              Colorbutton1 = Color.fromARGB(250, 58, 165, 117);
                              Colorbutton2 = Color.fromARGB(255, 217, 217, 217);
                              Colorbutton3 = Color.fromARGB(250, 58, 165, 117);
                              Colorbutton4 = Color.fromARGB(250, 58, 165, 117);
                              Colorbutton5 = Color.fromARGB(250, 58, 165, 117);

                              TextColorButton2 =
                                  Color.fromARGB(250, 58, 165, 117);
                              TextColorButton1 =
                                  Color.fromARGB(255, 255, 255, 255);
                              TextColorButton3 =
                                  Color.fromARGB(255, 255, 255, 255);
                              TextColorButton4 =
                                  Color.fromARGB(255, 255, 255, 255);
                              TextColorButton5 =
                                  Color.fromARGB(255, 255, 255, 255);
                            });
                          },
                          child: Text(
                            "الديون",
                            style: TextStyle(
                                color: TextColorButton2,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          width: width * 0.02,
                        ),
                        ElevatedButton(
                          style:
                              ElevatedButton.styleFrom(primary: Colorbutton3),
                          onPressed: () {
                            model.sort("قسط شهري");
                            setState(() {
                              Colorbutton1 = Color.fromARGB(250, 58, 165, 117);
                              Colorbutton3 = Color.fromARGB(255, 217, 217, 217);
                              Colorbutton2 = Color.fromARGB(250, 58, 165, 117);
                              Colorbutton4 = Color.fromARGB(250, 58, 165, 117);
                              Colorbutton5 = Color.fromARGB(250, 58, 165, 117);

                              TextColorButton3 =
                                  Color.fromARGB(250, 58, 165, 117);
                              TextColorButton2 =
                                  Color.fromARGB(255, 255, 255, 255);
                              TextColorButton1 =
                                  Color.fromARGB(255, 255, 255, 255);
                              TextColorButton4 =
                                  Color.fromARGB(255, 255, 255, 255);
                              TextColorButton5 =
                                  Color.fromARGB(255, 255, 255, 255);
                            });
                          },
                          child: Text(
                            "الأقساط الشهرية ",
                            style: TextStyle(
                                color: TextColorButton3,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          width: width * 0.02,
                        ),
                        ElevatedButton(
                          style:
                              ElevatedButton.styleFrom(primary: Colorbutton4),
                          onPressed: () {
                            model.sort("دين لمتجر");
                            setState(() {
                              Colorbutton1 = Color.fromARGB(250, 58, 165, 117);
                              Colorbutton4 = Color.fromARGB(255, 217, 217, 217);
                              Colorbutton3 = Color.fromARGB(250, 58, 165, 117);
                              Colorbutton2 = Color.fromARGB(250, 58, 165, 117);
                              Colorbutton5 = Color.fromARGB(250, 58, 165, 117);

                              TextColorButton4 =
                                  Color.fromARGB(250, 58, 165, 117);
                              TextColorButton2 =
                                  Color.fromARGB(255, 255, 255, 255);
                              TextColorButton3 =
                                  Color.fromARGB(255, 255, 255, 255);
                              TextColorButton1 =
                                  Color.fromARGB(255, 255, 255, 255);
                              TextColorButton5 =
                                  Color.fromARGB(255, 255, 255, 255);
                            });
                          },
                          child: Text(
                            "ديون المتاجر",
                            style: TextStyle(
                                color: TextColorButton4,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          width: width * 0.02,
                        ),
                        ElevatedButton(
                          style:
                              ElevatedButton.styleFrom(primary: Colorbutton5),
                          onPressed: () {
                            model.sort("مدفوعات أخرى");
                            setState(() {
                              Colorbutton1 = Color.fromARGB(250, 58, 165, 117);
                              Colorbutton5 = Color.fromARGB(255, 217, 217, 217);
                              Colorbutton3 = Color.fromARGB(250, 58, 165, 117);
                              Colorbutton4 = Color.fromARGB(250, 58, 165, 117);
                              Colorbutton2 = Color.fromARGB(250, 58, 165, 117);

                              TextColorButton5 =
                                  Color.fromARGB(250, 58, 165, 117);
                              TextColorButton2 =
                                  Color.fromARGB(255, 255, 255, 255);
                              TextColorButton3 =
                                  Color.fromARGB(255, 255, 255, 255);
                              TextColorButton4 =
                                  Color.fromARGB(255, 255, 255, 255);
                              TextColorButton1 =
                                  Color.fromARGB(255, 255, 255, 255);
                            });
                          },
                          child: Text(
                            "مدفوعات أخرى ",
                            style: TextStyle(
                                color: TextColorButton5,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          width: width * 0.02,
                        ),
                      ],
                    ),
                  ),
                ),
                model.data == null || model.data.length == 0
                    ? Center(
                        child: Lottie.asset('./assets/one.json'),
                      )
                    : pages[_currentPage],
                Container(
                  height: height * 0.05,
                  child: Card(
                    margin: EdgeInsets.zero,
                    elevation: 4,
                    child: NumberPaginator(
                      // by default, the paginator shows numbers as center content
                      numberPages: model.data == null || model.data.length == 0
                          ? 1
                          : (model.data.length / 3).ceil(),

                      onPageChange: (int index) {
                        setState(() {
                          _currentPage = index;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
      // card for elevation
    );
  }
}
