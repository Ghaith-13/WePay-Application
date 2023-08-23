import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:wepay/model/Pay.dart';
import 'package:wepay/model/Payment.dart';
import 'package:wepay/model/Payment.dart';

import 'mainPage/FirstPage.dart';

class SyriatelCash extends StatefulWidget {
  const SyriatelCash({super.key});

  @override
  State<SyriatelCash> createState() => _SyriatelCashState();
}

class _SyriatelCashState extends State<SyriatelCash> {
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

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => depositandwithdraw(),
        )
      ],
      child: Expanded(
        flex: 60,
        child: Container(
          padding: EdgeInsets.all(10.sp),
          width: 550.w,
          height: 250.h,
          margin: EdgeInsets.only(
              left: 15.w, top: 60.h, right: 15.w, bottom: 50.sp),
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
          child: Flexible(
            child: ListView(
              //  crossAxisAlignment: CrossAxisAlignment.center,
              //  mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "SYRIATEL CASH-سيرياتيل كاش",
                    style: TextStyle(
                        fontSize: 14.sp,
                        color: Color.fromARGB(255, 82, 173, 117),
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 10.h),
                Center(
                  child: Text(
                    ": بيانات استقبال الرصيد",
                    style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 4.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        "0981662881",
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        ": رقم المستقبل ",
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        "  حساب تاجر , الدفع يدوي  ",
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        " : نوع حساب المستقبل",
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30.h,
                ),
                Container(
                  margin: EdgeInsets.only(right: 20.sp, left: 20.sp),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IntlPhoneField(
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
                      SizedBox(height: 10.h),
                      TextFormField(
                        maxLines: 1,
                        textAlign: TextAlign.right,
                        // textAlignVertical: ,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(top: 10.sp),
                          hintText: "    قيمة المبلغ المرسل ",
                          suffixIcon: const Icon(Icons.money),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1.0.w),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty || value == null) {
                            return 'الاسم فارغ';
                          } else if (!RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                            return 'ادخل الاسم الصحيح';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(height: 10.h),
                      TextFormField(
                        // scrollPadding: EdgeInsets.only(bottom:40.sp),
                        maxLines: 1,
                        textAlign: TextAlign.right,
                        // textAlignVertical: ,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(top: 10.sp),
                          hintText: " رقم عملية التحويل  ",
                          suffixIcon: const Icon(Icons.numbers),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1.0.w),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty || value == null) {
                            return 'الاسم فارغ';
                          } else if (!RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                            return 'ادخل الاسم الصحيح';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(height: 20.h),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                        ),
                        child: const Text("  تأكيد العملية  "),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            const Snack = SnackBar(
                                content: Text("تم تسجيل الدخول بنجاح"));
                            ScaffoldMessenger.of(context).showSnackBar(Snack);
                            Navigator.of(context)
                                .pushReplacementNamed("checkCode");
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
