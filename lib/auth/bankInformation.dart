import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wepay/model/Sign_up_Icon.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class BankInf extends StatefulWidget {
  const BankInf({super.key});

  @override
  State<BankInf> createState() => _BankInfState();
}

class _BankInfState extends State<BankInf> {
  final formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final _passwordController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ShowIcon()),
          ChangeNotifierProvider(create: (context) => ShowIcon2())
        ],
        child: Scaffold(
          appBar: AppBar(
            title: Center(
                child: Text(
              "المعلومات البنكية",
              style: TextStyle(fontSize: 30.0.sp),
            )),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(50.r),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(20.sp),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 55.0.sp, top: 1.0.sp),
                    width: 400.0.w,
                    height: 140.0.h,
                    child: Image.asset('assets/forget.png'),
                  ),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          textAlign: TextAlign.right,
                          // textAlignVertical: ,
                          decoration: InputDecoration(
                            hintText: "اسم الحساب في بنك بيمو",
                            suffixIcon: const Icon(Icons.near_me),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(width: 1.0.w),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty || value == null) {
                              return 'الاسم فارغ';
                            } else if (!RegExp(r'^[a-z A-Z]+$')
                                .hasMatch(value)) {
                              return 'ادخل الاسم الصحيح';
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: 7.h,
                        ),
                        TextFormField(
                          textAlign: TextAlign.right,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            suffixIcon: const Icon(Icons.pin),
                            hintText: "رقم الحساب في بنك بيمو",
                            border: OutlineInputBorder(
                              borderSide: BorderSide(width: 1.0.w),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty || value == null) {
                              return 'رقم الحساب فارغ';
                            } else if (value.length != 8) {
                              return 'رقم الحساب غير صحيح';
                            }
                            {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: 7.h,
                        ),
                        IntlPhoneField(
                          textAlign: TextAlign.right,
                          decoration: InputDecoration(
                            hintText: 'رقم الحوالات من الهرم',
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
                        SizedBox(
                          height: 7.h,
                        ),
                        IntlPhoneField(
                          textAlign: TextAlign.right,
                          decoration: InputDecoration(
                            hintText: 'Syriatel Cash رقم',
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
                        SizedBox(
                          height: 7.h,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 23.0.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                        ),
                        child: const Text("حفظ المعلومات"),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            const Snack = SnackBar(
                                content:
                                    Text("تم حفظ المعلومات البنكية بنجاح"));
                            ScaffoldMessenger.of(context).showSnackBar(Snack);
                            Navigator.of(context)
                                .pushReplacementNamed("checkCode");
                          }
                        },
                      ),
                      SizedBox(width: 100.w),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Color.fromARGB(255, 117, 117, 74)),
                        child: const Text("تخطي"),
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacementNamed("Participants");
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
