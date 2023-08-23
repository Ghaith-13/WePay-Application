import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:wepay/QRcode/ScanQr.dart';
import 'package:wepay/model/Payment.dart';

String amountValue = '', pin = '';

class PaymentAndTrans extends StatefulWidget {
  const PaymentAndTrans({super.key});

  @override
  State<PaymentAndTrans> createState() => _PaymentAndTransState();
}

class _PaymentAndTransState extends State<PaymentAndTrans> {
  // final formKey = GlobalKey<FormState>();
  bool flag = true;
  final TextEditingController edit = new TextEditingController();

  final FocusNode focuse = new FocusNode();

  String? selectedValue;

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

  int i = 0;
  var barcodeScanRes;
  final formKey = GlobalKey<FormState>();
  late TextEditingController _controller;
  late TextEditingController _controller2;
  late TextEditingController _controller3;
  late TextEditingController _controller4;

  @override
  Widget build(BuildContext context) {
    var model = Provider.of<depositandwithdraw>(context);

    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    _controller = TextEditingController();
    _controller2 = TextEditingController();
    _controller3 = TextEditingController();
    _controller4 = TextEditingController();
    // _controller.text = model.Qrcode != null ? model.Qrcode : '';
    // _controller2.text = model.Qrcode != null ? model.Qrcode : '';

    // barcodeScanRes = model.getbarcodeScanResFromSharedPreferences();

    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => depositandwithdraw(),
          )
        ],
        child: Container(
          padding: EdgeInsets.all(width * 0.01),
          width: width * 0.9,
          height: height * 0.65,
          margin: EdgeInsets.symmetric(
              horizontal: width * 0.05, vertical: height * 0.1),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(width * 0.03)),
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
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                SizedBox(
                  height: height * 0.02,
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Provider.of<depositandwithdraw>(context, listen: false)
                            .onClick2(1);
                        Provider.of<depositandwithdraw>(context, listen: false)
                            .onClick(8);
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Color.fromARGB(250, 58, 165, 117),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.25,
                    ),
                    Text(
                      " الدفع والتحويل ",
                      style: TextStyle(
                          fontSize: width * 0.05,
                          color: Color.fromARGB(250, 58, 165, 117),
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: height * 0.05),
                  ],
                ),
                SizedBox(height: height * 0.02),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                  child: TextFormField(
                    controller: _controller,
                    //model.Qrcode == null ? null : '${model.Qrcode}'
                    scrollPadding: EdgeInsets.only(bottom: height * 0.01),
                    maxLines: 1,
                    textAlign: TextAlign.right,
                    // textAlignVertical: ,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(top: height * 0.01),
                      hintText: " كود التحويل",
                      suffixIcon: const Icon(Icons.numbers),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: width * 0.01),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'الكود فارغ';
                      } else if (!RegExp(r'^\d{6}$').hasMatch(value.trim())) {
                        return 'الكود يجب أن يتكون من ستة أرقام';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                SizedBox(height: height * 0.02),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                  child: TextFormField(
                    controller: _controller2,
                    scrollPadding: EdgeInsets.only(bottom: height * 0.01),
                    maxLines: 1,
                    textAlign: TextAlign.right,
                    // textAlignVertical: ,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(top: height * 0.01),
                      hintText: " تأكيد كود التحويل",
                      suffixIcon: const Icon(Icons.numbers),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: width * 0.01),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty || value == null) {
                        return 'الحقل فارغ';
                      } else if (!RegExp(r'^\d{6}$').hasMatch(value.trim())) {
                        return 'الكود يجب أن يتكون من ستة أرقام';
                      } else if (value != _controller.text) {
                        return "غير متطابقة مع  كود التحويل";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                SizedBox(height: height * 0.02),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                  child: TextFormField(
                    controller: _controller3,
                    maxLines: 1,
                    textAlign: TextAlign.right,
                    // textAlignVertical: ,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(top: height * 0.01),
                      hintText: "    قيمة المبلغ المرسل ",
                      suffixIcon: const Icon(Icons.money),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: width * 0.01),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'الحقل فارغ';
                      } else if (int.tryParse(value)! < 100000) {
                        return 'المبلغ لا يقل عن 100000';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                SizedBox(height: height * 0.02),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                  child: TextFormField(
                      maxLines: 1,
                      textAlign: TextAlign.right,
                      // textAlignVertical: ,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top: height * 0.01),
                        hintText: "تأكيد قيمة المبلغ",
                        suffixIcon: const Icon(Icons.location_on),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: width * 0.01),
                        ),
                      ),
                      onChanged: ((value) {
                        amountValue = value;
                        print(amountValue);
                      }),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'الحقل فارغ';
                        } else if (int.tryParse(value)! < 100000) {
                          return 'المبلغ لا يقل عن 100000';
                        } else if (int.tryParse(value) !=
                            int.tryParse(_controller3.text)) {
                          return "غير متطابقة مع الملبغ المدخل";
                        } else {
                          return null;
                        }
                      }),
                ),
                SizedBox(height: height * 0.02),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                  child: Container(
                    width: width * 0.9,
                    child: TextFormField(
                        controller: _controller4,
                        maxLines: 1,
                        textAlign: TextAlign.right,
                        // textAlignVertical: ,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(top: height * 0.01),
                          hintText: "PIN ادخل رمز ال",
                          suffixIcon: const Icon(Icons.pin),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(width: width * 0.01),
                          ),
                        ),
                        onChanged: ((value) {
                          pin = value;
                        }),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'الحقل فارغ';
                          } else if (value.length < 4) {
                            return 'الحقل يتكون من أربعة أرقام';
                          } else {
                            return null;
                          }
                        }),
                  ),
                ),
                SizedBox(height: height * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // SizedBox(width:40.w),
                    // flag?Text("fALSE"):Icon(Icons.done,size:width*0.07,color:Colors.red,),
                    //  SizedBox(Width:10.w),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                      ),
                      child: const Text("  ادفع الآن  "),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          amountValue = _controller3.text;
                          pin = _controller4.text;

                          model.transferMoney(
                              amountValue, pin, context, 1, _controller.text);
                        }
                      },
                    ),
                    //  SizedBox(width:110.w),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                      ),
                      child: const Text("مسح الكود"),
                      onPressed: () {
                        // model.scan();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
