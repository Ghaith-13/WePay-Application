import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wepay/Profile/security.dart';
import 'package:wepay/deposit&withdraw/SyriatelCash.dart';

var UserImage;

class ProfileProvider with ChangeNotifier {
  var firstna = "",
      middlena = "",
      lastna = "",
      username = "",
      userNumber = "",
      imageUser = "",
      role = "",
      haram = "",
      bemoBank = "",
      syriatelCash = "",
      qrcode = "";
  var view = true;
  void changeImage(image) {
    UserImage = image;
    notifyListeners();
  }

/////////////////////////////////////////////////////////////////////////////////////////////////////////
  void fetchDataForInfo(
      firstName, middleName, lastName, UserName, UserNumber, context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';

    var request = http.MultipartRequest(
      'PUT',
      Uri.parse(
          'https://wepay-ali-aldayoub.onrender.com/api/v1.0/auth/updateBasic'),
    );

    request.headers['Authorization'] = 'Bearer $token';
    request.fields['firstName'] = firstName;
    request.fields['middleName'] = middleName;
    request.fields['lastName'] = lastName;
    request.fields['userName'] = UserName;
    request.fields['phoneNumber'] = UserNumber;
    if (UserImage != null) {
      http.MultipartFile imageFile =
          await http.MultipartFile.fromPath('imgURL', UserImage);
      request.files.add(imageFile);
    }
    try {
      var response = await request.send();
      if (response.statusCode == 201) {
        const Snack = SnackBar(content: Text(" تم الحفظ بنجاح"));
        ScaffoldMessenger.of(context).showSnackBar(Snack);
        var responseData = await http.Response.fromStream(response);
        var responseObject = json.decode(responseData.body);
        print(responseData);
        var infoUser = responseObject["user"];
        firstna = infoUser["firstName"];
        lastna = infoUser["lastName"];
        middlena = infoUser["middleName"];
        username = infoUser["userName"];
        userNumber = infoUser["phoneNumber"];

        notifyListeners();
      } else {
        var responseData = await http.Response.fromStream(response);
        var responseObject = json.decode(responseData.body);
        String msg = responseObject['message'];

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
      );
    }
    notifyListeners();
  }

/////////////////////////////////////////////////////////////////////////////////////////////////////////

  void fetchDataForSecruity(
      var oldPassword, var newPassword, var newPin, var context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';

    final url = Uri.parse(
        'https://wepay-ali-aldayoub.onrender.com/api/v1.0/auth/updateSecurity');
    try {
      var response;
      if (newPassword != null &&
          newPin != null &&
          newPassword.isNotEmpty &&
          newPin.isNotEmpty) {
        response = await http.put(
          url,
          headers: {'Authorization': 'Bearer $token'},
          body: {
            'oldPassword': oldPassword,
            'newPassword': newPassword,
            'newPin': newPin,
          },
        );
      } else if (newPassword != null && newPassword.isNotEmpty) {
        response = await http.put(
          url,
          headers: {'Authorization': 'Bearer $token'},
          body: {
            'oldPassword': oldPassword,
            'newPassword': newPassword,
          },
        );
      } else if (newPin != null && newPin.isNotEmpty) {
        response = await http.put(
          url,
          headers: {'Authorization': 'Bearer $token'},
          body: {
            'oldPassword': oldPassword,
            'newPin': newPin,
          },
        );
      }

      if (response.statusCode == 201) {
        const Snack = SnackBar(content: Text(" تم الحفظ بنجاح"));
        ScaffoldMessenger.of(context).showSnackBar(Snack);
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
        notifyListeners();
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
      );
    }
  }

/////////////////////////////////////////////////////////////////////////////////////////////////////////

  void fetchDataForBank(
      var haram, var bemoBank, var syriatelCash, var context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    final url = Uri.parse(
        'https://wepay-ali-aldayoub.onrender.com/api/v1.0/auth/updatePaymentInfo');
    try {
      final response = await http.put(
        url,
        headers: {'Authorization': 'Bearer $token'},
        body: {
          'haram': haram,
          'bemoBank': bemoBank,
          'syriatelCash': syriatelCash,
        },
      );

      if (response.statusCode == 201) {
        const Snack = SnackBar(content: Text(" تم الحفظ بنجاح"));
        ScaffoldMessenger.of(context).showSnackBar(Snack);
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
  }

/////////////////////////////////////////////////////////////////////////////////////////////////////////
  var email = "";
  var balance = 0;
  void getAllInfoUser(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    role = prefs.getString('role') ?? '';
    final url = await Uri.parse(
        'https://wepay-ali-aldayoub.onrender.com/api/v1.0/auth/getUserInfo');

    try {
      var response =
          await http.get(url, headers: {'Authorization': 'Bearer $token'});

      if (response.statusCode == 200) {
        Map<String, dynamic> info = await jsonDecode(response.body);

        var infoUser = info["user"];
        print(info);
        firstna = infoUser["firstName"];
        email = infoUser["email"];
        balance = infoUser["Balance"];
        lastna = infoUser["lastName"];
        middlena = infoUser["middleName"];
        username = infoUser["userName"];
        userNumber = infoUser["phoneNumber"];
        imageUser = infoUser["imgURL"];
        infoUser["haram"] == null ? haram = "" : haram = infoUser["haram"];
        infoUser["bemoBank"] == null
            ? bemoBank = ""
            : bemoBank = infoUser["bemoBank"];
        infoUser["syriatelCash"] == null
            ? syriatelCash = ""
            : syriatelCash = infoUser["syriatelCash"];
        qrcode = infoUser["qrcode"];
        // role=infoUser["role"];
        print(imageUser);
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
        text: '${error}',
      );
    }
    notifyListeners();
  }

  notifyListeners();
}
