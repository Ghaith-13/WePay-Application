import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wepay/Contact/Contact.dart';
import 'package:wepay/Pages.dart';
import 'package:wepay/model/Pay.dart';
import 'package:wepay/model/Payment.dart';
import 'package:wepay/model/Payment.dart';
import 'package:intl/intl.dart' as intl;
import 'package:http/http.dart' as http;

import '../model/Contact.dart';

final List<String> cites = [
  'حمص',
  'دمشق',
  'اللاذقية',
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
List PayType = [];

String? selectedValue;
String? selectedValue1;
bool flag = false;
var fullname, username, city, address, phonenumber, dealerImgURL;

class AddDealer extends StatefulWidget {
  const AddDealer({super.key});

  @override
  State<AddDealer> createState() => _AddDealerState();
}

class _AddDealerState extends State<AddDealer> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => SearchProvider()),
    ], child: Adddel());
  }
}

class Adddel extends StatefulWidget {
  const Adddel({super.key});

  @override
  State<Adddel> createState() => _AdddelState();
}

class _AdddelState extends State<Adddel> {
  final formKey = GlobalKey<FormState>();
  bool flag = true;
  final TextEditingController edit = new TextEditingController();
  final FocusNode focuse = new FocusNode();
  TextEditingController dateinput = TextEditingController();
  XFile? _image;
  String IMAGE = "assets/1.png";
  Future getImage() async {
    ImagePicker pick = new ImagePicker();
    var pickedFile = await pick.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = pickedFile;
        IMAGE = _image!.path;
        dealerImgURL = IMAGE;
        print(dealerImgURL);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  void initState() {
    super.initState();
    focuse.addListener(() {
      if (!focuse.hasFocus) {
        setState(() {
          flag = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    var model = Provider.of<SearchProvider>(context);

    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.01, vertical: height * 0.007),
        width: width * 0.9,
        height: height * 0.9,
        margin: EdgeInsets.symmetric(
            horizontal: width * 0.05, vertical: height * 0.01),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(width * 0.03)),
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
        ),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              Center(
                child: Text(
                  "إضافة وكيل",
                  style: TextStyle(
                      fontSize: width * 0.07,
                      color: Colors.green,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: height * 0.03),
              Center(
                  child: Stack(children: [
                _image != null
                    ? ClipOval(
                        child: Image.file(
                            width: width * 0.45,
                            height: height * 0.2,
                            fit: BoxFit.cover,
                            File(_image!.path) as File))
                    : CircleAvatar(
                        backgroundImage: AssetImage('assets/1.png'),
                        radius: width * 0.2,
                      ),
                Positioned(
                  bottom: height * 0,
                  right: width * 0,
                  child: InkWell(
                      onTap: () {
                        getImage();
                      },
                      child: Container(
                          width: width * 0.13,
                          height: height * 0.05,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                width: width * 0.007, color: Colors.white),
                            color: Color.fromARGB(250, 58, 165, 117),
                          ),
                          child: Icon(Icons.camera_alt, color: Colors.white))),
                ),
              ])),
              SizedBox(height: height * 0.03),
              Padding(
                padding: EdgeInsets.only(
                    top: width * 0.04, right: width * 0.04, left: width * 0.04),
                child: TextFormField(
                  onChanged: (value) {
                    username = value;
                  },
                  textDirection: TextDirection.rtl,
                  textInputAction: TextInputAction.done,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    prefixIcon: IconButton(
                      icon: Icon(Icons.title),
                      onPressed: () {},
                    ),
                    contentPadding: EdgeInsets.all(width * 0.04),
                    hintText: "اسم المستخدم",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(width * 0.03)),
                  ),
                  validator: (value) {
                    if (value!.isEmpty || value == null) {
                      return ' الحقل غير مدخل';
                    }
                    {
                      return null;
                    }
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(width * 0.04),
                child: TextFormField(
                  onChanged: (value) {
                    fullname = value;
                  },
                  textDirection: TextDirection.rtl,
                  textInputAction: TextInputAction.done,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    prefixIcon: IconButton(
                      icon: Icon(Icons.title),
                      onPressed: () {},
                    ),
                    contentPadding: EdgeInsets.all(width * 0.04),
                    hintText: "اسم الوكيل",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(width * 0.03)),
                  ),
                  validator: (value) {
                    if (value!.isEmpty || value == null) {
                      return ' الحقل غير مدخل';
                    }
                    {
                      return null;
                    }
                  },
                ),
              ),
              DROPDOWN(" المحافظة", cites, width, height),
              Padding(
                padding: EdgeInsets.only(
                    top: width * 0.035,
                    right: width * 0.035,
                    left: width * 0.035),
                child: TextFormField(
                  onChanged: (value) {
                    address = value;
                  },
                  textDirection: TextDirection.rtl,
                  textInputAction: TextInputAction.done,
                  textAlign: TextAlign.right,

                  decoration: InputDecoration(
                    prefixIcon: IconButton(
                      icon: Icon(Icons.location_pin),
                      onPressed: () {},
                    ),
                    contentPadding: EdgeInsets.all(width * 0.04),
                    hintText: "اسم المنطقة -اسم الشارع ",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(width * 0.03)),
                  ),
                  validator: (value) {
                    if (value!.isEmpty || value == null) {
                      return ' الحقل غير مدخل';
                    }
                    {
                      return null;
                    }
                  },
                  // obscureText: ShowIcon2.check,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(width * 0.035),
                child: IntlPhoneField(
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    hintText: ' رقم الموبايل',
                    suffixIcon: const Icon(Icons.phone),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                  ),
                  initialCountryCode: 'SY',
                  onChanged: (phone) {
                    phonenumber = phone.number;
                  },
                  onCountryChanged: (country) {},
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.2, vertical: height * 0.01),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(width * 0.03),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color.fromARGB(255, 120, 220, 175),
                        Color.fromARGB(255, 30, 84, 59),
                      ],
                    ),
                  ),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.transparent),
                      elevation: MaterialStateProperty.all(0),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(width * 0.03),
                        ),
                      ),
                    ),
                    child: const Text("إضافة"),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        model.submitFormData(username, fullname, city, address,
                            phonenumber, dealerImgURL, context);
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget DROPDOWN(String Label, List arr, var height, var width) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: width * 0.017),
    child: DropdownButtonFormField2(
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.zero,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(width * 0.013),
        ),
      ),
      isExpanded: true,

      hint: Directionality(
        textDirection: TextDirection.rtl,
        child: Row(
          children: [
            Text(
              "${Label}",
              textAlign: TextAlign.end,
            ),
          ],
        ),
      ),

      items: arr
          .map((item) => DropdownMenuItem<String>(
                value: item,
                child: Center(
                  child: Text(
                    item,
                    textAlign: TextAlign.end,
                  ),
                ),
              ))
          .toList(),
      validator: (value) {
        if (value == null) {
          return 'الحقل فارغ';
        }
        return null;
      },
      onChanged: (value) {
        city = value;
      },
      onSaved: (value) {
        selectedValue1 = value.toString();
      },
      buttonStyleData: ButtonStyleData(
        height: 55,
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
  );
}
