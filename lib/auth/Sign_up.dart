import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:wepay/model/Main.dart';
import 'package:wepay/model/Sign_up_Icon.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class sign_Up extends StatefulWidget {
  const sign_Up({super.key});

  @override
  State<sign_Up> createState() => _sign_UpState();
}

class _sign_UpState extends State<sign_Up> {
  final formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final _passwordController = TextEditingController();

  late SharedPreferences SharedStorage;

  Future<void> _initPrefs() async {
    SharedStorage = await SharedPreferences.getInstance();
  }

  var firstName,
      middleName,
      lastName,
      username,
      email,
      phonenumber,
      password,
      pin;

  bool Showsnack = false;

  void initState() {
    super.initState();
    _initPrefs();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var model = Provider.of<ModelForName>(context);
    Future<void> fetchData(
        String username,
        String firstname,
        String lastname,
        String middlename,
        String hash,
        String phonenumber,
        String email,
        String password) async {
      final url = Uri.parse(
          'https://wepay-ali-aldayoub.onrender.com/api/v1.0/auth/signup');
      try {
        final response = await http.post(
          url,
          body: {
            'firstName': firstname,
            'lastName': lastname,
            'middleName': middlename,
            'email': email,
            'userName': username,
            'phoneNumber': phonenumber,
            'password': password,
            'pin': hash,
          },
        );
        model.convertIsenable();
        if (response.statusCode == 201) {
          // Signup successful
          print('Signup successful!');

          // Store token in shared preferences
          String token = jsonDecode(response.body)['token'];
          String role = jsonDecode(response.body)['role'];
          await SharedStorage.setString('token', token);
          await SharedStorage.setString('role', role);

          Showsnack = true;
          Navigator.of(context).pushReplacementNamed("Pages");
        } else {
          // Signup failed
          print('Signup failed!');
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
        // Handle connection error
        print('Error connecting to server: $error');
      }
    }

    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ShowIcon()),
        ChangeNotifierProvider(create: (context) => ShowIcon2())
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Center(
              child: Text(
            " إنشاء حساب ",
            style: TextStyle(fontSize: width * 0.08),
          )),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(width * 0.08),
            ),
          ),
        ),
        body: ListView(
          children: [
            Center(
              child: Container(
                padding: EdgeInsets.all(width * 0.1),
                child: Column(
                  children: [
                    SizedBox(height: height * 0.05),
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            keyboardType: TextInputType.text,
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                            textInputAction: TextInputAction.done,
                            // textAlignVertical: ,
                            decoration: InputDecoration(
                              hintText: "الاسم الثلاثي الكامل",
                              suffixIcon: const Icon(Icons.person),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(width: width * 0.05),
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
                                firstName = split[0];
                                middleName = split[1];
                                lastName = split[2];
                              }
                            },
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                            textInputAction: TextInputAction.done,
                            // textAlignVertical: ,
                            decoration: InputDecoration(
                              hintText: "اسم المستخدم",
                              suffixIcon: const Icon(Icons.person),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(width: width * 0.05),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty || value == null) {
                                return 'الاسم فارغ';
                              } else if (!RegExp(r'^[ا-يa-z A-Z]+$')
                                  .hasMatch(value)) {
                                return 'ادخل الاسم الصحيح (يحتوي محارف)';
                              } else {
                                var split = value.trim().split(' ');
                                username = value;
                              }
                            },
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          TextFormField(
                            textDirection: TextDirection.rtl,
                            textInputAction: TextInputAction.done,
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
                              } else if (!RegExp(
                                      r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}')
                                  .hasMatch(value)) {
                                return 'البريد الالكتروني غير صحيح';
                              } else {
                                email = value;
                              }
                            },
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
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
                              phonenumber = phone.completeNumber;
                              phonenumber = phonenumber.substring(4);
                            },
                            onCountryChanged: (country) {},
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          Consumer<ShowIcon>(
                            builder: (context, ShowIcon, child) {
                              return TextFormField(
                                keyboardType: TextInputType.text,
                                textDirection: TextDirection.rtl,
                                textInputAction: TextInputAction.done,
                                textAlign: TextAlign.right,
                                controller: _passwordController,
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
                                    return null;
                                  }
                                },
                                obscureText: ShowIcon.check,
                              );
                            },
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          Consumer<ShowIcon2>(
                            builder: (context, ShowIcon2, child) {
                              return TextFormField(
                                keyboardType: TextInputType.text,
                                textDirection: TextDirection.rtl,
                                textInputAction: TextInputAction.done,
                                textAlign: TextAlign.right,
                                decoration: InputDecoration(
                                  prefixIcon: IconButton(
                                    icon: ShowIcon2.eye,
                                    onPressed: () {
                                      ShowIcon2.changeIcon();
                                    },
                                  ),
                                  suffixIcon: const Icon(Icons.lock),
                                  hintText: "تأكيد كلمة المرور",
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(width: width * 0.05),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty || value == null) {
                                    return 'كلمة المرور غير مدخلة';
                                  } else if (value.length < 8) {
                                    return 'طول كلمة المرور أٌقل من 8 محارف';
                                  } else if (value !=
                                      _passwordController.text) {
                                    return "غير متطابقة مع كلمة المرور";
                                  } else {
                                    password = value;
                                  }
                                },
                                obscureText: ShowIcon2.check,
                              );
                            },
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,

                            textDirection: TextDirection.rtl,
                            textInputAction: TextInputAction.done,
                            textAlign: TextAlign.right,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(Icons.pin),
                                onPressed: () {},
                              ),
                              hintText: "PIN ادخل ",
                              border: OutlineInputBorder(
                                borderSide: BorderSide(width: width * 0.05),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty || value == null) {
                                return ' الحقل غير مدخل';
                              } else if (value.length < 4) {
                                return ' يجب أن يكون 4 أو أكثرPIN طول';
                              } else {
                                pin = value;
                              }
                            },
                            // obscureText: ShowIcon2.check,
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
                                      .pushReplacementNamed("Log_In");
                                },
                                child: const Text(
                                  "سجل دخول",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 69, 151, 110),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(width: width * 0.01),
                              Text(
                                textAlign: TextAlign.right,
                                "ًَإذا لديك حساب مسبقا",
                                style: TextStyle(fontSize: width * 0.05),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                      ),
                      child: model.isEnable
                          ? Container(
                              child: Lottie.asset('assets/3dots.json',
                                  width: width * 0.15, height: height * 0.05))
                          : const Text("تسجيل دخول"),
                      onPressed: model.isEnable
                          ? null
                          : () {
                              if (formKey.currentState!.validate()) {
                                model.convertIsenable();
                                fetchData(
                                    username,
                                    firstName,
                                    lastName,
                                    middleName,
                                    pin,
                                    phonenumber,
                                    email,
                                    password);
                              }
                            },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//--------------------------------------------//
