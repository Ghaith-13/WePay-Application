import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:io';

class AlHaramDeposit extends StatefulWidget {
  const AlHaramDeposit({super.key});

  @override
  State<AlHaramDeposit> createState() => _AlHaramDepositState();
}

class _AlHaramDepositState extends State<AlHaramDeposit> {
  File? image;
  Future pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) return;
    final imageTemp = File(image.path);
    setState(() => this.image = imageTemp);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/Logo.png',
                width: 250.0,
                height: 150.0,
                color: Colors.white,
              ),
            ],
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(25.r),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 15.0.h, bottom: 35.0.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Please Fill This Fields",
                    style: TextStyle(
                        fontSize: 25.0.sp, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            Container(
              width: 350.0.w,
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person),
                      label: const Text("Sender's full name"),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1.0.w),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0.h,
                  ),
                  IntlPhoneField(
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
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
                    height: 30.0.h,
                  ),
                  Text(
                    "Put the transfer number or take a photo of it",
                    style: TextStyle(
                        fontSize: 17.0.sp, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 20.0.h,
                  ),
                  Container(
                    width: 200.0,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.change_circle_outlined),
                        label: const Text("The Number"),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 1.0.w),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 50.0.w),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: pickImage,
                            child: const Text('Select file')),
                        SizedBox(
                          width: 10.0.h,
                        ),
                        Container(
                            width: 150.0.w,
                            height: 100.0.h,
                            child: image != null
                                ? Image.file(image!)
                                : Padding(
                                    padding: EdgeInsets.only(top: 43.0.h),
                                    child: Text("no image"),
                                  ))
                      ],
                    ),
                  ),
                  Divider(),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text("Next"),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
