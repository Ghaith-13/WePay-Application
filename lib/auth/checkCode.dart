import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wepay/model/Sign_up_Icon.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class CheckCode extends StatefulWidget {
  const CheckCode({super.key});

  @override
  State<CheckCode> createState() => _CheckCodeState();
}

bool flag = false;

class _CheckCodeState extends State<CheckCode> {
  //Size width=MediaQuery.of(context).size;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
              child: Text(
            "Check your code",
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
                child: Column(children: [
                  Container(
                    margin: EdgeInsets.all(30.0.sp),
                    width: 400.0.w,
                    height: 150.0.h,
                    child: Image.asset('assets/forget.png'),
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(children: [
                      TextSpan(
                          text: "تم إرسال الكود إلى إيميلك\n ",
                          style: TextStyle(
                              color: Colors.black87, fontSize: 16.sp)),
                      TextSpan(
                          text: "ادخل الرقم لتتمكن من المتابعة ",
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 14.sp,
                          ))
                    ]),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: PinCodeTextField(
                      appContext: context,
                      length: 4,
                      onChanged: (value) {},
                      onCompleted: (value) {
                        flag = true;
                      },
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          activeColor: Colors.green,
                          inactiveColor: Colors.green,
                          selectedColor: Colors.red,
                          borderRadius: BorderRadius.circular(8.sp)),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(children: [
                          WidgetSpan(
                              child: GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .pushReplacementNamed("Sign_Up");
                            },
                            child: Text(
                              "أعد إرسالها",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 61, 65, 61),
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                        ]),
                      ),
                      SizedBox(width: 5),
                      Text("هل لم تستقبل الكود بعد؟",
                          style: TextStyle(
                              color: Colors.black87, fontSize: 14.sp)),
                    ],
                  ),
                  SizedBox(
                    height: 22.0.h,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                    ),
                    child: const Text("تابع"),
                    onPressed: () {
                      ;
                      flag
                          ? Navigator.of(context).pushReplacementNamed("bank")
                          : {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Text(
                                          "يجب إدخال الكود المرسل عبر إيميلك"))),
                            };
                    },
                  ),
                ]))));
  }
}
