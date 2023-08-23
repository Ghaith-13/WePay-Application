import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:wepay/model/Profile.dart';

var oldPass, newPass, Pin;

class PassProfile extends StatelessWidget {
  const PassProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProfileProvider(),
        ),
      ],
      child: PassProfile2(),
    );
  }
}

class PassProfile2 extends StatefulWidget {
  const PassProfile2({super.key});

  @override
  State<PassProfile2> createState() => _PassProfileState();
}

class _PassProfileState extends State<PassProfile2> {
  @override
  XFile? _image;
  String IMAGE = "assets/1.png";
  bool isObscurepass = true;
  final _passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  int i = 0;
  Widget build(BuildContext context) {
    var model = Provider.of<ProfileProvider>(context);
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    if (i == 0) {
      model.getAllInfoUser(context);
      i++;
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: width * 0.03),
      child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Form(
            key: formKey,
            child: ListView(children: [
              buildtextfield("كلمة المرور الحالية", true, 1),
              buildtextfield("كلمة المرور الجديدة", true, 2),
              buildtextfield("إعادة كتابة المرور الجديدة", true, 3),
              buildtextfield("PIN", true, 4),
              SizedBox(height: height * 0.01),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                child: model.role == "user"
                    ? Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.5),
                                      spreadRadius: 3,
                                      blurRadius: 10,
                                      offset: Offset(2, 4),
                                    ),
                                  ],
                                  borderRadius:
                                      BorderRadius.circular(width * 0.3),
                                  gradient: const LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Color.fromARGB(255, 204, 204, 204),
                                      Color.fromARGB(255, 79, 78, 78),
                                    ],
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width * 0.06),
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.transparent),
                                      elevation: MaterialStateProperty.all(0),
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              width * 0.3),
                                        ),
                                      ),
                                    ),
                                    child: const Text("ترقية لتاجر"),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushReplacementNamed("upgrade");
                                    },
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.5),
                                      spreadRadius: 3,
                                      blurRadius: 10,
                                      offset: Offset(2, 4),
                                    ),
                                  ],
                                  borderRadius:
                                      BorderRadius.circular(width * 0.3),
                                  gradient: const LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Color.fromARGB(255, 120, 220, 175),
                                      Color.fromARGB(255, 30, 84, 59),
                                    ],
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width * 0.06),
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.transparent),
                                      elevation: MaterialStateProperty.all(0),
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              width * 0.3),
                                        ),
                                      ),
                                    ),
                                    child: const Text("حفظ"),
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        model.fetchDataForSecruity(
                                            oldPass, newPass, Pin, context);
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ]),
                      )
                    : Center(
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                spreadRadius: 3,
                                blurRadius: 10,
                                offset: Offset(2, 4),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(width * 0.3),
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color.fromARGB(255, 120, 220, 175),
                                Color.fromARGB(255, 30, 84, 59),
                              ],
                            ),
                          ),
                          child: Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: width * 0.06),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.transparent),
                                elevation: MaterialStateProperty.all(0),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(width * 0.3),
                                  ),
                                ),
                              ),
                              child: const Text("حفظ"),
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  model.fetchDataForSecruity(
                                      oldPass, newPass, Pin, context);
                                }
                              },
                            ),
                          ),
                        ),
                      ),
              ),
            ]),
          )),
    );
  }

  Widget buildtextfield(String label, bool isPass, int flag) {
    return Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
        child: TextFormField(
            controller: flag == 2 ? _passwordController : null,
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide:
                    BorderSide(width: MediaQuery.of(context).size.width * 0.01),
              ),
              prefixIcon: isPass
                  ? IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.edit, color: Colors.grey))
                  : null,
              contentPadding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.01,
                  right: MediaQuery.of(context).size.width * 0.02),
              labelText: label,
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
            validator: (value) {
              if (flag == 1) {
                if (value!.length < 8) {
                  return 'طول كلمة المرور أٌقل من 8 محارف';
                } else {
                  oldPass = value;
                  return null;
                }
              }
              if (flag == 2) {
                if (value!.length < 8 && value != null && value.isNotEmpty) {
                  return 'طول كلمة المرور أٌقل من 8 محارف';
                } else {
                  return null;
                }
              } else if (flag == 3) {
                if (value!.length < 8 && value != null && value.isNotEmpty) {
                  return 'طول كلمة المرور أٌقل من 8 محارف';
                } else if (value != _passwordController.text) {
                  return "غير متطابقة مع كلمة المرور";
                } else {
                  newPass = value;
                  return null;
                }
              } else if (flag == 4) {
                if (value!.length < 4 && value != null && value.isNotEmpty) {
                  return 'يجب أن يكون طول ال PIN يساوي أربعة';
                } else {
                  Pin = value;
                  return null;
                }
              }
            }));
  }
}
