import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:wepay/model/Pay.dart';
import 'package:wepay/model/Payment.dart';
import 'package:wepay/model/Payment.dart';



class bemoDeposit extends StatefulWidget {
  const bemoDeposit({super.key});

  @override
  State<bemoDeposit> createState() => _bemoDepositState();
}

class _bemoDepositState extends State<bemoDeposit> {
  final formKey = GlobalKey<FormState>();
  bool flag = true;
  final TextEditingController edit = new TextEditingController();
  final FocusNode focuse = new FocusNode();
  late TextEditingController _controller;
  late TextEditingController _controller2;
  late TextEditingController _controller3;

  @override
  void initState() {
    super.initState();
    focuse.addListener(() {
      if (!focuse.hasFocus) {
        setState(() {
          flag = false;
        });
      }
    });
  }
var numberPhone,transNumber,transValue;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    var model=Provider.of<depositandwithdraw>(context);
   _controller = TextEditingController();
    _controller2 = TextEditingController();
    _controller3 = TextEditingController();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => depositandwithdraw(),
        )
      ],
      child:  Container(
          padding: EdgeInsets.all(height*0.007),
          
          height: height*0.7,
          margin: EdgeInsets.only(
              left: width*0.05, top: height*0.14, right: width*0.05),
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
          child:  Form(
            key:formKey,
            child: ListView(
                //  crossAxisAlignment: CrossAxisAlignment.center,
                //  mainAxisAlignment: MainAxisAlignment.start,
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
                      " بنك بيمو السعودي الفرنسي",
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
                          "عبير شمس الدين",
                          style: TextStyle(
                            fontSize: width*0.04,
                            color: Colors.red,
                          ),
                        ),
                      
                       Text(
                          ": اسم المستقبل ",
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
                          " 12345567 ",
                          style: TextStyle(
                           fontSize: width*0.04,
                            color: Colors.red,
                          ),
                        ),
                      
                       Text(
                          " : رقم حساب بنك بيمو للمستقبل",
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
                    margin: EdgeInsets.only(right: width*0.05, left: width*0.05),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                    
                       
                        TextFormField(
                          controller: _controller,
                          // scrollPadding: EdgeInsets.only(bottom:40.sp),
                          maxLines: 1,
                          textAlign: TextAlign.right,
                          // textAlignVertical: ,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(top:  height*0.03),
                            hintText: " اسم المرسل  ",
                            suffixIcon: const Icon(Icons.person),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(width:width*0.02),
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
                        SizedBox(height: height*0.02),
                         TextFormField(
                          controller: _controller2,
                          // scrollPadding: EdgeInsets.only(bottom:40.sp),
                          maxLines: 1,
                          textAlign: TextAlign.right,
                          // textAlignVertical: ,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(top:  height*0.03),
                            hintText: " رقم حساب بنك بيمو للمرسل  ",
                            suffixIcon: const Icon(Icons.numbers),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(width:width*0.02),
                            ),
                          ),
                           validator: (value) {
                  if (value!.isEmpty) {
                    return 'الكود فارغ';
                  } else if (value.trim().length<7) {
                    return '  7 الكود يجب أن يتكون من ';
                  } else {
                    return null;
                  }
                },
                         
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
                  } else if (int.tryParse(value)!<=100&&int.tryParse(value)!>=2000000) {
                    return ' المبلغ يجب أن يكون بين 100 و 2000000';
                  } 
                },
                        
                        ),
                         SizedBox(height: height*0.04),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                          ),
                          child: const Text("  تأكيد العملية  "),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              print("ppopofif");
                              print(_controller3.text);
                             model.depositeRequestforbemo("شحن-بيمو", _controller.text, _controller2.text, _controller3.text, context);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
          ),
          ),
        
      
    );
  }
}
