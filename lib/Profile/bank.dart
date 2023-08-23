import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:wepay/model/Profile.dart';

var haram, bemoBank, syriatelCash;

class bankprofile extends StatelessWidget {
  const bankprofile({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProfileProvider(),
        ),
      ],
      child: bankprofile2(),
    );
  }
}

class bankprofile2 extends StatefulWidget {
  const bankprofile2({super.key});

  @override
  State<bankprofile2> createState() => _bankprofile2State();
}

class _bankprofile2State extends State<bankprofile2> {
  @override
  XFile? _image;
  final formKey = GlobalKey<FormState>();
  late TextEditingController _controller;
  late TextEditingController _controller1;
  late TextEditingController _controller2;
  int i = 0;
  Widget build(BuildContext context) {
    var model = Provider.of<ProfileProvider>(context);
    if (i == 0) {
      model.getAllInfoUser(context);
      i++;
    }
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    _controller = TextEditingController();
    _controller1 = TextEditingController();
    _controller2 = TextEditingController();
    _controller.text = model.bemoBank;
    _controller1.text = model.haram;
    _controller2.text = model.syriatelCash;
    return Container(
        padding: EdgeInsets.symmetric(horizontal: width * 0.03),
        child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Form(
              key: formKey,
              child: ListView(children: [
                buildtextfield("بنك بيمو ", "riu23469", true, 1),
                buildtextfield("رقم استقبال الحوالات عن طريق الهرم",
                    "0981662881", true, 2),
                buildtextfield("SYRIATEL CASH", "0981662881", true, 3),
                //  buildtextfield("0981662881","الرقم",false,4),
                SizedBox(height: height * 0.05),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                  child: model.role == "user"
                      ? Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: width * 0.03),
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
                                          model.fetchDataForBank(haram,
                                              bemoBank, syriatelCash, context);
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
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.06),
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
                                    model.fetchDataForBank(
                                        haram, bemoBank, syriatelCash, context);
                                  }
                                },
                              ),
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
                right: MediaQuery.of(context).size.width * 0.01),
            labelText: label,
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
          validator: (value) {
            if (flag == 1) {
              if (value?.length != 7) return " ادخل سبع أرقام";

              bemoBank = value;
              return null;
            } else if (flag == 2) {
              final SyrianNum = RegExp(r'09\d{8}$');
              if (!SyrianNum.hasMatch(value!)) {
                return "أدخل الرقم سوري بشكل صحيح";
              }
              haram = value;
              return null;
            } else {
              final SyrianNum = RegExp(r'09\d{8}$');
              if (!SyrianNum.hasMatch(value!)) {
                return "أدخل الرقم سوري بشكل صحيح";
              }
              syriatelCash = value;
              return null;
            }
          },
        ));
  }
}
