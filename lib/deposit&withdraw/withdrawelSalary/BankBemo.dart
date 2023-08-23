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

var Banknumber, amountvalue, pin;

class BankBemoWithdraw extends StatefulWidget {
  const BankBemoWithdraw({super.key});

  @override
  State<BankBemoWithdraw> createState() => _BankBemoWithdrawState();
}

class _BankBemoWithdrawState extends State<BankBemoWithdraw> {
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
                  width: width * 0.15,
                ),
                Text(
                  "بنك بيمو السعودي الفرنسي",
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
                  TextFormField(
                    controller: _controller,
                    maxLines: 1,
                    textAlign: TextAlign.right,
                    // textAlignVertical: ,
                    decoration: InputDecoration(
                      hintText: "رقم حساب بنك بيمو للمستقبل",
                      suffixIcon: const Icon(Icons.money),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: width * 0.01),
                      ),
                    ),
                    validator: (value) {
                  if (value!.isEmpty) {
                    return 'الكود فارغ';
                  } else if (value.length!=7) {
                    return ' 7 الكود يجب أن يتكون من ';
                  } else {
                    return null;
                  }
                },
                  ),
                  SizedBox(height: height * 0.01),
                  TextFormField(
                    controller: _controller2,
                    maxLines: 1,
                    textAlign: TextAlign.right,
                    // textAlignVertical: ,
                    decoration: InputDecoration(
                      hintText: "    قيمة المبلغ المراد سحبه ",
                      suffixIcon: const Icon(Icons.money),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: width * 0.01),
                      ),
                    ),
                    validator: (value) {
                  if (value!.isEmpty) {
                    return 'الحقل فارغ';
                  } else if (int.tryParse(value)!<=100&&int.tryParse(value)!>=2000000) {
                    return ' المبلغ يجب أن يكون بين 100 و 2000000';
                  } 
                },
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
                    return 'الكود فارغ';
                  } else if (!RegExp(r'^\d{6}$').hasMatch(value.trim())) {
                    return 'الكود يجب أن يتكون من ستة أرقام';
                  } else {
                    return null;
                  }
                },
                  ),
                  SizedBox(height: height * 0.05),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                    ),
                    child: const Text("  تأكيد العملية  "),
                    onPressed: () {
                       if (formKey.currentState!.validate()) {
                      Banknumber = _controller.text;
                      amountvalue = _controller2.text;
                      pin = _controller3.text;
                      model.withdrawFromBankBemo(
                          Banknumber, pin, amountvalue, context);
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
