import 'package:flutter/foundation.dart';
import 'package:lottie/lottie.dart';
import 'package:quickalert/quickalert.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:wepay/model/ListOfcontacts.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import '../model/ListOfcontacts.dart';
// import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SearchProvider with ChangeNotifier {
  late BuildContext context;

  List<dynamic> infoUser = [];
  bool Showsnack = false;
  List<String> syrianCities = [
    'حسب المحافظة',
    'دمشق',
    'حلب',
    'حمص',
    'حماة',
    'طرطوس',
    'لاذقية',
    'دير الزور',
    'الرقة',
    'الحسكة',
    'ادلب',
    'السويداء',
    'القنيطرة',
    'درعا'
  ];
  var role = '';
  get data => infoUser;
  String ChooseValue = "";
  String countreyValue = "";
  var display_List;
  void fetchData(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    role = prefs.getString('role') ?? '';
    print("Hi");
    final url = await Uri.parse(
        'https://wepay-ali-aldayoub.onrender.com/api/v1.0/dealers/getAllDealers');
    print("Bye");
    notifyListeners();

    try {
      var response =
          await http.get(url, headers: {'Authorization': 'Bearer $token'});
      notifyListeners();

      if (response.statusCode == 201) {
        // If the server did return a 200 OK response,
        // then parse the JSON.

        // print(jsonDecode(response.body));
        Map<String, dynamic> info = await jsonDecode(response.body);
        displydata(info['data']);

        notifyListeners();
      } else {
        Showsnack = true;
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
      notifyListeners();
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
        text: 'نعتذر منك ,لا يوجد اتصال في الانترنت يرجى المحاولة لاحقاً',
      );
      print('لا يوجد اتصال في الانترنت يرجى المحاولة لاحقاً');
    }
    notifyListeners();
  }

  Future<void> submitFormData(String username, String fullname, String city,
      String address, String phoneNumber, String dealerImgURL, context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    print(dealerImgURL);
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          'https://wepay-ali-aldayoub.onrender.com/api/v1.0/dealers/addDealer'),
    );
    request.headers['Authorization'] = 'Bearer $token';
    request.fields['userName'] = username;
    request.fields['fullName'] = fullname;
    request.fields['city'] = city;
    request.fields['address'] = address;
    request.fields['phoneNumber'] = phoneNumber;
    // Create a MultipartFile from the image path
    http.MultipartFile imageFile =
        await http.MultipartFile.fromPath('dealerImgURL', dealerImgURL);

    // Add the image file to the request
    request.files.add(imageFile);
    print(request.fields['dealerImgURL']);
    print(request.fields['userName']);
    print(request.fields['city']);
    print(request.fields['address']);
    print(request.fields['phoneNumber']);
    print(request.fields['fullName']);
    print("asd");
    var response = await request.send();
    print("asdffffe");
    if (response.statusCode == 200) {
      const Snack = SnackBar(content: Text("تمت الإضافة بنجاح"));
      ScaffoldMessenger.of(context).showSnackBar(Snack);
      fetchData(context);
      Navigator.pop(context);
    } else {
      print('Failed to submit form data: ${response.reasonPhrase}');
      const Snack = SnackBar(content: Text("هنالك خطأ"));
      ScaffoldMessenger.of(context).showSnackBar(Snack);
    }
  }

  void displydata(x) {
    infoUser = x;
    display_List = List.from(infoUser);
    notifyListeners();
  }

  void filterData(String query) {
    if (query == "") {
      display_List = infoUser;
      notifyListeners();
    } else if (countreyValue != "") {
      display_List = infoUser
          .where((ele) =>
              ele["fullName"]!.toLowerCase().contains(query.toLowerCase()) &
              ele["city"]!.toLowerCase().contains(countreyValue.toLowerCase()))
          .toList();
      display_List = List.from(display_List);
      notifyListeners();
    } else {
      display_List = infoUser
          .where((item) =>
              item["fullName"]!.toLowerCase().contains(query.toLowerCase()))
          .toList();
      notifyListeners();
    }
    notifyListeners();
  }

  void clear() {
    if (countreyValue != "") {
      display_List = infoUser;
      display_List = infoUser
          .where((ele) =>
              ele["city"]!.toLowerCase().contains(countreyValue.toLowerCase()))
          .toList();
      notifyListeners();
    } else {
      display_List = infoUser;
      notifyListeners();
    }
    notifyListeners();
  }

  void Updatebycountrey(String site) {
    // print(site);
    countreyValue = site;
    if (ChooseValue != "") {
      // print(display_List);
      display_List = infoUser
          .where((ele) =>
              ele["city"]!.toLowerCase().contains(site.toLowerCase()) &
              ele["fullName"]!
                  .toLowerCase()
                  .contains(ChooseValue.toLowerCase()))
          .toList();
      // print("///////////////////////////////////////////////////////");
      // print(display_List);
      notifyListeners();
    } else {
      display_List = infoUser
          .where(
              (ele) => ele["city"]!.toLowerCase().contains(site.toLowerCase()))
          .toList();

      notifyListeners();
    }
    notifyListeners();
  }

  notifyListeners();
}
