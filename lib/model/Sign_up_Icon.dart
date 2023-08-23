import 'package:flutter/material.dart';

class ShowIcon extends ChangeNotifier {
  Icon eye = const Icon(
    Icons.visibility,
  );
  var check = true;

  changeIcon() {
    if (check == true) {
      check = false;
      eye = const Icon(
        Icons.visibility_off,
      );
      notifyListeners();
    } else {
      check = true;
      eye = const Icon(
        Icons.visibility,
      );
      notifyListeners();
    }
  }
}

class ShowIcon2 extends ChangeNotifier {
  Icon eye = const Icon(
    Icons.visibility,
  );
  var check = true;

  changeIcon() {
    if (check == true) {
      check = false;
      eye = const Icon(
        Icons.visibility_off,
      );
      notifyListeners();
    } else {
      check = true;
      eye = const Icon(
        Icons.visibility,
      );
      notifyListeners();
    }
  }
}
class Visible extends ChangeNotifier{
  bool vis=false;
  changeVis(){
    vis=!vis;
    notifyListeners();
  }
  notifyListeners();
}
class Visible1 extends ChangeNotifier{
  bool vis1=false;
  changeVis(){
    vis1=!vis1;
    notifyListeners();
  }
  notifyListeners();
}