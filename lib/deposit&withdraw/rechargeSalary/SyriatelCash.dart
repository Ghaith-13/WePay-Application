import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:wepay/model/Pay.dart';
import 'package:wepay/model/Payment.dart';
import 'package:wepay/model/Payment.dart';



class SyriatelCash extends StatefulWidget {
  const SyriatelCash({super.key});

  @override
  State<SyriatelCash> createState() => _SyriatelCashState();
}

class _SyriatelCashState extends State<SyriatelCash> {
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
          
          height: height*0.76,
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
                      "SYRIATEL CASH-سيرياتيل كاش",
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
                          "  حساب تاجر , الدفع يدوي  ",
                          style: TextStyle(
                           fontSize: width*0.04,
                            color: Colors.red,
                          ),
                        ),
                      
                       Text(
                          " : نوع حساب المستقبل",
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
                        IntlPhoneField(
                          controller: _controller,
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
                            print(phone.completeNumber);
                          },
                          onCountryChanged: (country) {
                            print('Country changed to: ' + country.name);
                          },
                        ),
                        SizedBox(height: height*0.02),
                        TextFormField(
                          controller: _controller2,
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
                  } else if (int.tryParse(value)!<=100&&int.tryParse(value)!>=250000) {
                    return ' المبلغ يجب أن يكون بين 100 و 250000';
                  } else {
                    return null;
                  }
                },
                        
                        ),
                        SizedBox(height: height*0.03),
                        TextFormField(
                          controller: _controller3,
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
                  } else if (!RegExp(r'^\d{12}$').hasMatch(value.trim())) {
                    return 'الكود يجب أن يتكون من 12  أرقام';
                  } else {
                    return null;
                  }
                },
                         
                        ),
                        SizedBox(height: height*0.07),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                          ),
                          child: const Text("  تأكيد العملية  "),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              print("ppopofif");
                             model.depositeRequest("شحن-كاش", _controller.text, _controller2.text, _controller3.text, context);
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
