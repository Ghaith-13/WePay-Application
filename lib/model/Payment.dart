import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/src/provider.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../deposit&withdraw/adminPages/rechargeAdmin.dart';
import '../deposit&withdraw/adminPages/withdrawAdmin.dart';
import '../deposit&withdraw/mainPage/FirstPage.dart';

import '../deposit&withdraw/paymentandtrans/Payment&Tran.dart';

// import '../deposit&withdraw/SyriatelWithdrawe.dart';
import '../deposit&withdraw/mainPage/LastPay.dart';
import '../deposit&withdraw/rechargeSalary/AlHaramDeposit.dart';
import '../deposit&withdraw/rechargeSalary/LastRecharge.dart';

import '../deposit&withdraw/rechargeSalary/SyriatelCash.dart';
import '../deposit&withdraw/rechargeSalary/bemoDeposit.dart';
import '../deposit&withdraw/rechargeSalary/rechargeSalary.dart';
import '../deposit&withdraw/withdrawelSalary/AlHaram.dart';
import '../deposit&withdraw/withdrawelSalary/BankBemo.dart';
import '../deposit&withdraw/withdrawelSalary/SyriatelWithdrawe.dart';
import '../deposit&withdraw/withdrawelSalary/main/LastWithdrawel.dart';
import '../deposit&withdraw/withdrawelSalary/main/withdrawelSalary.dart';

import 'package:http/http.dart' as http;

class depositandwithdraw extends ChangeNotifier {
  Widget nameOfPage = FirstPage();
  Widget nameOfPage2 = LastPay();
  int i = -1;
  int ii = -1;
  int iii = -1;
  String role = '';

  onClick(i) {
    if (i == 0) {
      i = 0;
      nameOfPage = FirstPage();
      notifyListeners();
    }
    if (i == 1) {
      i = 1;
      nameOfPage = PaymentAndTrans();
      notifyListeners();
    }
    if (i == 2) {
      print("ooo");
      i = 2;
      nameOfPage = PaymentAndTrans();
      notifyListeners();
    }
    if (i == 3) {
      print("ooo");
      i = 3;
      nameOfPage = rechargeSalary();
      notifyListeners();
    }
    if (i == 4) {
      print("ooo");
      i = 4;
      nameOfPage = SyriatelCash();
      notifyListeners();
    }
    if (i == 5) {
      i = 5;
      nameOfPage = withdrawelSalary();
      notifyListeners();
    }
    if (i == 6) {
      i = 6;
      nameOfPage = AlHaram();
      notifyListeners();
    }
    if (i == 7) {
      i = 7;
      nameOfPage = SyriatelWithdrawe();
      notifyListeners();
    }
    if (i == 8) {
      i = 8;
      nameOfPage = FirstPage();
      notifyListeners();
    }
    if (i == 9) {
      i = 9;
      nameOfPage = AlHaramDeposit();
      notifyListeners();
    }
    if (i == 10) {
      i = 10;
      nameOfPage = BankBemoWithdraw();
      notifyListeners();
    }
    if (i == 11) {
      i = 10;
      nameOfPage = bemoDeposit();
      notifyListeners();
    }
  }

  getrole() {
    return role;
  }

  onClick2(iii) {
    if (iii == 1) {
      iii = 1;
      nameOfPage2 = LastPay();
      notifyListeners();
    }
    if (iii == 2) {
      iii = 2;
      nameOfPage2 = LastRecharge();
      notifyListeners();
    }
    if (iii == 3) {
      iii = 3;
      nameOfPage2 = LastWithdrawel();
      notifyListeners();
    }
    if (iii == 4) {
      iii = 4;
      nameOfPage2 = Text("");
      notifyListeners();
    }
    if (iii == 5) {
      iii = 5;
      nameOfPage2 = rechargeAdmin();
      notifyListeners();
    }
    if (iii == 6) {
      iii = 6;
      nameOfPage2 = widthdraweAdmin();
      notifyListeners();
    }
  }

  var totalPayment = 0, totalIncome = 0, Balance = 0;
  var actions;
  var actions1;
  var actions2;
  bool isFull1 = false;
  var firstname = '', middlename = '', lastname = '';
  var phonenumber = '';
  bool isFull2=false;
  void getShipping(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    role = prefs.getString('role') ?? '';
    final url = await Uri.parse(
        'https://wepay-ali-aldayoub.onrender.com/api/v1.0/transaction/getShipping');

    try {
      var response =
          await http.get(url, headers: {'Authorization': 'Bearer $token'});
 isFull2=false;
      if (response.statusCode == 200) {
        Map<String, dynamic> info = await jsonDecode(response.body);
        var infoUser = info["user"];
        totalPayment = infoUser['totalPayment'];
        totalIncome = infoUser['totalIncome'];
        Balance = infoUser['Balance'];
        actions = info["actions"];
        print(actions);
        isFull2=true;
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

  // var Qrcode;
  // void scan() async {
  //   String barcodeScanRes;
  //   try {
  //     barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
  //         '#ff6666', 'Cancel', true, ScanMode.QR);
  //     print('///////////////////////////////////');
  //     print(barcodeScanRes);
  //     Qrcode = barcodeScanRes;
  //     notifyListeners();
  //   } on PlatformException {
  //     barcodeScanRes = 'Failed to get platform version.';
  //   }
  //   notifyListeners();
  // }

  Future<void> transferMoney(amountValue, pin, context, flag, qr) async {
    print(int.parse(amountValue));
    print(int.parse(amountValue).runtimeType);
    var qr2;
    print(pin);
    // if (flag == 1 && qr == null)
    //   qr2 = Qrcode;
    // else
    //   qr2 = qr;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    final url = Uri.parse(
        'https://wepay-ali-aldayoub.onrender.com/api/v1.0/transaction/transferMoney');
    try {
      final response = await http.post(
        url,
        headers: {'Authorization': 'Bearer $token'},
        body: {
          'amountValue': amountValue,
          'pin': pin,
          'qrcode': qr2,
        },
      );

      if (response.statusCode == 200) {
        var Snack = SnackBar(
            content: Container(
          child: Text(
            "تم التحويل",
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
  }

  Future<void> depositeRequest(
      processType, phoneNumber, amountValue, processNumber, context,
      {image = "", SenderName = '', city = ""}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    final url = Uri.parse(
        'https://wepay-ali-aldayoub.onrender.com/api/v1.0/transaction/depositRequest');
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          'https://wepay-ali-aldayoub.onrender.com/api/v1.0/transaction/depositReques'),
    );
    if (image != "") {
      http.MultipartFile imageFile =
          await http.MultipartFile.fromPath('imgURL', image);
      request.files.add(imageFile);
    }
    print(city);
    try {
      var response;
      if (image == "")
        response = await http.post(
          url,
          headers: {'Authorization': 'Bearer $token'},
          body: {
            'processType': processType,
            'processNumber': processNumber,
            'amountValue': amountValue,
            "senderPhone": phoneNumber,
          },
        );
      else
        response = await http.post(
          url,
          headers: {'Authorization': 'Bearer $token'},
          body: {
            'processType': processType,
            'processNumber': processNumber,
            'amountValue': amountValue,
            "senderPhone": phoneNumber,
            "senderName": SenderName,
            "senderCity": city
          },
        );

      if (response.statusCode == 200) {
        String msg = jsonDecode(response.body)['message'];
        var Snack = SnackBar(
            content: Container(
          child: Text(
            msg,
            style: TextStyle(color: Colors.red),
          ),
        ));
        ScaffoldMessenger.of(context).showSnackBar(Snack);
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
        text: 'نعتذر منك',
      );
    }
  }

  Future<void> depositeRequestforbemo(
      processType, SenderName, accountId, amountValue, context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    final url = Uri.parse(
        'https://wepay-ali-aldayoub.onrender.com/api/v1.0/transaction/depositRequest');

    try {
      var response;

      response = await http.post(
        url,
        headers: {'Authorization': 'Bearer $token'},
        body: {
          'processType': processType,
          'senderName': SenderName,
          'amountValue': amountValue,
          'accountID': accountId
        },
      );

      if (response.statusCode == 200) {
        String msg = jsonDecode(response.body)['message'];
        var Snack = SnackBar(
            content: Container(
          child: Text(
            msg,
            style: TextStyle(color: Colors.red),
          ),
        ));
        ScaffoldMessenger.of(context).showSnackBar(Snack);
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
        text: 'نعتذر منك',
      );
    }
  }

  var actionsForWithdraw;
  var showactions = true;
  var actionsForWithdraw1;
  var showactions1 = true;
  void getActionsForWithdraw(context, type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    print(token);
    print("///////////////");
    final url = await Uri.parse(
        'https://wepay-ali-aldayoub.onrender.com/api/v1.0/transaction/getActions?actionType=' +
            type);

    try {
      var response =
          await http.get(url, headers: {'Authorization': 'Bearer $token'});

      if (response.statusCode == 200) {
        Map<String, dynamic> info = await jsonDecode(response.body);
        // var infoUser = info["user"];
        // totalPayment = infoUser['totalPayment'];
        // totalIncome = infoUser['totalIncome'];
        // Balance = infoUser['Balance'];
        // actions = info["actions"];
        print(info);
        if (type == 'withdraw') {
          if (info['success'] == true)
            showactions = true;
          else
            showactions = false;
          actionsForWithdraw = info["data"];
          print(actionsForWithdraw);
          notifyListeners();
        } else {
          if (info['success'] == true)
            showactions1 = true;
          else
            showactions1 = false;
          actionsForWithdraw1 = info["data"];
          print(actionsForWithdraw1);
          notifyListeners();
        }
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

  Future<void> withdrawFromHaram(
      reciverName, reciverPhone, reciverCity, pin, amountvalue, context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    final url = Uri.parse(
        'https://wepay-ali-aldayoub.onrender.com/api/v1.0/transaction/withdrawRequest');
    try {
      final response = await http.post(
        url,
        headers: {'Authorization': 'Bearer $token'},
        body: {
          'reciverName': reciverName,
          'reciverPhone': reciverPhone,
          'reciverCity': reciverCity,
          'amountValue': amountvalue,
          'pin': pin,
          'processType': 'سحب-هرم',
        },
      );

      if (response.statusCode == 200) {
        var Snack = SnackBar(
            content: Container(
          child: Text(
            "تم السحب",
            style: TextStyle(color: Colors.green),
          ),
        ));
        ScaffoldMessenger.of(context).showSnackBar(Snack);
        onClick2(3);
        onClick(5);
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
        text: 'نعتذر منك',
      );
    }
  }

  Future<void> withdrawFromSyriatelCash(
      cashType, reciverPhone, pin, amountvalue, context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    print(cashType);
    print(reciverPhone);
    print(pin);
    print(amountvalue);

    final url = Uri.parse(
        'https://wepay-ali-aldayoub.onrender.com/api/v1.0/transaction/withdrawRequest');
    try {
      final response = await http.post(
        url,
        headers: {'Authorization': 'Bearer $token'},
        body: {
          'cashType': cashType,
          'reciverPhone': reciverPhone,
          'amountValue': amountvalue,
          'pin': pin,
          'processType': 'سحب-كاش',
        },
      );

      if (response.statusCode == 200) {
        var Snack = SnackBar(
            content: Container(
          child: Text(
            "تم السحب",
            style: TextStyle(color: Colors.green),
          ),
        ));
        ScaffoldMessenger.of(context).showSnackBar(Snack);
        onClick2(3);
        onClick(5);
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
        text: 'نعتذر منك',
      );
    }
  }

  Future<void> withdrawFromBankBemo(
      accountID, pin, amountvalue, context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';

    print(accountID);
    print(pin);
    print(amountvalue);

    final url = Uri.parse(
        'https://wepay-ali-aldayoub.onrender.com/api/v1.0/transaction/withdrawRequest');
    try {
      final response = await http.post(
        url,
        headers: {'Authorization': 'Bearer $token'},
        body: {
          'accountID': accountID,
          'amountValue': amountvalue,
          'pin': pin,
          'processType': 'سحب-بيمو',
        },
      );

      if (response.statusCode == 200) {
        var Snack = SnackBar(
            content: Container(
          child: Text(
            "تم السحب",
            style: TextStyle(color: Colors.green),
          ),
        ));
        ScaffoldMessenger.of(context).showSnackBar(Snack);
        onClick2(3);
        onClick(5);
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
        text: 'نعتذر منك',
      );
    }
  }

  bool isFull = false;
  void getAlldepositRequests(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    role = prefs.getString('role') ?? '';
    final url = await Uri.parse(
        'https://wepay-ali-aldayoub.onrender.com/api/v1.0/transaction/getAllDepositRequest');

    try {
      var response =
          await http.get(url, headers: {'Authorization': 'Bearer $token'});
isFull = false;
      if (response.statusCode == 200) {
        Map<String, dynamic> info = await jsonDecode(response.body);
        actions1 = info['depositRequests'];
       
      
          isFull = true;
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
        text: 'نعتذر منك $error',
      );
    }
    notifyListeners();
  }

  void depositResponse(context, String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    role = prefs.getString('role') ?? '';
    final url = await Uri.parse(
        'https://wepay-ali-aldayoub.onrender.com/api/v1.0/transaction/depositResponse/${id}');

    try {
      var response =
          await http.put(url, headers: {'Authorization': 'Bearer $token'});

      if (response.statusCode == 200) {
        Map<String, dynamic> info = await jsonDecode(response.body);
        getAlldepositRequests(context);
        print(info);

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

  void getAllWithdrawRequests(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    role = prefs.getString('role') ?? '';
    final url = await Uri.parse(
        'https://wepay-ali-aldayoub.onrender.com/api/v1.0/transaction/getAllWithdrawRequest');

    try {
      var response =
          await http.get(url, headers: {'Authorization': 'Bearer $token'});
                isFull1 = false;
      if (response.statusCode == 200) {
        Map<String, dynamic> info = await jsonDecode(response.body);
        actions2 = info['withdrawRequest'];
       
            isFull1 = true;
            notifyListeners();
          
        
        print(actions2);
        print("rounia");
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
          widget: Lottie.asset('./assets/one.json',
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height * 0.07),
          confirmBtnText: 'حسناً',
          confirmBtnColor: Colors.red,
          context: context,
          type: QuickAlertType.error,
          title: 'عذراً',
          titleColor: Color.fromARGB(255, 190, 49, 38),
          text: error.toString());
    }
    notifyListeners();
  }

  void withdrawResponse(context, String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    role = prefs.getString('role') ?? '';
    final url = await Uri.parse(
        'https://wepay-ali-aldayoub.onrender.com/api/v1.0/transaction/withdrawResponse/${id}');

    try {
      var response =
          await http.put(url, headers: {'Authorization': 'Bearer $token'});

      if (response.statusCode == 200) {
        print("kk");
        Map<String, dynamic> info = await jsonDecode(response.body);
        getAllWithdrawRequests(context);

        notifyListeners();
      } else {
        print("kyyk");
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
