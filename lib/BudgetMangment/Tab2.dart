import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:wepay/model/Budgetmangment.dart';

class Tab2 extends StatefulWidget {
  const Tab2({super.key});

  @override
  State<Tab2> createState() => _Tab2State();
}

class _Tab2State extends State<Tab2> {
  var Colorbutton1 = Color.fromARGB(255, 217, 217, 217);
  var Colorbutton2 = Color.fromARGB(250, 58, 165, 117);
  var Colorbutton3 = Color.fromARGB(250, 58, 165, 117);
  var Colorbutton4 = Color.fromARGB(250, 58, 165, 117);
  var Colorbutton5 = Color.fromARGB(250, 58, 165, 117);
  var Colorbutton6 = Color.fromARGB(250, 58, 165, 117);

  var TextColorButton1 = Color.fromARGB(250, 58, 165, 117);
  var TextColorButton2 = Color.fromARGB(255, 255, 255, 255);
  var TextColorButton3 = Color.fromARGB(255, 255, 255, 255);
  var TextColorButton4 = Color.fromARGB(255, 255, 255, 255);
  var TextColorButton5 = Color.fromARGB(255, 255, 255, 255);
  var TextColorButton6 = Color.fromARGB(255, 255, 255, 255);

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
    var model = Provider.of<tab2model>(context);
    final DataTableSource _data = MyData(context);

    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;

    if (i == 0) {
      model.fetchData(context);
      i++;
    }
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            child: Row(
              children: [
                SizedBox(
                  width: width * 0.03,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colorbutton1),
                  onPressed: () {
                    model.alloperations();
                    setState(() {
                      Colorbutton2 = Color.fromARGB(250, 58, 165, 117);
                      Colorbutton1 = Color.fromARGB(255, 217, 217, 217);
                      Colorbutton3 = Color.fromARGB(250, 58, 165, 117);
                      Colorbutton4 = Color.fromARGB(250, 58, 165, 117);
                      Colorbutton5 = Color.fromARGB(250, 58, 165, 117);
                      Colorbutton6 = Color.fromARGB(250, 58, 165, 117);
                      TextColorButton6 = Color.fromARGB(255, 255, 255, 255);

                      TextColorButton1 = Color.fromARGB(250, 58, 165, 117);
                      TextColorButton2 = Color.fromARGB(255, 255, 255, 255);
                      TextColorButton3 = Color.fromARGB(255, 255, 255, 255);
                      TextColorButton4 = Color.fromARGB(255, 255, 255, 255);
                      TextColorButton5 = Color.fromARGB(255, 255, 255, 255);
                    });
                  },
                  child: Text(
                    "كل العمليات",
                    style: TextStyle(
                        color: TextColorButton1, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: width * 0.02,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colorbutton2),
                  onPressed: () {
                    model.sortbysender('تحويل');
                    setState(() {
                      Colorbutton1 = Color.fromARGB(250, 58, 165, 117);
                      Colorbutton2 = Color.fromARGB(255, 217, 217, 217);
                      Colorbutton3 = Color.fromARGB(250, 58, 165, 117);
                      Colorbutton4 = Color.fromARGB(250, 58, 165, 117);
                      Colorbutton5 = Color.fromARGB(250, 58, 165, 117);
                      Colorbutton6 = Color.fromARGB(250, 58, 165, 117);
                      TextColorButton6 = Color.fromARGB(255, 255, 255, 255);

                      TextColorButton2 = Color.fromARGB(250, 58, 165, 117);
                      TextColorButton1 = Color.fromARGB(255, 255, 255, 255);
                      TextColorButton3 = Color.fromARGB(255, 255, 255, 255);
                      TextColorButton4 = Color.fromARGB(255, 255, 255, 255);
                      TextColorButton5 = Color.fromARGB(255, 255, 255, 255);
                    });
                  },
                  child: Text(
                    "عمليات التحويل ",
                    style: TextStyle(
                        color: TextColorButton2, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: width * 0.02,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colorbutton3),
                  onPressed: () {
                    model.sortbyreciver('شحن');

                    setState(() {
                      Colorbutton1 = Color.fromARGB(250, 58, 165, 117);
                      Colorbutton3 = Color.fromARGB(255, 217, 217, 217);
                      Colorbutton2 = Color.fromARGB(250, 58, 165, 117);
                      Colorbutton4 = Color.fromARGB(250, 58, 165, 117);
                      Colorbutton5 = Color.fromARGB(250, 58, 165, 117);
                      Colorbutton6 = Color.fromARGB(250, 58, 165, 117);

                      TextColorButton6 = Color.fromARGB(255, 255, 255, 255);

                      TextColorButton3 = Color.fromARGB(250, 58, 165, 117);
                      TextColorButton2 = Color.fromARGB(255, 255, 255, 255);
                      TextColorButton1 = Color.fromARGB(255, 255, 255, 255);
                      TextColorButton4 = Color.fromARGB(255, 255, 255, 255);
                      TextColorButton5 = Color.fromARGB(255, 255, 255, 255);
                    });
                  },
                  child: Text(
                    "عمليات الشحن ",
                    style: TextStyle(
                        color: TextColorButton3, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: width * 0.02,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colorbutton4),
                  onPressed: () {
                    model.sortbysender('دفع المتجر');

                    setState(() {
                      Colorbutton1 = Color.fromARGB(250, 58, 165, 117);
                      Colorbutton4 = Color.fromARGB(255, 217, 217, 217);
                      Colorbutton3 = Color.fromARGB(250, 58, 165, 117);
                      Colorbutton2 = Color.fromARGB(250, 58, 165, 117);
                      Colorbutton5 = Color.fromARGB(250, 58, 165, 117);
                      Colorbutton6 = Color.fromARGB(250, 58, 165, 117);

                      TextColorButton6 = Color.fromARGB(255, 255, 255, 255);

                      TextColorButton4 = Color.fromARGB(250, 58, 165, 117);
                      TextColorButton2 = Color.fromARGB(255, 255, 255, 255);
                      TextColorButton3 = Color.fromARGB(255, 255, 255, 255);
                      TextColorButton1 = Color.fromARGB(255, 255, 255, 255);
                      TextColorButton5 = Color.fromARGB(255, 255, 255, 255);
                    });
                  },
                  child: Text(
                    "عمليات الدفع للمتاجر",
                    style: TextStyle(
                        color: TextColorButton4, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: width * 0.02,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colorbutton5),
                  onPressed: () {
                    model.sortbyreciver('استلام رصيد');

                    setState(() {
                      Colorbutton1 = Color.fromARGB(250, 58, 165, 117);
                      Colorbutton5 = Color.fromARGB(255, 217, 217, 217);
                      Colorbutton3 = Color.fromARGB(250, 58, 165, 117);
                      Colorbutton4 = Color.fromARGB(250, 58, 165, 117);
                      Colorbutton2 = Color.fromARGB(250, 58, 165, 117);
                      Colorbutton6 = Color.fromARGB(250, 58, 165, 117);

                      TextColorButton6 = Color.fromARGB(255, 255, 255, 255);

                      TextColorButton5 = Color.fromARGB(250, 58, 165, 117);
                      TextColorButton2 = Color.fromARGB(255, 255, 255, 255);
                      TextColorButton3 = Color.fromARGB(255, 255, 255, 255);
                      TextColorButton4 = Color.fromARGB(255, 255, 255, 255);
                      TextColorButton1 = Color.fromARGB(255, 255, 255, 255);
                    });
                  },
                  child: Text(
                    "عمليات استلام الرصيد ",
                    style: TextStyle(
                        color: TextColorButton5, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: width * 0.02,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colorbutton6),
                  onPressed: () {
                    model.sortbysender('سحب');

                    setState(() {
                      Colorbutton1 = Color.fromARGB(250, 58, 165, 117);
                      Colorbutton6 = Color.fromARGB(255, 217, 217, 217);
                      Colorbutton3 = Color.fromARGB(250, 58, 165, 117);
                      Colorbutton4 = Color.fromARGB(250, 58, 165, 117);
                      Colorbutton2 = Color.fromARGB(250, 58, 165, 117);
                      Colorbutton5 = Color.fromARGB(250, 58, 165, 117);

                      TextColorButton6 = Color.fromARGB(250, 58, 165, 117);
                      TextColorButton2 = Color.fromARGB(255, 255, 255, 255);
                      TextColorButton3 = Color.fromARGB(255, 255, 255, 255);
                      TextColorButton4 = Color.fromARGB(255, 255, 255, 255);
                      TextColorButton1 = Color.fromARGB(255, 255, 255, 255);
                      TextColorButton5 = Color.fromARGB(255, 255, 255, 255);
                    });
                  },
                  child: Text(
                    "عمليات السحب",
                    style: TextStyle(
                        color: TextColorButton6, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: width * 0.02,
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DropdownButton(
                  value: selectedValue1,
                  onChanged: (String? newValue) {
                    model.sortforDate(newValue);
                    setState(() {
                      selectedValue1 = newValue!;
                      print(selectedValue1);
                    });
                  },
                  items: dropdownItems),
              DropdownButton(
                  value: selectedValue2,
                  onChanged: (String? newValue) {
                    model.sortforamountvalue(newValue);

                    setState(() {
                      selectedValue2 = newValue!;
                    });
                  },
                  items: dropdownItems2),
            ],
          ),
        ),
        Container(
          width: width,
          child: model.data == null
              ? Center(
                  child: Lottie.asset('./assets/one.json'),
                )
              : Theme(
                  data: Theme.of(context).copyWith(
                      cardColor: Color.fromARGB(255, 217, 217, 217),
                      dividerColor: Color.fromARGB(250, 58, 165, 117)),
                  child: PaginatedDataTable(
                    arrowHeadColor: Color.fromARGB(250, 58, 165, 117),
                    columns: [
                      DataColumn(
                          label: Text(
                        "التاريخ والوقت",
                        style:
                            TextStyle(color: Color.fromARGB(250, 58, 165, 117)),
                      )),
                      DataColumn(
                          label: Text(
                        "قيمة التحويل",
                        style:
                            TextStyle(color: Color.fromARGB(250, 58, 165, 117)),
                      )),
                      DataColumn(
                          label: Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.04),
                        child: Text(
                          "نوع النشاط",
                          style: TextStyle(
                              color: Color.fromARGB(250, 58, 165, 117)),
                        ),
                      )),
                    ],
                    source: _data,
                    rowsPerPage: 5,
                    columnSpacing: 20,
                    horizontalMargin: width * 0.03,
                    dataRowHeight: height * 0.092,
                  ),
                ),
        )
      ],
    );
  }
}

var model;

class MyData extends DataTableSource {
  var context;
  MyData(context) {
    this.context = context;
    model = Provider.of<tab2model>(context, listen: true);
  }

  @override
  DataRow? getRow(int index) {
    return DataRow(cells: [
      DataCell(Container(
        width: MediaQuery.of(context).size.width * 0.2,
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.005,
            ),
            Text(model.data[index]['date'].toString()),
            Text(model.data[index]['time'].toString()),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.015,
            ),
            Text(model.data[index]['status'].toString()),
          ],
        ),
      )),
      DataCell(Container(
          width: MediaQuery.of(context).size.width * 0.3,
          child: Text(model.data[index]['price'].toString()))),
      DataCell(Container(
        width: MediaQuery.of(context).size.width * 0.3,
        child: Column(
          children: [
            Text(model.data[index]['title'].toString()),
            Expanded(
              child: Text(
                model.data[index]['title2'].toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.03),
              ),
            )
          ],
        ),
      )),
    ]);
  }

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // TODO: implement rowCount
  int get rowCount => model.data.length;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;
}
