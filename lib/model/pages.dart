import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:wepay/Contact/Contact.dart';
import 'package:wepay/QRcode/Qrscreen.dart';

import '../BudgetMangment/BudgetManagement.dart';
import '../Participants/Participants.dart';
import '../Participants/LastTranstion.dart';
import '../Profile/mainProfile.dart';
import '../QRcode/generate.dart';
import '../deposit&withdraw/mainPage/MainPage.dart';

class ConvertPages extends ChangeNotifier {
  Widget nameOfPage = QrScreen();
  String Title = "المسح والتوليد";
  int i = -2;

  goToProfile(context) {
    nameOfPage = ProfileMain();
    Title = "الملف الشخصي";
    Navigator.pop(context);

    notifyListeners();
  }

  goToBudgetMangment(context) {
    nameOfPage = BudgetManagment();
    Title = "إدارة الميزانية";
    Navigator.pop(context);

    notifyListeners();
  }

  goToContact(context) {
    nameOfPage = Contact();
    Title = "الوكلاء ";
    Navigator.pop(context);

    notifyListeners();
  }

  goToQrCode(context) {
    nameOfPage = QrScreen();
    Title = "المسح والتوليد";
    Navigator.pop(context);

    notifyListeners();
  }

  goToParticipants(context) {
    nameOfPage = Participants();
    Title = "المشتركون";
    Navigator.pop(context);

    notifyListeners();
  }

  goToDepost(context) {
    nameOfPage = MainPage();
    Title = "السحب والإيداع";
    Navigator.pop(context);

    notifyListeners();
  }

  onClick2(i) {
    print(i);
    if (i == 2) {
      i = 2;
      nameOfPage = QrScreen();
      Title = "المسح والتوليد";
      notifyListeners();
    }
    if (i == 0) {
      i = 0;
      Title = "إدارة الميزانية";
      nameOfPage = BudgetManagment();
      notifyListeners();
    }
    if (i == 4) {
      i = 4;
      Title = "السحب والإيداع";
      nameOfPage = MainPage();
      notifyListeners();
    }

    if (i == 1) {
      i = 1;
      Title = "الوكلاء";
      nameOfPage = Contact();
      notifyListeners();
    }
    if (i == 3) {
      print(i);
      Title = "المشتركون";
      nameOfPage = Participants();
      notifyListeners();
    }
    notifyListeners();
  }
}
