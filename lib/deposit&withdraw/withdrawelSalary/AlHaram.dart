import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:wepay/model/Pay.dart';
import 'package:wepay/model/Payment.dart';
import 'package:wepay/model/Payment.dart';
import '../mainPage/FirstPage.dart';

var recivername, reciverphone, recivercity, amountvalue, pin;

class AlHaram extends StatefulWidget {
  const AlHaram({super.key});

  @override
  State<AlHaram> createState() => _AlHaramState();
}

class _AlHaramState extends State<AlHaram> {
  final formKey = GlobalKey<FormState>();
  bool flag = true;
  final TextEditingController edit = new TextEditingController();
  final FocusNode focuse = new FocusNode();

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

  int i = 0;
  late TextEditingController _controller;
  late TextEditingController _controller2;
  late TextEditingController _controller3;
  late TextEditingController _controller4;
  @override
  Widget build(BuildContext context) {
    var model = Provider.of<depositandwithdraw>(context);
    if (i == 0) {
      model.getShipping(context);
      i++;
    }
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    _controller = TextEditingController();
    _controller2 = TextEditingController();
    _controller3 = TextEditingController();
    _controller4 = TextEditingController();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => depositandwithdraw(),
        )
      ],
      child: Container(
        padding: EdgeInsets.all(width * 0.02),
        width: width * 0.9,
        height: height * 0.75,
        margin: EdgeInsets.symmetric(
            horizontal: width * 0.05, vertical: height * 0.05),
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
        child:
        Form(
          key:formKey,
         child:ListView(
          //  crossAxisAlignment: CrossAxisAlignment.center,
          //  mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () {
                    Provider.of<depositandwithdraw>(context, listen: false)
                        .onClick2(3);
                    Provider.of<depositandwithdraw>(context, listen: false)
                        .onClick(5);
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: Color.fromARGB(250, 58, 165, 117),
                  ),
                ),
                SizedBox(
                  width: width * 0.15,
                ),
                Text(
                  "شركة الهرم للحوالات المالية",
                  style: TextStyle(
                      fontSize: width * 0.045,
                      color: Color.fromARGB(255, 82, 173, 117),
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: height * 0.015),
            Center(
              child: Text(
                ": بيانات سحب الرصيد",
                style: TextStyle(
                    fontSize: width * 0.04,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: height * 0.01),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "${model.firstname} ${model.middlename} ${model.lastname}",
                  style: TextStyle(
                    fontSize: width * 0.035,
                    color: Colors.red,
                  ),
                ),
                Text(
                  " :اسم المرسل",
                  style: TextStyle(
                    fontSize: width * 0.035,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "${model.phonenumber}",
                  style: TextStyle(
                    fontSize: width * 0.035,
                    color: Colors.red,
                  ),
                ),
                Text(
                  ": رقم المستقبل ",
                  style: TextStyle(
                    fontSize: width * 0.035,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: height * 0.03,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: width * 0.02),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _controller,
                    // scrollPadding: EdgeInsets.only(bottom: 40.sp),
                    maxLines: 1,
                    textAlign: TextAlign.right,
                    // textAlignVertical: ,
                    decoration: InputDecoration(
                      // contentPadding: EdgeInsets.only(top: height * 0.02),
                      hintText: " اسم المستقبل",
                      suffixIcon: const Icon(Icons.numbers),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: width * 0.01),
                      ),
                    ),
                     validator: (value) {
                              if (value!.isEmpty || value == null) {
                                return 'الاسم فارغ';
                              } else if (!RegExp(r'^[ا-يa-z A-Z]+$')
                                  .hasMatch(value)) {
                                return 'ادخل الاسم الصحيح (يحتوي محارف)';
                              } else if (value.trim().split(' ').length != 3) {
                                return "ادخل الاسم الثلاثي الكامل";
                              } else {
                                var split = value.trim().split(' ');
                                
                              }
                            },
                  ),
                  SizedBox(height: height * 0.01),
                  IntlPhoneField(
                    controller: _controller2,
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
                      print(phone.completeNumber);
                    },
                    onCountryChanged: (country) {
                      print('Country changed to: ' + country.name);
                    },
                  ),
                  SizedBox(height: height * 0.01),
                  TextFormField(
                    controller: _controller3,
                    maxLines: 1,
                    textAlign: TextAlign.right,
                    // textAlignVertical: ,
                    decoration: InputDecoration(
                      // contentPadding: EdgeInsets.only(top: 10.sp),
                      hintText: "    قيمة المبلغ المرسل ",
                      suffixIcon: const Icon(Icons.money),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: width * 0.01),
                      ),
                    ),
                     validator: (value) {
                  if (value!.isEmpty) {
                    return 'الحقل فارغ';
                  } else if (int.tryParse(value)!<=500&&int.tryParse(value)!>=2000000) {
                    return ' المبلغ يجب أن يكون بين 500 و 2000000';
                  } else {
                    return null;
                  }
                },
                  ),
                  SizedBox(height: height * 0.01),
                  DROPDOWN(" المحافظة", cites, width, height),
                  SizedBox(height: height * 0.01),
                  TextFormField(
                    controller: _controller4,
                    // scrollPadding: EdgeInsets.only(bottom:40.sp),
                    maxLines: 1,
                    textAlign: TextAlign.right,
                    // textAlignVertical: ,
                    decoration: InputDecoration(
                      // contentPadding: EdgeInsets.only(top: 10.sp),
                      hintText: "الخاص بك PIN رقم",
                      suffixIcon: const Icon(Icons.numbers),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: width * 0.01),
                      ),
                    ),
                     validator: (value) {
                  if (value!.isEmpty) {
                    return 'الحقل فارغ';
                  } else if (value.length<4) {
                    return 'الحقل يتكون من أربعة أرقام';}
                  
                   else {
                    return null;
                  }
                }
                  ),
                  SizedBox(height: height * 0.03),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                    ),
                    child: const Text("  تأكيد العملية  "),
                    onPressed: () {
                         if (formKey.currentState!.validate()) {
                      print(city);
                      recivername = _controller.text;
                      reciverphone = _controller2.text;
                      amountvalue = _controller3.text;
                      pin = _controller4.text;
                      print(_controller.text);
                      print(_controller2.text);
                      print(_controller3.text);
                      print(_controller4.text);
                      model.withdrawFromHaram(recivername, reciverphone, city,
                          pin, amountvalue, context);
                    }},
                  ),
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }
}

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

String? selectedValue;
String? selectedValue1;
var city;

Widget DROPDOWN(String Label, List arr, var height, var width) {
  return Container(
    // padding: EdgeInsets.symmetric(horizontal: width * 0.05),
    child: DropdownButtonFormField2(
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.zero,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(width * 0.005),
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
        height: height * 0.15,
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
