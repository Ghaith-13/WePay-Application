import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:wepay/model/Pay.dart';

import '../../model/Payment.dart';
import '../mainPage/FirstPage.dart';

var Type, phonenumber, amountvalue, pin;

class SyriatelWithdrawe extends StatefulWidget {
  const SyriatelWithdrawe({super.key});

  @override
  State<SyriatelWithdrawe> createState() => _SyriatelWithdraweState();
}

class _SyriatelWithdraweState extends State<SyriatelWithdrawe> {
  final formKey = GlobalKey<FormState>();
  bool flag = true;
  final TextEditingController edit = new TextEditingController();
  final FocusNode focuse = new FocusNode();
  final List<String> genderItems = [
    'حساب تاجر,الدفع يدوي',
    'حساب مستخدم,التحويل يدوي',
  ];

  String? selectedValue;

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

  late TextEditingController _controller;
  late TextEditingController _controller2;
  late TextEditingController _controller3;
  @override
  Widget build(BuildContext context) {
    var model = Provider.of<depositandwithdraw>(context);
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    _controller = TextEditingController();
    _controller2 = TextEditingController();
    _controller3 = TextEditingController();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => depositandwithdraw(),
        )
      ],
      child: Container(
        padding: EdgeInsets.all(width * 0.01),
        width: width * 0.9,
        height: height * 0.6,
        margin: EdgeInsets.symmetric(
            horizontal: width * 0.05, vertical: height * 0.12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10.r)),
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
        child: ListView(
          //  crossAxisAlignment: CrossAxisAlignment.center,
          //  mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: height * 0.015),
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
                  width: width * 0.25,
                ),
                Text(
                  "سيرياتيل كاش",
                  style: TextStyle(
                      fontSize: width * 0.05,
                      color: Color.fromARGB(255, 82, 173, 117),
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: height * 0.05),
            Container(
              margin: EdgeInsets.symmetric(horizontal: width * 0.04),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IntlPhoneField(
                    controller: _controller,
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
                    controller: _controller2,
                    maxLines: 1,
                    textAlign: TextAlign.right,
                    // textAlignVertical: ,
                    decoration: InputDecoration(
                      hintText: "    قيمة المبلغ المرسل ",
                      suffixIcon: const Icon(Icons.money),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: width * 0.01),
                      ),
                    ),
                    validator: (value) {
                  if (value!.isEmpty) {
                    return 'الحقل فارغ';
                  } else if (int.tryParse(value)!<=100&&int.tryParse(value)!>=250000) {
                    return ' المبلغ يجب أن يكون بين 100 و 250000';
                  } else {
                    return null;
                  }
                },
                  ),
                  SizedBox(height: height * 0.01),
                  DropdownButtonFormField2(
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
                            'نوع حساب المستخدم',
                            textAlign: TextAlign.end,
                            style: TextStyle(fontSize: width * 0.04),
                          ),
                        ],
                      ),
                    ),

                    items: genderItems
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
                      if (value == null&&value!.isEmpty) {
                        return 'اختار نوع حساب المستخدم';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      Type = value;
                    },
                    onSaved: (value) {
                      selectedValue = value.toString();
                    },
                    buttonStyleData: const ButtonStyleData(
                      height: 55,
                      padding: EdgeInsets.only(left: 20, right: 10),
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
                  SizedBox(height: height * 0.01),
                  TextFormField(
                    controller: _controller3,
                    // scrollPadding: EdgeInsets.only(bottom:40.sp),
                    maxLines: 1,
                    textAlign: TextAlign.right,
                    // textAlignVertical: ,
                    decoration: InputDecoration(
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
                  SizedBox(height: height * 0.05),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                    ),
                    child: const Text("  تأكيد العملية  "),
                    onPressed: () {
                       if (formKey.currentState!.validate()) {
                      phonenumber = _controller.text;
                      amountvalue = _controller2.text;
                      pin = _controller3.text;
                      model.withdrawFromSyriatelCash(
                          Type, phonenumber, pin, amountvalue, context);
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
