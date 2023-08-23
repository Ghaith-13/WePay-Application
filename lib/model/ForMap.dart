import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:lottie/lottie.dart';
import 'package:quickalert/quickalert.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:wepay/model/ListOfcontacts.dart';
import 'dart:convert';


import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import '../model/ListOfcontacts.dart';
// import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class Formap extends ChangeNotifier{
  double lat=34.0;
  double log=36.0;
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
    'درعا',
    'الكل'
  ];
  var categories = [
    'حسب نوع المتجر',
    'ألبسة',
    'أحذية',
    'مواد غذائية',
    'صاغة',
    'مواد تنظيف',
    'بقالية',
    'محمصة',
    'بالة',
    'أخرى',
    'الكل'

  ];
  changeLatAndLog(double x,double y){
    lat=x;
    log=y;
    notifyListeners();
  }
  var role = '';
  
  String ChooseValue = "";
  String countreyValue = "";
  String CategValue="";
  var display_List;
  List<dynamic> infoUser = [];
  bool Showsnack = false;
  void fetchData(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    role = prefs.getString('role') ?? '';
    print("Hi");
    final url = await Uri.parse(
        'https://wepay-ali-aldayoub.onrender.com/api/v1.0/store/getAllStores');
    print("Bye");
    notifyListeners();

    try {
      var response =
          await http.get(url, headers: {'Authorization': 'Bearer $token'});
      notifyListeners();

      if (response.statusCode == 200) {
        
        Map<String, dynamic> info = await jsonDecode(response.body);
        displydata(info['data']);
        print(info['data']);
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
  void displydata(x) {
    infoUser = x;
    display_List = List.from(infoUser);
    notifyListeners();
  }
  void filterData(String query) {
    if (query == "") {
      display_List = infoUser;
      notifyListeners();
    } else if (countreyValue != "" && CategValue!="") {
      display_List = infoUser
          .where((ele) =>
              ele["storeType"]!.toLowerCase().contains(CategValue.toLowerCase()) &
              ele["storeName"]!.toLowerCase().contains(query.toLowerCase()) &
              ele["city"]!.toLowerCase().contains(countreyValue.toLowerCase()))
          .toList();
      display_List = List.from(display_List);
      notifyListeners();
    }
    else if (countreyValue != "" ) {
      display_List = infoUser
          .where((ele) =>
             
              ele["storeName"]!.toLowerCase().contains(query.toLowerCase()) &
              ele["city"]!.toLowerCase().contains(countreyValue.toLowerCase()))
          .toList();
      display_List = List.from(display_List);
      notifyListeners();
    }
    else if ( CategValue!="") {
      display_List = infoUser
          .where((ele) =>
              ele["storeType"]!.toLowerCase().contains(CategValue.toLowerCase()) &
              ele["storeName"]!.toLowerCase().contains(query.toLowerCase()) 
             )
          .toList();
      display_List = List.from(display_List);
      notifyListeners();
    }
     else  {
      display_List = infoUser
          .where((item) =>
              item["storeName"]!.toLowerCase().contains(query.toLowerCase()))
          .toList();
      notifyListeners();
    }
    notifyListeners();
  }

  void clear() {
    if (countreyValue != "" && CategValue!="") {
      display_List = infoUser;
      display_List = infoUser
          .where((ele) =>
              ele["city"]!.toLowerCase().contains(countreyValue.toLowerCase())&
               ele["storeType"]!.toLowerCase().contains(CategValue.toLowerCase()))
          .toList();
      notifyListeners();
    }
    else if (CategValue!="") {
      display_List = infoUser;
      display_List = infoUser
          .where((ele) =>
             
               ele["storeType"]!.toLowerCase().contains(CategValue.toLowerCase()))
          .toList();
      notifyListeners();
    }
    else if (countreyValue != "" ) {
      display_List = infoUser;
      display_List = infoUser
          .where((ele) =>
              ele["city"]!.toLowerCase().contains(countreyValue.toLowerCase())
              )
          .toList();
      notifyListeners();
    }
    
     else {
      display_List = infoUser;
      notifyListeners();
    }
    notifyListeners();
  }

  void Updatebycountrey(String site) {
    //  print(site);
        countreyValue = site;
    if(site=='الكل'){
      display_List = infoUser;
     
      notifyListeners();
    // print(site);
    }

    else if (ChooseValue != ""&&CategValue!=""&&CategValue!='الكل') {
      // print(display_List);
      display_List = infoUser
          .where((ele) =>
              ele["city"]!.toLowerCase().contains(site.toLowerCase()) &
              ele["storeType"]!.toLowerCase().contains(CategValue.toLowerCase()) &
              ele["storeName"]!
                  .toLowerCase()
                  .contains(ChooseValue.toLowerCase()))
          .toList();
      
      notifyListeners();
    }
   else if (CategValue!=""&&CategValue!='الكل') {
      
      display_List = infoUser
          .where((ele) =>
              ele["city"]!.toLowerCase().contains(site.toLowerCase()) &
              ele["storeType"]!.toLowerCase().contains(CategValue.toLowerCase()) 
             )
          .toList();
      // print("///////////////////////////////////////////////////////");
      // print(display_List);
      notifyListeners();
    }
    else if (ChooseValue != "") {
      // print(display_List);
      display_List = infoUser
          .where((ele) =>
              ele["city"]!.toLowerCase().contains(site.toLowerCase()) &
             
              ele["storeName"]!
                  .toLowerCase()
                  .contains(ChooseValue.toLowerCase()))
          .toList();
      // print("///////////////////////////////////////////////////////");
      // print(display_List);
      notifyListeners();
    }
     else {
      display_List = infoUser
          .where(
              (ele) => ele["city"]!.toLowerCase().contains(site.toLowerCase()))
          .toList();

      notifyListeners();
    }
    notifyListeners();
  }


  void Updatebycateg(String site) {
    print(site);
    CategValue = site;
    if(site=='الكل'){
      display_List = infoUser;
      notifyListeners();
      print("site");
    }
    
    else if (ChooseValue != ""&&countreyValue!=""&&countreyValue!='الكل') {
       print("ll");
      display_List = infoUser
          .where((ele) =>
              ele["city"]!.toLowerCase().contains(countreyValue.toLowerCase()) &
              ele["storeType"]!.toLowerCase().contains(site.toLowerCase()) &
              ele["storeName"]!
                  .toLowerCase()
                  .contains(ChooseValue.toLowerCase()))
          .toList();
      // print("///////////////////////////////////////////////////////");
      // print(display_List);
      notifyListeners();
    }
    else if (ChooseValue != "") {
      // print(display_List);
      display_List = infoUser
          .where((ele) =>
              ele["storeName"]!.toLowerCase().contains(ChooseValue.toLowerCase()) &
              ele["storeType"]!.toLowerCase().contains(site.toLowerCase()) 
             )
          .toList();
      // print("///////////////////////////////////////////////////////");
      // print(display_List);
      notifyListeners();
    }
    else if (countreyValue!=""&&countreyValue!='الكل') {
      // print(display_List);
      display_List = infoUser
          .where((ele) =>
              
              ele["storeType"]!.toLowerCase().contains(site.toLowerCase()) &
              ele["city"]!
                  .toLowerCase()
                  .contains(countreyValue.toLowerCase()))
          .toList();
      // print("///////////////////////////////////////////////////////");
      // print(display_List);
      notifyListeners();
    }
    
     else {
      display_List = infoUser
          .where(
              (ele) => ele["storeType"]!.toLowerCase().contains(site.toLowerCase()))
          .toList();

      notifyListeners();
    }
    notifyListeners();
  }


 notifyListeners();
  
}