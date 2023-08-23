import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:wepay/Contact/AddDealer.dart';

import '../model/Profile.dart';

var FirstName;
var MiddleName;
var LastName;
var UserName;
var Usernumber;

class ProfileBasic extends StatelessWidget {
  const ProfileBasic({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => ProfileProvider()),
    ], child: profile());
  }
}

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  @override
  XFile? _image;
  String IMAGE = "assets/1.png";
  final formKey = GlobalKey<FormState>();
  late TextEditingController _controller;
  late TextEditingController _controller1;
  late TextEditingController _controller2;
  var model;
  int i = 0;
  Widget build(BuildContext context) {
    var model = Provider.of<ProfileProvider>(context);
    if (i == 0) {
      model.getAllInfoUser(context);
      i++;
    }
    _controller = TextEditingController();
    _controller1 = TextEditingController();
    _controller2 = TextEditingController();
    _controller.text =
        model.firstna + " " + model.middlena + " " + model.lastna;
    _controller1.text = model.username;
    _controller2.text = model.userNumber;

// Set the value of the controller
    model.view = true;
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return Container(
        padding: EdgeInsets.symmetric(horizontal: width * 0.03),
        child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Form(
              key: formKey,
              child: ListView(children: [
                buildtextfield(" ${model.firstna} ", "الاسم الكامل", true, 1),
                buildtextfield("${model.username}", " اسم المستخدم", true, 2),
                buildtextfield("${model.userNumber}", "الرقم", true, 4),
                SizedBox(height: height * 0.05),
                model.role == "user"
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
                                        model.fetchDataForInfo(
                                            FirstName,
                                            MiddleName,
                                            LastName,
                                            UserName,
                                            Usernumber,
                                            context);
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
                                  model.fetchDataForInfo(FirstName, MiddleName,
                                      LastName, UserName, Usernumber, context);
                                }
                              },
                            ),
                          ),
                        ),
                      ),
              ]),
            )));
  }

  Widget buildtextfield(
      String label, String PlaceHolder, bool isPass, int flag) {
    return Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
        child: TextFormField(
          controller: flag == 1
              ? _controller
              : flag == 2
                  ? _controller1
                  : _controller2,
          //  initialValue: label,
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
            labelText: PlaceHolder,
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
          validator: (value) {
            if (flag == 1) {
              if (!RegExp(r'^[ا-يa-z A-Z]+$').hasMatch(value!)) {
                return 'ادخل الاسم الصحيح (يحتوي محارف)';
              } else if (value.trim().split(' ').length != 3) {
                return "ادخل الاسم الثلاثي ";
              } else {
                var arrNames = value.trim().split(' ');
                FirstName = arrNames[0];
                MiddleName = arrNames[1];
                LastName = arrNames[2];
                return null;
              }
            } else if (flag == 2) {
              if (value!.isEmpty || value == null) {
                return 'املأ الحقل';
              }
              {
                UserName = value;
                return null;
              }
            } else if (flag == 4) {
              final SyrianNum = RegExp(r'09\d{8}$');

              if (!SyrianNum.hasMatch(value!)) {
                return "أدخل الرقم سوري بشكل صحيح";
              }
              Usernumber = value;
              return null;
            }
          },
        ));
  }
}
