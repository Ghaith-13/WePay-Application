import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:wepay/model/Budgetmangment.dart';
import 'package:wepay/model/Pay.dart';
import 'package:wepay/model/Payment.dart';
import 'package:wepay/model/Payment.dart';
import 'package:intl/intl.dart' as intl;

List PayType = ['قسط شهري', 'دين', 'دين لمتجر', 'مدفوعات أخرى'];

String? selectedValue;
String? selectedValue1;
bool flag = false;

class InsertPayment extends StatefulWidget {
  var model;
  InsertPayment({super.key, this.model});
  @override
  State<InsertPayment> createState() => _InsertPaymentState();
}

class _InsertPaymentState extends State<InsertPayment> {
  final formKey = GlobalKey<FormState>();
  bool flag = true;
  final TextEditingController edit = new TextEditingController();
  final FocusNode focuse = new FocusNode();
  TextEditingController dateinput = TextEditingController();
  TextEditingController _controller = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  TextEditingController _controller3 = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;

    return Scaffold(
        body: Container(
            padding: EdgeInsets.symmetric(horizontal: width * 0.01),
            width: width * 0.9,
            height: height * 0.75,
            margin: EdgeInsets.only(
                top: height * 0.15, left: width * 0.1, right: width * 0.1),
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
                  Row(
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.arrow_back)),
                      SizedBox(
                        width: width * 0.1,
                      ),
                      Text(
                        "إدخال المدفوعات المستحقة",
                        style: TextStyle(
                            fontSize: width * 0.05,
                            color: Colors.green,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.05),

                  DROPDOWN("نوع الدفعة", PayType, context),
                  SizedBox(height: height * 0.02),
                  Padding(
                    padding: EdgeInsets.all(width * 0.01),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _controller,

                      textDirection: TextDirection.rtl,
                      textInputAction: TextInputAction.done,
                      textAlign: TextAlign.right,

                      decoration: InputDecoration(
                        prefixIcon: IconButton(
                          icon: Icon(Icons.pin),
                          onPressed: () {},
                        ),
                        contentPadding: EdgeInsets.all(width * 0.01),
                        hintText: "قيمة الدفعة",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(width * 0.03)),
                      ),
                      validator: (value) {
                        if (value!.isEmpty || value == null) {
                          return ' الحقل غير مدخل';
                        }
                        {
                          return null;
                        }
                      },
                      // obscureText: ShowIcon2.check,
                    ),
                  ),
                  // SizedBox(height: height * 0.02),
                  // DROPDOWN("اختر المتجر", cites, context),
                  SizedBox(height: height * 0.02),
                  Padding(
                    padding: EdgeInsets.all(width * 0.01),
                    child: TextFormField(
                        textDirection: TextDirection.rtl,
                        textInputAction: TextInputAction.done,
                        textAlign: TextAlign.right,
                        controller:
                            dateinput, //editing controller of this TextField
                        decoration: InputDecoration(
                            //icon of text field
                            contentPadding: EdgeInsets.all(width * 0.01),
                            prefixIcon: IconButton(
                              icon: Icon(Icons.calendar_today),
                              onPressed: () {},
                            ),
                            hintText: "أدخل تاريخ آخرالدفع",
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(width * 0.03))),
                        readOnly:
                            true, //set it true, so that user will not able to edit text
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(
                                  2000), //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime(2101));

                          if (pickedDate != null) {
                            String formattedDate = intl.DateFormat('yyyy-MM-dd')
                                .format(pickedDate);

                            setState(() {
                              dateinput.text = formattedDate;
                            });
                          } else {
                            print("Date is not selected");
                          }
                        },
                        validator: (value) {
                          if (value!.isEmpty || value == null) {
                            return ' الحقل غير مدخل';
                          }
                          return null;
                        }),
                  ),
                  SizedBox(height: height * 0.02),

                  Padding(
                    padding: EdgeInsets.all(width * 0.01),
                    child: TextFormField(
                      controller: _controller2,
                      textDirection: TextDirection.rtl,
                      textInputAction: TextInputAction.done,
                      textAlign: TextAlign.right,
                      decoration: InputDecoration(
                        prefixIcon: IconButton(
                          icon: Icon(Icons.title),
                          onPressed: () {},
                        ),
                        contentPadding: EdgeInsets.all(width * 0.01),
                        hintText: "تفاصيل الدفعة",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(width * 0.03)),
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  Column(
                    children: [
                      Text("قابلة للدفع عن طريق موقعنا ؟"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: width * 0.3,
                            child: RadioListTile(
                              title: Text("نعم"),
                              value: "yes",
                              groupValue: widget.model.radiovalue,
                              onChanged: (value) {
                                setState(() {
                                  widget.model.radiovalue = value.toString();
                                });
                              },
                            ),
                          ),
                          Container(
                            width: width * 0.3,
                            child: RadioListTile(
                              title: Text("لا"),
                              value: "no",
                              groupValue: widget.model.radiovalue,
                              onChanged: (value) {
                                setState(() {
                                  widget.model.radiovalue = value.toString();
                                });
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Visibility(
                    visible: widget.model.radiovalue == "no" ? false : true,
                    child: Padding(
                      padding: EdgeInsets.all(width * 0.01),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: _controller3,

                        textDirection: TextDirection.rtl,
                        textInputAction: TextInputAction.done,
                        textAlign: TextAlign.right,

                        decoration: InputDecoration(
                          prefixIcon: IconButton(
                            icon: Icon(Icons.pin),
                            onPressed: () {},
                          ),
                          contentPadding: EdgeInsets.all(width * 0.01),
                          hintText: "كود التحويل",
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(width * 0.03)),
                        ),
                        validator: (value) {
                          if (value!.isEmpty || value == null) {
                            return ' الحقل غير مدخل';
                          }
                          {
                            return null;
                          }
                        },
                        // obscureText: ShowIcon2.check,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.2, vertical: height * 0.02),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                      ),
                      child: const Text("إدخال"),
                      onPressed: () {
                        widget.model.addPayment(
                            selectedValue,
                            _controller.text,
                            dateinput.text,
                            _controller2.text,
                            _controller3.text,
                            context);
                        // if (formKey.currentState!.validate()) {
                        //   const Snack =
                        //       SnackBar(content: Text("تم الإدخال بنجاح"));
                        //   ScaffoldMessenger.of(context).showSnackBar(Snack);
                        // }
                      },
                    ),
                  ),
                ],
              ),
            )));
  }
}

Widget DROPDOWN(String Label, List arr, context) {
  return Container(
    padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
    child: DropdownButtonFormField2(
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.zero,
        border: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(MediaQuery.of(context).size.width * 0.03),
        ),
      ),
      isExpanded: true,

      hint: Directionality(
        textDirection: TextDirection.rtl,
        child: Row(
          children: [
            SizedBox(width: 0),
            Text(
              "${Label}",
              textAlign: TextAlign.end,
              style:
                  TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04),
            ),
          ],
        ),
      ),

      items: arr
          .map((item) => DropdownMenuItem<String>(
                value: item,
                child: Center(
                  child: Text(
                    item,
                    textAlign: TextAlign.end,
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.04),
                  ),
                ),
              ))
          .toList(),
      validator: (value) {
        if (value == null) {
          return 'الحقل فارغ';
        }
        return null;
      },
      onChanged: (value) {
        selectedValue = value;
        //Do something when changing the item if you want.
      },
      onSaved: (value) {
        selectedValue1 = value.toString();
      },
      buttonStyleData: const ButtonStyleData(
        height: 55,
        padding: EdgeInsets.only(left: 20, right: 10),
      ),
      iconStyleData: const IconStyleData(
        icon: Icon(
          Icons.arrow_drop_down,
          color: Colors.black45,
        ),
        iconSize: 30,
      ),

      // dropdownDirection:TextDirection.rtl;
    ),
  );
}
