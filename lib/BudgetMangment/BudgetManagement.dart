import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wepay/BudgetMangment/Bar-Chart-Method.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:wepay/BudgetMangment/Tab1.dart';
import 'package:wepay/BudgetMangment/Tab2.dart';
import 'package:wepay/BudgetMangment/Tab3.dart';
import 'package:wepay/model/Budgetmangment.dart';

class BudgetManagment extends StatefulWidget {
  const BudgetManagment({super.key});

  @override
  State<BudgetManagment> createState() => _BudgetManagmentState();
}

class _BudgetManagmentState extends State<BudgetManagment>
    with TickerProviderStateMixin {
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("السنة"), value: "year"),
      DropdownMenuItem(child: Text("الشهر"), value: "month"),
      DropdownMenuItem(child: Text("اليوم"), value: "day"),
    ];
    return menuItems;
  }

  String selectedValue = "year";
  @override
  late TabController _tabController;

  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  int i = 0;
  Widget build(BuildContext context) {
    var model = Provider.of<budgetmanage>(context);

    if (i == 0) {
      model.getDashboard(context);
      i++;
    }

    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(top: height * 0.02, bottom: height * 0.015),
        child: Column(
          children: [
            //First Rectangle

            Container(
              margin: EdgeInsets.all(width * 0.02),
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
                  borderRadius:
                      BorderRadius.all(Radius.circular(width * 0.05))),
              width: width * 0.95,
              height: height * 0.17,
              child: Padding(
                padding: EdgeInsets.all(width * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.add_circle_sharp,
                      color: Colors.white,
                      size: width * 0.1,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: height * 0.01),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            ": إجمالي الدخل ",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: width * 0.07,
                                fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: width * 0.01),
                            child: Text(
                              "${model.totalIncome} SYP",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: width * 0.05,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            //Second Rectangle

            Container(
              margin: EdgeInsets.all(width * 0.02),
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
                  borderRadius:
                      BorderRadius.all(Radius.circular(width * 0.05))),
              width: width * 0.95,
              height: height * 0.17,
              child: Padding(
                padding: EdgeInsets.all(width * 0.02),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: height * 0.01),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        ": إجمالي الصرف",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: width * 0.07,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "${model.totalPayment} SYP",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: width * 0.05,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            //Third Rectangle

            Container(
              margin: EdgeInsets.all(width * 0.02),
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
                  borderRadius:
                      BorderRadius.all(Radius.circular(width * 0.05))),
              width: width * 0.95,
              height: height * 0.17,
              child: Padding(
                padding: EdgeInsets.all(width * 0.02),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: height * 0.01),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        " : رصيد الحساب ",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: width * 0.07,
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: width * 0.01),
                        child: Text(
                          "${model.Balance} SYP",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: width * 0.05,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Image.asset('assets/divider.png'),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.03),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DropdownButton(
                      value: selectedValue,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedValue = newValue!;
                          print(selectedValue);
                          if (selectedValue == 'month') {
                            model.getDaysChart(context);
                          } else if (selectedValue == 'year') {
                            model.getDashboard(context);
                          } else {
                            model.getHoursChart(context);
                          }
                        });
                      },
                      items: dropdownItems),
                  Text(": عرض الإحصائيات حسب "),
                ],
              ),
            ),
            //Chart Bar
            Consumer<budgetmanage>(
              builder: (context, value, child) {
                return Container(
                  width: width * 0.98,
                  height: height * 0.45,
                  child: model.series == null
                      ? CircularProgressIndicator()
                      : charts.BarChart(
                          domainAxis: new charts.OrdinalAxisSpec(
                              renderSpec: new charts.SmallTickRendererSpec(
                                  minimumPaddingBetweenLabelsPx: 0,
                                  // Tick and Label styling here.
                                  labelStyle: new charts.TextStyleSpec(
                                      fontSize: (width * 0.02)
                                          .toInt(), // size in Pts.
                                      color: charts.MaterialPalette.black),

                                  // Change the line colors to match text color.
                                  lineStyle: new charts.LineStyleSpec(
                                      color: charts.MaterialPalette.black))),

                          /// Assign a custom style for the measure axis.
                          primaryMeasureAxis: new charts.NumericAxisSpec(
                              renderSpec: new charts.GridlineRendererSpec(

                                  // Tick and Label styling here.
                                  labelStyle: new charts.TextStyleSpec(
                                      fontSize: (width * 0.02)
                                          .toInt(), // size in Pts.
                                      color: charts.MaterialPalette.black),

                                  // Change the line colors to match text color.
                                  lineStyle: new charts.LineStyleSpec(
                                      color: charts.MaterialPalette.black))),
                          // domainAxis: charts.OrdinalAxisSpec(
                          //   renderSpec: charts.SmallTickRendererSpec(
                          //     // Only show labels for even values
                          //     labelStyle: charts.TextStyleSpec(fontSize: 7),
                          //     labelAnchor: charts.TickLabelAnchor.centered,
                          //   ),
                          // ),
                          model.series,
                          animate: true,
                        ),
                );
              },
            ),
            Image.asset('assets/divider.png'),

            Text(
              "الأقسام",
              style: TextStyle(
                color: Color.fromARGB(250, 58, 165, 117),
                fontSize: width * 0.1,
                fontWeight: FontWeight.bold,
              ),
            ),

            Image.asset('assets/divider.png'),

            DefaultTabController(
              length: 3, // length of tabs
              initialIndex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    child: TabBar(
                      controller: _tabController,
                      labelPadding: EdgeInsets.only(right: width * 0),
                      labelColor: Color.fromARGB(250, 58, 165, 117),
                      unselectedLabelColor: Colors.black,
                      tabs: [
                        Tab(
                          child: Text(
                            'أهم الإحصائيات',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Tab(
                          child: Text(
                            'كل الأنشطة',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Tab(
                          child: Padding(
                            padding: EdgeInsets.only(left: width * 0.01),
                            child: Text(
                              'المدفوعات المستحقة',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: height * 0.75, //height of TabBarView
                    decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(
                                color: Colors.grey, width: width * 0.001))),
                    child: TabBarView(
                      controller: _tabController,
                      children: <Widget>[
                        Tab1(Tabstate: _tabController),
                        Tab2(),
                        Tab3(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
