import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:wepay/Pages.dart';
import 'package:wepay/model/pages.dart';
import '../BudgetMangment/Bar-Chart-Method.dart';

List<BarChartModel> data = [];
var userID;

class budgetmanage with ChangeNotifier {
  List<int> financialdata = List.filled(12, 0);
  List<int> financialdata2 = List.filled(31, 0);
  List<int> financialdata3 = List.filled(24, 0);
  var months = [
    "Jan",
    "Feb",
    "Mar",
    "April",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Act",
    "Nov",
    "Dec"
  ];
  List<charts.Series<BarChartModel, String>> series = [
    charts.Series(
      id: "financial",
      data: data,
      domainFn: (BarChartModel series, _) => series.Year,
      measureFn: (BarChartModel series, _) => series.financial,
      colorFn: (BarChartModel series, _) => series.color,
    ),
  ];
  var totalIncome = 0, Balance = 0, totalPayment = 0;
  var lastActivities;
  var lastPayments;
  var userid;
  var radiovalue = "no";

  Future addPayment(paymentType, paymentValue, paymentDate, paymentInfo,
      paymentForCode, context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    final url = Uri.parse(
        'https://wepay-ali-aldayoub.onrender.com/api/v1.0/payment/addPayment');
    try {
      final response = await http.post(
        url,
        headers: {'Authorization': 'Bearer $token'},
        body: {
          'paymentType': paymentType,
          'paymentValue': paymentValue,
          'paymentDate': paymentDate,
          'paymentInfo': paymentInfo,
          'isPayable': radiovalue == "yes" ? "1" : "0",
          'isMonthlyPayable': paymentType == "قسط شهري" ? "1" : "0",
          if (radiovalue == "yes") 'paymentForCode': paymentForCode,
        },
      );
      if (response.statusCode == 201) {
        // print(budgetmanage2.lastPayments);
        print("////////////////////////////////////////////");

        lastPayments = jsonDecode(response.body)['lastPayments'];
        // print(budgetmanage2.lastPayments);
        // budgetmanage2.getDashboard(context);
        var Snack = SnackBar(
            content: Container(
          child: Text(
            "تمت الإضافة",
            style: TextStyle(color: Colors.red),
          ),
        ));
        ScaffoldMessenger.of(context).showSnackBar(Snack);
        notifyListeners();
        Navigator.pop(context);
      } else {
        String msg = jsonDecode(response.body)['message'];
        var Snack = SnackBar(
            content: Container(
          child: Text(
            msg,
            style: TextStyle(color: Colors.red),
          ),
        ));
        ScaffoldMessenger.of(context).showSnackBar(Snack);
      }
    } catch (error) {
      QuickAlert.show(
        animType: QuickAlertAnimType.slideInDown,
        widget: Lottie.asset('./assets/failed.json',
            width: MediaQuery.of(context).size.width * 0.7,
            height: MediaQuery.of(context).size.height * 0.07),
        confirmBtnText: 'حسناً',
        confirmBtnColor: Colors.red,
        context: context,
        type: QuickAlertType.error,
        title: 'عذراً',
        titleColor: Color.fromARGB(255, 190, 49, 38),
        text: '${error}',
      );
    }
    notifyListeners();
  }

  void getDashboard(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    final url = await Uri.parse(
        'https://wepay-ali-aldayoub.onrender.com/api/v1.0/transaction/getDashboard');

    try {
      var response =
          await http.get(url, headers: {'Authorization': 'Bearer $token'});

      if (response.statusCode == 200) {
        Map<String, dynamic> info = await jsonDecode(response.body);
        lastActivities = info["lastActivities"];
        lastPayments = info["lastPayments"];

        totalIncome = info['user']['totalIncome'];
        userID = info["user"]["_id"];
        userid = info["user"]["_id"];
        Balance = info['user']['Balance'];
        totalPayment = info['user']['totalPayment'];
        data.clear();
        for (int i = 0; i < months.length; i++) {
          data.add(
            BarChartModel(
                Year: months[i],
                financial: 0,
                color: charts.ColorUtil.fromDartColor(
                    Color.fromARGB(250, 58, 165, 117))),
          );
        }

        for (final item in info['chartData']) {
          data[item['_id'] - 1].financial = item['totalAmount'];
        }
        if (data != null)
          series = [
            charts.Series(
              id: "financial",
              data: data,
              domainFn: (BarChartModel series, _) => series.Year,
              measureFn: (BarChartModel series, _) => series.financial,
              colorFn: (BarChartModel series, _) => series.color,
            ),
          ];
        notifyListeners();
      } else {
        String msg = jsonDecode(response.body)['message'];
        QuickAlert.show(
          confirmBtnText: 'حسناً',
          confirmBtnColor: Color.fromARGB(255, 69, 151, 110),
          context: context,
          type: QuickAlertType.error,
          title: 'عذراً',
          titleColor: Colors.red,
          text: 'نعتذر منك , $msg',
        );
      }
    } catch (error) {
      QuickAlert.show(
        animType: QuickAlertAnimType.slideInDown,
        widget: Lottie.asset('./assets/failed.json',
            width: MediaQuery.of(context).size.width * 0.7,
            height: MediaQuery.of(context).size.height * 0.07),
        confirmBtnText: 'حسناً',
        confirmBtnColor: Colors.red,
        context: context,
        type: QuickAlertType.error,
        title: 'عذراً',
        titleColor: Color.fromARGB(255, 190, 49, 38),
        text: 'نعتذر منك ',
      );
    }
    notifyListeners();
  }

  void getDaysChart(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    final url = await Uri.parse(
        'https://wepay-ali-aldayoub.onrender.com/api/v1.0/transaction/getDaysChart');

    try {
      var response =
          await http.get(url, headers: {'Authorization': 'Bearer $token'});

      if (response.statusCode == 200) {
        Map<String, dynamic> info = await jsonDecode(response.body);
        final daysInMonth =
            DateTime(DateTime.now().year, DateTime.now().month + 1, 0).day;
        data.clear();
        for (int i = 0; i < daysInMonth; i++) {
          data.add(
            BarChartModel(
                Year: '${i + 1}',
                financial: 0,
                color: charts.ColorUtil.fromDartColor(
                    Color.fromARGB(250, 58, 165, 117))),
          );
        }
        for (final item in info['chartData']) {
          data[item['_id'] - 1].financial = item['totalAmount'];
        }
        series = [
          charts.Series(
            id: "financial",
            data: data,
            domainFn: (BarChartModel series, _) => series.Year,
            measureFn: (BarChartModel series, _) => series.financial,
            colorFn: (BarChartModel series, _) => series.color,
          ),
        ];
        notifyListeners();
      } else {
        String msg = jsonDecode(response.body)['message'];
        QuickAlert.show(
          confirmBtnText: 'حسناً',
          confirmBtnColor: Color.fromARGB(255, 69, 151, 110),
          context: context,
          type: QuickAlertType.error,
          title: 'عذراً',
          titleColor: Colors.red,
          text: 'نعتذر منك , $msg',
        );
      }
    } catch (error) {
      QuickAlert.show(
        animType: QuickAlertAnimType.slideInDown,
        widget: Lottie.asset('./assets/failed.json',
            width: MediaQuery.of(context).size.width * 0.7,
            height: MediaQuery.of(context).size.height * 0.07),
        confirmBtnText: 'حسناً',
        confirmBtnColor: Colors.red,
        context: context,
        type: QuickAlertType.error,
        title: 'عذراً',
        titleColor: Color.fromARGB(255, 190, 49, 38),
        text: 'نعتذر منك',
      );
    }
    notifyListeners();
  }

  void getHoursChart(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    final url = await Uri.parse(
        'https://wepay-ali-aldayoub.onrender.com/api/v1.0/transaction/getHoursChart');

    try {
      var response =
          await http.get(url, headers: {'Authorization': 'Bearer $token'});

      if (response.statusCode == 200) {
        Map<String, dynamic> info = await jsonDecode(response.body);
        data.clear();
        for (int i = 0; i < 24; i++) {
          data.add(
            BarChartModel(
                Year: '${i + 1}',
                financial: 0,
                color: charts.ColorUtil.fromDartColor(
                    Color.fromARGB(250, 58, 165, 117))),
          );
        }
        for (final item in info['chartData']) {
          if (item['_id'] - 1 + 3 > 24)
            data[item['_id'] - 1 + 3 - 24].financial = item['totalAmount'];
          else
            data[item['_id'] - 1 + 3].financial = item['totalAmount'];
        }
        series = [
          charts.Series(
            id: "financial",
            data: data,
            domainFn: (BarChartModel series, _) => series.Year,
            measureFn: (BarChartModel series, _) => series.financial,
            colorFn: (BarChartModel series, _) => series.color,
          ),
        ];
        notifyListeners();
      } else {
        String msg = jsonDecode(response.body)['message'];
        QuickAlert.show(
          confirmBtnText: 'حسناً',
          confirmBtnColor: Color.fromARGB(255, 69, 151, 110),
          context: context,
          type: QuickAlertType.error,
          title: 'عذراً',
          titleColor: Colors.red,
          text: 'نعتذر منك , $msg',
        );
      }
    } catch (error) {
      QuickAlert.show(
        animType: QuickAlertAnimType.slideInDown,
        widget: Lottie.asset('./assets/failed.json',
            width: MediaQuery.of(context).size.width * 0.7,
            height: MediaQuery.of(context).size.height * 0.07),
        confirmBtnText: 'حسناً',
        confirmBtnColor: Colors.red,
        context: context,
        type: QuickAlertType.error,
        title: 'عذراً',
        titleColor: Color.fromARGB(255, 190, 49, 38),
        text: 'نعتذر منك',
      );
    }
    notifyListeners();
  }

  notifyListeners();
}

class tab2model with ChangeNotifier {
  var dataForTab2;
  var x = 1;
  var data, data2, dataForTab;
  void fetchData(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    final url = await Uri.parse(
        'https://wepay-ali-aldayoub.onrender.com/api/v1.0/transaction/getActions');

    try {
      var response =
          await http.get(url, headers: {'Authorization': 'Bearer $token'});

      if (response.statusCode == 200) {
        Map<String, dynamic> info = await jsonDecode(response.body);
        dataForTab2 = info['data'];
        print(info['data']);
        dataForTab = dataForTab2;
        if (dataForTab2 != null)
          data = List.generate(
              dataForTab2.length,
              (index) => {
                    "title": dataForTab2[index]["sender"] == userID
                        ? "${dataForTab2?[index]['senderAction']}"
                        : "${dataForTab2?[index]['reciverAction']}",
                    "title2": dataForTab2[index]["sender"] == userID
                        ? "${dataForTab2?[index]['senderDetails']}"
                        : "${dataForTab2?[index]['reciverDetails']}",
                    "price": "${dataForTab2?[index]['amountValue']} SYP",
                    "date":
                        "${DateTime.parse(dataForTab2[index]['createdAt']).year}/${DateTime.parse(dataForTab2[index]['createdAt']).month}/${DateTime.parse(dataForTab2[index]['createdAt']).day}",
                    "time":
                        "${DateTime.parse(dataForTab2[index]['createdAt']).hour}:${DateTime.parse(dataForTab2[index]['createdAt']).minute}",
                    "status": dataForTab2[index]['status']
                        ? "تمت المعالجة"
                        : "قيد المعالجة"
                  });
        data2 = data;
        notifyListeners();
      } else {
        String msg = jsonDecode(response.body)['message'];
        QuickAlert.show(
          confirmBtnText: 'حسناً',
          confirmBtnColor: Color.fromARGB(255, 69, 151, 110),
          context: context,
          type: QuickAlertType.error,
          title: 'عذراً',
          titleColor: Colors.red,
          text: 'نعتذر منك , $msg',
        );
      }
    } catch (error) {
      QuickAlert.show(
        animType: QuickAlertAnimType.slideInDown,
        widget: Lottie.asset('./assets/failed.json',
            width: MediaQuery.of(context).size.width * 0.7,
            height: MediaQuery.of(context).size.height * 0.07),
        confirmBtnText: 'حسناً',
        confirmBtnColor: Colors.red,
        context: context,
        type: QuickAlertType.error,
        title: 'عذراً',
        titleColor: Color.fromARGB(255, 190, 49, 38),
        text: 'نعتذر منك',
      );
    }
    notifyListeners();
  }

  void sortbysender(name) {
    dataForTab2 = dataForTab;
    var result = [];
    print(dataForTab2);
    for (var index in dataForTab2) {
      if (index['senderAction'] == name && userID == index["sender"])
        result.add(index);
    }
    dataForTab2 = result;
    print(dataForTab2);
    data = List.generate(
        dataForTab2.length,
        (index) => {
              "title": dataForTab2[index]["sender"] == userID
                  ? "${dataForTab2?[index]['senderAction']}"
                  : "${dataForTab2?[index]['reciverAction']}",
              "title2": dataForTab2[index]["sender"] == userID
                  ? "${dataForTab2?[index]['senderDetails']}"
                  : "${dataForTab2?[index]['reciverDetails']}",
              "price": "${dataForTab2?[index]['amountValue']} SYP",
              "date":
                  "${DateTime.parse(dataForTab2[index]['createdAt']).year}/${DateTime.parse(dataForTab2[index]['createdAt']).month}/${DateTime.parse(dataForTab2[index]['createdAt']).day}",
              "time":
                  "${DateTime.parse(dataForTab2[index]['createdAt']).hour}:${DateTime.parse(dataForTab2[index]['createdAt']).minute}",
              "status":
                  dataForTab2[index]['status'] ? "تمت المعالجة" : "قيد المعالجة"
            });
    notifyListeners();
  }

  void sortbyreciver(name) {
    dataForTab2 = dataForTab;
    var result = [];
    print(dataForTab2);
    for (var index in dataForTab2) {
      if (index['reciverAction'] == name && userID == index["reciver"])
        result.add(index);
    }
    dataForTab2 = result;
    print(dataForTab2);
    data = List.generate(
        dataForTab2.length,
        (index) => {
              "title": dataForTab2[index]["sender"] == userID
                  ? "${dataForTab2?[index]['senderAction']}"
                  : "${dataForTab2?[index]['reciverAction']}",
              "title2": dataForTab2[index]["sender"] == userID
                  ? "${dataForTab2?[index]['senderDetails']}"
                  : "${dataForTab2?[index]['reciverDetails']}",
              "price": "${dataForTab2?[index]['amountValue']} SYP",
              "date":
                  "${DateTime.parse(dataForTab2[index]['createdAt']).year}/${DateTime.parse(dataForTab2[index]['createdAt']).month}/${DateTime.parse(dataForTab2[index]['createdAt']).day}",
              "time":
                  "${DateTime.parse(dataForTab2[index]['createdAt']).hour}:${DateTime.parse(dataForTab2[index]['createdAt']).minute}",
              "status":
                  dataForTab2[index]['status'] ? "تمت المعالجة" : "قيد المعالجة"
            });
    notifyListeners();
  }

  void alloperations() {
    data = data2;
    notifyListeners();
  }

  void sortforamountvalue(value) {
    // dataForTab2.sort((a, b) => a.amountValue - b.amountValue);
    if (value == 'CTE') {
      for (var i = 0; i < dataForTab2.length - 1; i++) {
        for (var j = 0; j < dataForTab2.length - i - 1; j++) {
          if (dataForTab2[j]['amountValue'] >
              dataForTab2[j + 1]['amountValue']) {
            var temp = dataForTab2[j];
            dataForTab2[j] = dataForTab2[j + 1];
            dataForTab2[j + 1] = temp;
            notifyListeners();
          } else if (dataForTab2[j]['amountValue'] ==
              dataForTab2[j + 1]['amountValue']) {
            var temp = dataForTab2[j];
            dataForTab2[j] = dataForTab2[j + 1];
            dataForTab2[j + 1] = temp;
            notifyListeners();
          }
        }
      }
      notifyListeners();
    }
    if (value == 'ETC') {
      for (var i = 0; i < dataForTab2.length - 1; i++) {
        for (var j = 0; j < dataForTab2.length - i - 1; j++) {
          if (dataForTab2[j]['amountValue'] <
              dataForTab2[j + 1]['amountValue']) {
            var temp = dataForTab2[j];
            dataForTab2[j] = dataForTab2[j + 1];
            dataForTab2[j + 1] = temp;
            notifyListeners();
          } else if (dataForTab2[j]['amountValue'] ==
              dataForTab2[j + 1]['amountValue']) {
            var temp = dataForTab2[j];
            dataForTab2[j] = dataForTab2[j + 1];
            dataForTab2[j + 1] = temp;
            notifyListeners();
          }
        }
      }
      notifyListeners();
    }
    // dataForTab2.sortBy((item) => item['amountValue']);
    // dataForTab2.sort((a, b) => b['amountValue'].compareTo(a['amountValue']));
    data = List.generate(
        dataForTab2.length,
        (index) => {
              "title": dataForTab2[index]["sender"] == userID
                  ? "${dataForTab2?[index]['senderAction']}"
                  : "${dataForTab2?[index]['reciverAction']}",
              "title2": dataForTab2[index]["sender"] == userID
                  ? "${dataForTab2?[index]['senderDetails']}"
                  : "${dataForTab2?[index]['reciverDetails']}",
              "price": "${dataForTab2?[index]['amountValue']} SYP",
              "date":
                  "${DateTime.parse(dataForTab2[index]['createdAt']).year}/${DateTime.parse(dataForTab2[index]['createdAt']).month}/${DateTime.parse(dataForTab2[index]['createdAt']).day}",
              "time":
                  "${DateTime.parse(dataForTab2[index]['createdAt']).hour}:${DateTime.parse(dataForTab2[index]['createdAt']).minute}",
              "status":
                  dataForTab2[index]['status'] ? "تمت المعالجة" : "قيد المعالجة"
            });
    notifyListeners();
  }

  void sortforDate(value) {
    // dataForTab2.sort((a, b) => a.amountValue - b.amountValue);
    if (value == 'NTO') {
      for (var i = 0; i < dataForTab2.length - 1; i++) {
        var isSorted = true;
        for (var j = 0; j < dataForTab2.length - i - 1; j++) {
          if (DateTime.parse(dataForTab2[j]['createdAt'])
                  .compareTo(DateTime.parse(dataForTab2[j + 1]['createdAt'])) <
              0) {
            // Change ">" to "<"
            var temp = dataForTab2[j];
            dataForTab2[j] = dataForTab2[j + 1];
            dataForTab2[j + 1] = temp;
            isSorted = false;
          }
        }
        if (isSorted) break;
      }
    }
    if (value == 'OTN') {
      for (var i = 0; i < dataForTab2.length - 1; i++) {
        var isSorted = true;
        for (var j = 0; j < dataForTab2.length - i - 1; j++) {
          if (DateTime.parse(dataForTab2[j]['createdAt'])
                  .compareTo(DateTime.parse(dataForTab2[j + 1]['createdAt'])) >
              0) {
            var temp = dataForTab2[j];
            dataForTab2[j] = dataForTab2[j + 1];
            dataForTab2[j + 1] = temp;
            isSorted = false;
          }
        }
        if (isSorted) break;
      }
    }
    // dataForTab2.sortBy((item) => item['amountValue']);
    // dataForTab2.sort((a, b) => b['amountValue'].compareTo(a['amountValue']));
    data = List.generate(
        dataForTab2.length,
        (index) => {
              "title": dataForTab2[index]["sender"] == userID
                  ? "${dataForTab2?[index]['senderAction']}"
                  : "${dataForTab2?[index]['reciverAction']}",
              "title2": dataForTab2[index]["sender"] == userID
                  ? "${dataForTab2?[index]['senderDetails']}"
                  : "${dataForTab2?[index]['reciverDetails']}",
              "price": "${dataForTab2?[index]['amountValue']} SYP",
              "date":
                  "${DateTime.parse(dataForTab2[index]['createdAt']).year}/${DateTime.parse(dataForTab2[index]['createdAt']).month}/${DateTime.parse(dataForTab2[index]['createdAt']).day}",
              "time":
                  "${DateTime.parse(dataForTab2[index]['createdAt']).hour}:${DateTime.parse(dataForTab2[index]['createdAt']).minute}",
              "status":
                  dataForTab2[index]['status'] ? "تمت المعالجة" : "قيد المعالجة"
            });
    notifyListeners();
  }

  notifyListeners();
}

class tab3model with ChangeNotifier {
  Future payNow(id, context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    final url = Uri.parse(
        'https://wepay-ali-aldayoub.onrender.com/api/v1.0/payment/payNow/${id}');
    try {
      final response = await http.put(
        url,
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        final budgetmanage2 = Provider.of<budgetmanage>(context, listen: false);
        budgetmanage2.getDashboard(context);
        fetchData(context);
        var Snack = SnackBar(
            content: Container(
          child: Text(
            "تمت الدفع",
            style: TextStyle(color: Colors.red),
          ),
        ));
        ScaffoldMessenger.of(context).showSnackBar(Snack);
        notifyListeners();
      } else {
        String msg = jsonDecode(response.body)['message'];
        print(msg);
        var Snack = SnackBar(
            content: Container(
          child: Text(
            msg,
            style: TextStyle(color: Colors.red),
          ),
        ));
        ScaffoldMessenger.of(context).showSnackBar(Snack);
      }
    } catch (error) {
      QuickAlert.show(
        animType: QuickAlertAnimType.slideInDown,
        widget: Lottie.asset('./assets/failed.json',
            width: MediaQuery.of(context).size.width * 0.7,
            height: MediaQuery.of(context).size.height * 0.07),
        confirmBtnText: 'حسناً',
        confirmBtnColor: Colors.red,
        context: context,
        type: QuickAlertType.error,
        title: 'عذراً',
        titleColor: Color.fromARGB(255, 190, 49, 38),
        text: '${error}',
      );
    }
    notifyListeners();
  }

  Future DeletePayment(paymentId, context) async {
    print(paymentId);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    final url = Uri.parse(
        'https://wepay-ali-aldayoub.onrender.com/api/v1.0/payment/deletePayment/${paymentId}');
    try {
      final response = await http.delete(
        url,
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        fetchData(context);
        final budgetmanage2 = Provider.of<budgetmanage>(context, listen: false);
        budgetmanage2.getDashboard(context);
        notifyListeners();
        var Snack = SnackBar(
            content: Container(
          child: Text(
            "تم حذف العنصر",
            style: TextStyle(color: Colors.red),
          ),
        ));
        ScaffoldMessenger.of(context).showSnackBar(Snack);
      } else {
        String msg = jsonDecode(response.body)['message'];
        var Snack = SnackBar(
            content: Container(
          child: Text(
            msg,
            style: TextStyle(color: Colors.red),
          ),
        ));
        ScaffoldMessenger.of(context).showSnackBar(Snack);
      }
    } catch (error) {
      print(error);
      QuickAlert.show(
        animType: QuickAlertAnimType.slideInDown,
        widget: Lottie.asset('./assets/failed.json',
            width: MediaQuery.of(context).size.width * 0.7,
            height: MediaQuery.of(context).size.height * 0.07),
        confirmBtnText: 'حسناً',
        confirmBtnColor: Colors.red,
        context: context,
        type: QuickAlertType.error,
        title: 'عذراً',
        titleColor: Color.fromARGB(255, 190, 49, 38),
        text: '${error}',
      );
    }
    notifyListeners();
  }

  var datafortab3;
  var data;
  var dataforpage = [];

  List<List<dynamic>> result = [];

  void fetchData(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    final url = await Uri.parse(
        'https://wepay-ali-aldayoub.onrender.com/api/v1.0/payment/getAllPayments');

    try {
      var response =
          await http.get(url, headers: {'Authorization': 'Bearer $token'});

      if (response.statusCode == 200) {
        result = [];
        Map<String, dynamic> info = await jsonDecode(response.body);
        datafortab3 = info['data'];
        data = info['data'];
        if (data != null)
          for (int i = 0; i < data.length; i += 3) {
            List<dynamic> block = [];

            for (int j = 0; j < 3 && i + j < data.length; j++) {
              block.add(data[i + j]);
            }

            result.add(block);
          }
        print(result);
        notifyListeners();
      } else {
        String msg = jsonDecode(response.body)['message'];
        QuickAlert.show(
          confirmBtnText: 'حسناً',
          confirmBtnColor: Color.fromARGB(255, 69, 151, 110),
          context: context,
          type: QuickAlertType.error,
          title: 'عذراً',
          titleColor: Colors.red,
          text: 'نعتذر منك , $msg',
        );
      }
    } catch (error) {
      QuickAlert.show(
        animType: QuickAlertAnimType.slideInDown,
        widget: Lottie.asset('./assets/failed.json',
            width: MediaQuery.of(context).size.width * 0.7,
            height: MediaQuery.of(context).size.height * 0.07),
        confirmBtnText: 'حسناً',
        confirmBtnColor: Colors.red,
        context: context,
        type: QuickAlertType.error,
        title: 'عذراً',
        titleColor: Color.fromARGB(255, 190, 49, 38),
        text: '${error} ',
      );
    }
    notifyListeners();
  }

  void sort(name) {
    if (name == "all") {
      data = datafortab3;
      if (data != null) {
        result = [];
        for (int i = 0; i < data.length; i += 3) {
          List<dynamic> block = [];

          for (int j = 0; j < 3 && i + j < data.length; j++) {
            block.add(data[i + j]);
          }

          result.add(block);
        }
      }
    } else {
      data = datafortab3;
      var result2 = [];
      for (var index in data) {
        if (index['paymentType'] == name) result2.add(index);
      }
      data = result2;
      print(data);
      print("///////");
      if (data != null) {
        result = [];
        for (int i = 0; i < data.length; i += 3) {
          List<dynamic> block = [];

          for (int j = 0; j < 3 && i + j < data.length; j++) {
            block.add(data[i + j]);
          }

          result.add(block);
        }
      }
      print(result);
    }
    notifyListeners();
  }

  void sortByPrice(value) {
    data = datafortab3;
    if (value == 'CTE') {
      for (var i = 0; i < data.length - 1; i++) {
        for (var j = 0; j < data.length - i - 1; j++) {
          if (data[j]['paymentValue'] > data[j + 1]['paymentValue']) {
            var temp = data[j];
            data[j] = data[j + 1];
            data[j + 1] = temp;
            notifyListeners();
          } else if (data[j]['paymentValue'] == data[j + 1]['paymentValue']) {
            var temp = data[j];
            data[j] = data[j + 1];
            data[j + 1] = temp;
            notifyListeners();
          }
        }
      }
      notifyListeners();
    }
    if (value == 'ETC') {
      for (var i = 0; i < data.length - 1; i++) {
        for (var j = 0; j < data.length - i - 1; j++) {
          if (data[j]['paymentValue'] < data[j + 1]['paymentValue']) {
            var temp = data[j];
            data[j] = data[j + 1];
            data[j + 1] = temp;
            notifyListeners();
          } else if (data[j]['paymentValue'] == data[j + 1]['paymentValue']) {
            var temp = data[j];
            data[j] = data[j + 1];
            data[j + 1] = temp;
            notifyListeners();
          }
        }
      }
    }
    if (data != null) {
      result = [];
      for (int i = 0; i < data.length; i += 3) {
        List<dynamic> block = [];

        for (int j = 0; j < 3 && i + j < data.length; j++) {
          block.add(data[i + j]);
        }

        result.add(block);
      }
    }
    notifyListeners();
  }

  void sortByDate(value) {
    data = datafortab3;
    if (value == 'NTO') {
      for (var i = 0; i < data.length - 1; i++) {
        var isSorted = true;
        for (var j = 0; j < data.length - i - 1; j++) {
          if (DateTime.parse(data[j]['paymentDate'])
                  .compareTo(DateTime.parse(data[j + 1]['paymentDate'])) <
              0) {
            var temp = data[j];
            data[j] = data[j + 1];
            data[j + 1] = temp;
            isSorted = false;
          }
        }
        if (isSorted) break;
      }
    }
    if (value == 'OTN') {
      for (var i = 0; i < data.length - 1; i++) {
        var isSorted = true;
        for (var j = 0; j < data.length - i - 1; j++) {
          if (DateTime.parse(data[j]['paymentDate'])
                  .compareTo(DateTime.parse(data[j + 1]['paymentDate'])) >
              0) {
            var temp = data[j];
            data[j] = data[j + 1];
            data[j + 1] = temp;
            isSorted = false;
          }
        }
        if (isSorted) break;
      }
    }
    if (data != null) {
      result = [];
      for (int i = 0; i < data.length; i += 3) {
        List<dynamic> block = [];

        for (int j = 0; j < 3 && i + j < data.length; j++) {
          block.add(data[i + j]);
        }

        result.add(block);
      }
    }
    notifyListeners();
  }

  notifyListeners();
}
