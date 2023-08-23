import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:wepay/model/Main.dart';
import 'package:wepay/model/Sign_up_Icon.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:quickalert/quickalert.dart';

GlobalKey<FormState> formKey = GlobalKey<FormState>();
late SharedPreferences SharedStorage;

Future<void> _initPrefs() async {
  SharedStorage = await SharedPreferences.getInstance();
}

class Log_In extends StatelessWidget {
  const Log_In({super.key});

  @override
  Widget build(BuildContext context) {
    _initPrefs();

    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    final _passwordController = TextEditingController();

    var email, password, pin;
    bool Showsnack = false;
    var model = Provider.of<ModelForName>(context);
    Future<void> fetchData(
      String email,
      String password,
      String pin,
    ) async {
      print(email);
      print(password);
      print(pin);
      final url = Uri.parse(
          'https://wepay-ali-aldayoub.onrender.com/api/v1.0/auth/login');
      try {
        final response = await http.post(
          url,
          body: {"email": email, "password": password, "pin": pin},
        );

        if (response.statusCode == 200) {
          // Signup successful
          model.convertIsenable();

          print('login successful!');
          // Store token in shared preferences
          String token = jsonDecode(response.body)['token'];
          String role = jsonDecode(response.body)['role'];
          await SharedStorage.setString('token', token);
          await SharedStorage.setString('role', role);
          Showsnack = true;
          Navigator.of(context).pushReplacementNamed("Pages");
        } else {
          model.convertIsenable();

          // login failed
          print('login failed!');
          String msg = jsonDecode(response.body)['message'];
          var Snack = SnackBar(
              content: Container(
            child: Text(
              msg,
              style: TextStyle(color: Colors.red),
            ),
          ));
          ScaffoldMessenger.of(context).showSnackBar(Snack);
        }
      } catch (error) {
        model.convertIsenable();

        // Handle connection error
        QuickAlert.show(
          animType: QuickAlertAnimType.slideInDown,
          widget: Lottie.asset('./assets/failed.json',
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height * 0.07),
          confirmBtnText: 'حسناً',
          confirmBtnColor: Colors.red,
          context: context,
          type: QuickAlertType.error,
          title: 'عذراً',
          titleColor: Color.fromARGB(255, 190, 49, 38),
          text: 'نعتذر منك ,لا يوجد اتصال في الانترنت يرجى المحاولة لاحقاً',
        );
        print('Error connecting to server: $error');
      }
    }

    return ChangeNotifierProvider(
      create: (context) {
        return ShowIcon();
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "تسجيل الدخول",
            style: TextStyle(fontSize: width * 0.08),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(width * 0.08),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(width * 0.1),
            child: Column(
              children: [
                Container(
                    width: width * 0.9,
                    height: height * 0.3,
                    child: Lottie.asset('assets/login.json')),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        textAlign: TextAlign.right,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          suffixIcon: const Icon(Icons.email),
                          hintText: "البريد الالكتروني",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(width: width * 0.05),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty || value == null) {
                            return 'البريد الالكتروني فارغ';
                          } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}')
                              .hasMatch(value)) {
                            return 'البريد الالكتروني غير صحيح';
                          }
                          {
                            email = value;
                          }
                        },
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Consumer<ShowIcon>(
                        builder: (context, ShowIcon, child) {
                          return TextFormField(
                            textAlign: TextAlign.right,
                            // controller: _passwordController,
                            decoration: InputDecoration(
                              prefixIcon: IconButton(
                                icon: ShowIcon.eye,
                                onPressed: () {
                                  ShowIcon.changeIcon();
                                },
                              ),
                              suffixIcon: const Icon(Icons.lock),
                              hintText: "كلمة المرور",
                              border: OutlineInputBorder(
                                borderSide: BorderSide(width: width * 0.05),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty || value == null) {
                                return 'كلمة المرور غير مدخلة';
                              } else if (value.length < 8) {
                                return 'طول كلمة المرور أٌقل من 8 محارف';
                              } else {
                                password = value;
                              }
                            },
                            obscureText: ShowIcon.check,
                          );
                        },
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      TextFormField(
                        textAlign: TextAlign.right,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          suffixIcon: const Icon(Icons.pin),
                          hintText: " pin رقم ال",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(width: width * 0.05),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty || value == null) {
                            return 'الحقل فارغ';
                          } else {
                            pin = value;
                          }
                        },
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .pushReplacementNamed("ForgetPass");
                            },
                            child: const Text(
                              "نسيت كلمة المرور؟",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 123, 124, 123),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.009,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .pushReplacementNamed("Sign_Up");
                            },
                            child: const Text(
                              " سجل الآن",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 69, 151, 110),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(width: 3.w),
                          Text(
                            textAlign: TextAlign.right,
                            " ليس لديك حساب ؟",
                            style: TextStyle(fontSize: width * 0.045),
                          ),
                          SizedBox(
                            width: width * 0.002,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.05,
                ),

                //  SizedBox(width:30.w),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                  ),
                  child: model.isEnable
                      ? Container(
                          child: Lottie.asset('assets/3dots.json',
                              width: width * 0.15, height: height * 0.05))
                      : const Text("سجل دخول "),
                  onPressed: model.isEnable
                      ? null
                      : () {
                          if (formKey.currentState!.validate()) {
                            model.convertIsenable();

                            fetchData(email, password, pin);
                            // Navigator.of(context).pushReplacementNamed("checkCode");
                          }
                        },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
