import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wepay/Profile/information.dart';

import '../model/Profile.dart';
import 'security.dart';
import 'bank.dart';

int showChangePhoto = 2;

class ProfileMain extends StatelessWidget {
  const ProfileMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiProvider(providers: [
        ChangeNotifierProvider(create: (context) => ProfileProvider()),
      ], child: mainprofile()),
    );
  }
}

class mainprofile extends StatefulWidget {
  const mainprofile({super.key});

  @override
  State<mainprofile> createState() => _mainprofileState();
}

class _mainprofileState extends State<mainprofile> {
  @override
  XFile? _image;
  String IMAGE = "assets/1.png";

  final formKey = GlobalKey<FormState>();

  int i = 0;
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    var model = Provider.of<ProfileProvider>(context);
    if (i == 0) {
      model.getAllInfoUser(context);
      i++;
    }

    Future getImage() async {
      ImagePicker pick = new ImagePicker();
      var pickedFile = await pick.pickImage(source: ImageSource.gallery);
      setState(() {
        if (pickedFile != null) {
          _image = pickedFile;
          IMAGE = _image!.path;
          model.changeImage(IMAGE);
          //  model.updateImage();
        } else {}
      });
    }

    return Stack(
      children: [
        Positioned(
          top: height * 0.04,
          left: width * 0.1,
          child: InkWell(
            onTap: () {
              Navigator.of(context).pushNamed("generate");
            },
            child: Container(
              width: width * 0.15,
              height: height * 0.05,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 10,
                    offset: Offset(2, 4),
                  ),
                ],
                shape: BoxShape.circle,
                border: Border.all(
                  width: width * 0.01,
                  color: Color.fromARGB(250, 58, 165, 117),
                ),
                color: Color.fromARGB(250, 58, 165, 117),
              ),
              child: Icon(Icons.qr_code, color: Colors.white, size: 20.sp),
            ),
          ),
        ),
        Container(
            padding: EdgeInsets.only(
                right: width * 0.05, left: width * 0.05, top: height * 0.05),
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Form(
                key: formKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          flex: 3,
                          child: Center(
                              child: Stack(children: [
                            ClipOval(
                              child: _image != null
                                  ? Image.file(
                                      File(_image!.path),
                                      width: width * 0.4,
                                      height: height * 0.25,
                                      fit: BoxFit.cover,
                                    )
                                  : model.imageUser.isNotEmpty
                                      ? CircleAvatar(
                                          backgroundImage:
                                              NetworkImage(model.imageUser),
                                          radius: width * 0.2,
                                        )
                                      : Container(),
                            ),
                            Visibility(
                              visible: showChangePhoto == 2 ? true : false,
                              child: Positioned(
                                bottom: 0,
                                right: 0,
                                child: InkWell(
                                    onTap: () {
                                      getImage();
                                    },
                                    child: Container(
                                        width: width * 0.15,
                                        height: height * 0.06,
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                              spreadRadius: 3,
                                              blurRadius: 10,
                                              offset: Offset(2, 4),
                                            ),
                                          ],
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              width: width * 0.01,
                                              color: Colors.white),
                                          color:
                                              Color.fromARGB(250, 58, 165, 117),
                                        ),
                                        child: Icon(Icons.camera_alt,
                                            color: Colors.white))),
                              ),
                            ),
                          ]))),
                      SizedBox(height: height * 0.05),
                      Expanded(
                        flex: 9,
                        child: DefaultTabController(
                            initialIndex: 2,
                            length: 3,
                            child: Column(
                              children: [
                                TabBar(
                                    onTap: (value) {
                                      setState(() {
                                        showChangePhoto = value;
                                      });
                                    },
                                    labelColor:
                                        Color.fromARGB(250, 58, 165, 117),
                                    unselectedLabelColor: Colors.black,
                                    tabs: [
                                      Tab(text: "معلومات البنكية"),
                                      Tab(text: "الحماية والأمان"),
                                      Tab(text: "معلوماتي"),
                                    ]),
                                SizedBox(height: height * 0.03),
                                Expanded(
                                    flex: 4,
                                    child: Container(
                                      child: TabBarView(children: [
                                        bankprofile(),
                                        PassProfile(),
                                        ProfileBasic(),
                                      ]),
                                    ))
                              ],
                            )),
                      ),
                    ]),
              ),
            )),
      ],
    );
  }
}
