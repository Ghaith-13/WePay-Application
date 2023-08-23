import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:location/location.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;
import 'package:quickalert/quickalert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpgradeSeller extends StatefulWidget {
  const UpgradeSeller({super.key});

  @override
  State<UpgradeSeller> createState() => _UpgradeSellerState();
}

class _UpgradeSellerState extends State<UpgradeSeller> {
  late LocationData data = new LocationData.fromMap({'lat1': 0.0, 'log1': 1.0});
  Location location = Location();
  MapController _mapController = MapController();
  double lat = 0.0, log = 0.0;
  late StreamSubscription<LocationData> _locationSubscription;
  late Timer time;
  XFile? _image;
  String IMAGE = "assets/1.png";
  final List<String> cites = [
    'حمص',
    'دمشق',
    'الاذقية',
    'طرطوس',
    'حلب',
    'الرقة',
    'دير الزور',
    'حماة',
    'درعا',
    'السويداء',
    'القنيطرة ',
    'الحسكة',
    'إدلب',
    'ريف دمشق',
  ];
  var categories = [
    'ألبسة',
    'أحذية',
    'مواد غذائية',
    'صاغة',
    'مواد تنظيف',
  ];

  String? selectedValue;
  String? selectedValue1;
  bool isObscurepass = true;
  bool flag = true;
  final formKey = GlobalKey<FormState>();
  var coo = [];
  var storeName, address, city, storeType, storeImgURL;
  late SharedPreferences SharedStorage;

  Future<void> submitFormData(var storeName, var address, var city,
      var storeType, storeImgURL, var coo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          'https://wepay-ali-aldayoub.onrender.com/api/v1.0/auth/updateUserToSeller'),
    );
    request.headers['Authorization'] = 'Bearer $token';
    request.fields['storeName'] = storeName;
    request.fields['storeType'] = storeType;
    request.fields['city'] = city;
    request.fields['address'] = address;
    request.fields['coo'] = json.encode(coo);
    // Create a MultipartFile from the image path
    http.MultipartFile imageFile =
        await http.MultipartFile.fromPath('storeImgURL', storeImgURL);

    // Add the image file to the request
    request.files.add(imageFile);

    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        var responsedata = await http.Response.fromStream(response);
        var responseobj = json.decode(responsedata.body);

        SharedStorage = await SharedPreferences.getInstance();
        await SharedStorage.setString('role', responseobj['user']['role']);

        const Snack = SnackBar(content: Text("تمت الإضافة بنجاح"));
        ScaffoldMessenger.of(context).showSnackBar(Snack);
        Navigator.pop(context);
      } else {
        var responsedata = await http.Response.fromStream(response);
       
        String error= json.decode(responsedata.body);
        var Snack = SnackBar(content: Text("error"));
        ScaffoldMessenger.of(context).showSnackBar(Snack);
      }
    } catch (error) {}
  }

  Future<geo.Position> getCurrentLocation() async {
    geo.Position position = await geo.Geolocator.getCurrentPosition(
        desiredAccuracy: geo.LocationAccuracy.high);
    coo.add(position.longitude);
    coo.add(position.latitude);
    return position;
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      AwesomeDialog(
              context: context,
              dialogType: DialogType.noHeader,
              headerAnimationLoop: true,
              animType: AnimType.topSlide,
              title: "تنويه",
              desc:
                  "سيتم خصم 5000 ل.س من رصيدك \n ويجب عليك أن تقوم بالترقية من محلك لكي نحفظ الموقع لدينا",
              descTextStyle:
                  TextStyle(fontSize: MediaQuery.of(context).size.width * 0.05),
              titleTextStyle: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.07,
                  color: Colors.red,
                  fontWeight: FontWeight.bold),
              buttonsTextStyle: TextStyle(color: Colors.white),
              btnCancelOnPress: () {
                Navigator.of(context).pop();
              },
              btnOkOnPress: () {})
          .show();
    });
    getCurrentLocation();
  }

  @override
  Future getImage() async {
    ImagePicker pick = new ImagePicker();
    var pickedFile = await pick.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = pickedFile;
        IMAGE = _image!.path;
        storeImgURL = IMAGE;
      } else {}
    });
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return Scaffold(
      appBar: AppBar(),
      body: Container(
          padding: EdgeInsets.all(width * 0.01),
          child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Form(
                key: formKey,
                child: ListView(children: [
                  SizedBox(height: height * 0.02),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _image != null
                            ? ClipOval(
                                child: Image.file(
                                    width: width * 0.4,
                                    height: height * 0.18,
                                    fit: BoxFit.cover,
                                    File(_image!.path)))
                            : CircleAvatar(
                                backgroundImage: AssetImage('assets/1.png'),
                                radius: width * 0.2,
                              ),
                        SizedBox(width: width * 0.02),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Center(
                                  child: Text("حمل صورة المتجر",
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(250, 58, 165, 117),
                                          fontSize: width * 0.06,
                                          fontWeight: FontWeight.bold))),
                              Icon(Icons.arrow_downward,
                                  size: width * 0.07, color: Colors.black),
                              SizedBox(height: height * 0.02),
                              InkWell(
                                onTap: () {
                                  getImage();
                                },
                                child: Icon(Icons.camera_alt,
                                    size: width * 0.1,
                                    color: Color.fromARGB(250, 58, 165, 117)),
                              )
                            ]),
                      ]),
                  SizedBox(height: height * 0.07),
                  buildtextfield("اسم المحل", "مثال:محل الأناقة", false, 1,
                      initvalue: flag == false ? "الأناقة" : ""),
                  SizedBox(height: height * 0.015),
                  buildtextfield("عنوان المحل", "حمص-شارع العشاق", false, 2,
                      initvalue: flag == false ? "عكرمة-شارع العشاق" : ""),
                  Container(
                    padding: EdgeInsets.all(width * 0.03),
                    child: DropdownButtonFormField2(
                      value: flag == false ? 'حمص' : null,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(width * 0.01),
                        ),
                      ),
                      isExpanded: true,

                      hint: Directionality(
                        textDirection: TextDirection.rtl,
                        child: Row(
                          children: [
                            Text(
                              ' المحافظة',
                              textAlign: TextAlign.end,
                              style: TextStyle(fontSize: width * 0.04),
                            ),
                          ],
                        ),
                      ),

                      items: cites
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Center(
                                  child: Text(
                                    item,
                                    textAlign: TextAlign.end,
                                    style: TextStyle(fontSize: width * 0.05),
                                  ),
                                ),
                              ))
                          .toList(),
                      validator: (value) {
                        if (value == null) {
                          return 'Please select gender.';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        city = value;
                        //Do something when changing the item if you want.
                      },
                      onSaved: (value) {
                        selectedValue1 = value.toString();
                      },
                      buttonStyleData: ButtonStyleData(
                        height: height * 0.07,
                        padding: EdgeInsets.symmetric(horizontal: width * 0.01),
                      ),
                      iconStyleData: const IconStyleData(
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black45,
                        ),
                        iconSize: 30,
                      ),

                      // dropdownDirection:TextDirection.rtl;
                    ),
                  ),
                  SizedBox(height: height * 0.015),
                  Container(
                    padding: EdgeInsets.all(width * 0.03),
                    child: DropdownButtonFormField2(
                      value: flag == false ? 'صاغة' : null,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(width * 0.01),
                        ),
                      ),
                      isExpanded: true,

                      hint: Directionality(
                        textDirection: TextDirection.rtl,
                        child: Row(
                          children: [
                            Text(
                              '  نوع المتجر',
                              textAlign: TextAlign.end,
                              style: TextStyle(fontSize: width * 0.04),
                            ),
                          ],
                        ),
                      ),

                      items: categories
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Center(
                                  child: Text(
                                    item,
                                    textAlign: TextAlign.end,
                                    style: TextStyle(fontSize: width * 0.04),
                                  ),
                                ),
                              ))
                          .toList(),
                      validator: (value) {
                        if (value == null) {
                          return 'Please select gender.';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        storeType = value;
                        //Do something when changing the item if you want.
                      },
                      onSaved: (value) {
                        selectedValue = value.toString();
                      },
                      buttonStyleData: ButtonStyleData(
                        height: height * 0.07,
                        padding: EdgeInsets.symmetric(horizontal: width * 0.01),
                      ),
                      iconStyleData: const IconStyleData(
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black45,
                        ),
                        iconSize: 30,
                      ),

                      // dropdownDirection:TextDirection.rtl;
                    ),
                  ),
                  SizedBox(height: height * 0.01),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate() &&
                            storeImgURL != null) {
                          submitFormData(storeName, address, city, storeType,
                              storeImgURL, coo);
                        } else {
                          QuickAlert.show(
                            confirmBtnText: 'حسناً',
                            confirmBtnColor: Color.fromARGB(255, 69, 151, 110),
                            context: context,
                            type: QuickAlertType.error,
                            title: 'عذراً',
                            titleColor: Colors.red,
                            text: 'يجب تعبئة كافة البيانات',
                          );
                        }
                      },
                      child: Text("إرسال",
                          style: TextStyle(
                              fontSize: width * 0.05, color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(250, 58, 165, 117),
                          padding:
                              EdgeInsets.symmetric(horizontal: width * 0.15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(width * 0.5),
                          )),
                    )
                  ]),
                ]),
              ))),
    );
  }

  Widget buildtextfield(String label, String PlaceHolder, bool isPass, int flag,
      {String? initvalue}) {
    return Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
        child: TextFormField(
          initialValue: initvalue,
          textAlign: TextAlign.right,
          textDirection: TextDirection.rtl,
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(
                    width: MediaQuery.of(context).size.width * 0.01,
                    color: Color.fromARGB(250, 58, 165, 117)),
              ),
              prefixIcon: IconButton(
                  onPressed: () {}, icon: Icon(Icons.edit, color: Colors.grey)),
              contentPadding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.width * 0.1,
                  right: MediaQuery.of(context).size.width * 0.1),
              labelText: label,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              hintText: PlaceHolder,
              hintStyle: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.04,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey)),
          validator: (value) {
            if (flag == 1) {
              if (value!.isEmpty || value == null) {
                return ' الحقل غير مدخل';
              }
              storeName = value;
            } else if (flag == 2) {
              if (value!.isEmpty || value == null) {
                return ' الحقل غير مدخل';
              }
              address = value;
            }
          },
        ));
  }
}
