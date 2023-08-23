import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:io';

import 'package:provider/provider.dart';

import '../../../model/Payment.dart';



class AlHaramDeposit extends StatefulWidget {
  const AlHaramDeposit({super.key});

  @override
  State<AlHaramDeposit> createState() => _AlHaramDepositState();
}

class _AlHaramDepositState extends State<AlHaramDeposit> {
  List<String> syrianCities = [
    'حسب المحافظة',
    'دمشق',
    'حلب',
    'حمص',
    'حماة',
    'طرطوس',
    'لاذقية',
    'دير الزور',
    'الرقة',
    'الحسكة',
    'ادلب',
    'السويداء',
    'القنيطرة',
    'درعا'
  ];
  File? image;
 String IMAGE = "assets/1.png";
 var city='حمص';
  Future pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) return;
    final imageTemp = File(image.path);
    setState(() => 
    {this.image = imageTemp,
     IMAGE = image!.path
    });
  }
late TextEditingController _controller;
  late TextEditingController _controller2;
  late TextEditingController _controller3;
  late TextEditingController _controller4;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    var model=Provider.of<depositandwithdraw>(context);
    final formKey = GlobalKey<FormState>();
    _controller = TextEditingController();
    _controller2 = TextEditingController();
    _controller3 = TextEditingController();
     _controller4= TextEditingController();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => depositandwithdraw(),
        )
      ],
      child: Container(
          padding: EdgeInsets.all(width*0.07),
          
          height: height,
          margin: EdgeInsets.only(
              left: width*0.05,  right: width*0.05),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(width*0.04)),
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
          child:
      
            Form(
              key:formKey,
           child: ListView(
              children: [
                 Row(
                   children: [
                     InkWell(
                      onTap: () {
                          Provider.of<depositandwithdraw>(context, listen: false)
                      .onClick(3);
                  Provider.of<depositandwithdraw>(context, listen: false)
                      .onClick2(2);
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Color.fromARGB(250, 58, 165, 117),
                      ),
                ),
                   ],
                 ),
                SizedBox(
                  width: width * 0.15,
                ),
                       Center(
                    child: Text(
                      "شركة الهرم للحوالات المالية",
                      style: TextStyle(
                          fontSize: width*0.05,
                          color: Color.fromARGB(255, 82, 173, 117),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height:height*0.013),
                  Center(
                    child: Text(
                      ": بيانات استقبال الرصيد",
                      style: TextStyle(
                          fontSize: width*0.04,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: height*0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                       Text(
                          "رونيا رفيق عودة",
                          style: TextStyle(
                            fontSize: width*0.04,
                            color: Colors.red,
                          ),
                        ),
                      
                       Text(
                          "اسم المستقبل",
                          style: TextStyle(
                            fontSize: width*0.04,
                            color: Colors.black,
                          ),
                        ),
                      
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                       Text(
                          "0981662881",
                          style: TextStyle(
                            fontSize: width*0.04,
                            color: Colors.red,
                          ),
                        ),
                      
                       Text(
                          ": رقم المستقبل ",
                          style: TextStyle(
                            fontSize: width*0.04,
                            color: Colors.black,
                          ),
                        ),
                      
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                       Text(
                          "  حمص  ",
                          style: TextStyle(
                           fontSize: width*0.04,
                            color: Colors.red,
                          ),
                        ),
                      
                       Text(
                          " : عنوان المستقبل",
                          style: TextStyle(
                           fontSize: width*0.04,
                            color: Colors.black,
                          ),
                        ),
                      
                    ],
                  ),
                  SizedBox(
                    height: height*0.06,
                  ),
                Container(
                  width: 350.0.w,
                  child: Column(
                    children: [
                      TextFormField(
                               controller: _controller,
                              maxLines: 1,
                              textAlign: TextAlign.right,
                              // textAlignVertical: ,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(top: height*0.03),
                                hintText: " اسم المرسل ",
                                suffixIcon: const Icon(Icons.person),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(width: width*0.02),
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
                                
                              }
                            },
                            
                            ),
                      SizedBox(
                        height: 10.0.h,
                      ),
                     IntlPhoneField(
                           controller: _controller2,
                          textAlign: TextAlign.right,
                          decoration: InputDecoration(
                            hintText: ' رقم المرسل',
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
                      DropdownButtonFormField(
                        
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          //<-- SEE HERE
                          borderSide: BorderSide(
                              color: Color.fromARGB(248, 100, 99, 99),
                              ),
                          ),
                      focusedBorder: OutlineInputBorder(
                          //<-- SEE HERE
                          borderSide: BorderSide(
                              color: Color.fromARGB(248, 80, 79, 79),
                              ),
                          ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    dropdownColor: Color.fromARGB(255, 253, 253, 253),
                    value: "حمص",
                    onChanged: (value) => {
                      city=value!
                    }, //Updatebycountrey(value!)},
                    iconDisabledColor:  Color.fromARGB(248, 80, 79, 79),
                    iconEnabledColor:  Color.fromARGB(248, 80, 79, 79),
                    items: syrianCities
                        .map<DropdownMenuItem<String>>((String value) {
                      // print(value);
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Center(
                          child: Text(
                            value,
                            style: TextStyle(
                                fontSize: width * 0.041,
                                fontWeight: FontWeight.bold,
                                color:  Color.fromARGB(248, 80, 79, 79)),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                        SizedBox(height: height*0.02),
                        TextFormField(
                           controller: _controller3,
                          maxLines: 1,
                          textAlign: TextAlign.right,
                          // textAlignVertical: ,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(top: height*0.03),
                            hintText: " قيمة المبلغ المرسل ",
                            suffixIcon: const Icon(Icons.money),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(width: width*0.02),
                            ),
                          ),
                            validator: (value) {
                  if (value!.isEmpty) {
                    return 'الحقل فارغ';
                  } else if (int.tryParse(value)!<=500&&int.tryParse(value)!>=2000000) {
                    return ' المبلغ يجب أن يكون بين 500 و 2000000';
                  } else {
                    return null;
                  }
                },
                        
                        ),
                        SizedBox(height: height*0.03),
                        TextFormField(
                           controller: _controller4,
                          // scrollPadding: EdgeInsets.only(bottom:40.sp),
                          maxLines: 1,
                          textAlign: TextAlign.right,
                          // textAlignVertical: ,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(top:  height*0.03),
                            hintText: " رقم عملية التحويل  ",
                            suffixIcon: const Icon(Icons.numbers),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(width:width*0.02),
                            ),
                          ),
                           validator: (value) {
                  if (value!.isEmpty) {
                    return 'الكود فارغ';
                  } else if (!RegExp(r'^\d{4}-\d{4}-\d{4}$').hasMatch(value.trim())) {
                    return '  ####-####-#### الكود يجب أن يتكون من ';
                  } else {
                    return null;
                  }
                },
                         
                        ),
                      SizedBox(
                        height: 30.0.h,
                      ),
                     
                      
                       Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                                onPressed: pickImage,
                                child: const Text('رفع ملف')),
                            SizedBox(
                              width: 10.0.h,
                            ),
                            Container(
                                width: 100.0.w,
                                height: 100.0.h,
                                child: image != null
                                    ? Image.file(image!)
                                    : Padding(
                                        padding: EdgeInsets.only(top: 43.0.h),
                                        child: Text("no image"),
                                      ))
                          ],
                        ),
                      
                      Divider(),
                      ElevatedButton(
                        onPressed: () {
                           if (formKey.currentState!.validate()) {
                              print("ppopofif");
                              model.depositeRequest("شحن-هرم", _controller2.text, _controller3.text, _controller4.text, context,image:IMAGE,city:city,SenderName:_controller.text);
                            }
                        },
                        child: Text("تأكيد"),
                      ),
                    ],
                  ),
                ),
              ],
            ))
          
        ));
      
    
  }
}
