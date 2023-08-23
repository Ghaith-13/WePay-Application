import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:wepay/model/Sign_up_Icon.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class InsertNewPasswordPage extends StatefulWidget {
  @override
  _InsertNewPasswordPageState createState() => _InsertNewPasswordPageState();
}

class _InsertNewPasswordPageState extends State<InsertNewPasswordPage> {
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    final controller = TextEditingController();
    bool flag=false;
    @override
    void dispose() {
      // TODO: implement dispose
      super.dispose();
      controller.dispose();
    }

    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ShowIcon()),
          ChangeNotifierProvider(create: (context) => Visible1()),
          ChangeNotifierProvider(create: (context) => Visible()),
          ChangeNotifierProvider(create: (context) => ShowIcon2())
        ],
        child: Scaffold(
          body: Center(
            child: ListView(
              children: [
                Container(
                  padding: EdgeInsets.all(20.sp),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            right: 20.0.sp, top: 30.0.sp, left: 20.sp),
                        width: 400.0.w,
                        height: 260.0.h,
                        child: Image.asset('assets/forget.png'),
                      ),
                      Form(
                          key: formKey,
                          child: Column(children: [
                            Consumer<Visible>(
                                builder: (context, visible, child) {
                              return !visible.vis
                                  ? TextFormField(
                                    
                             
                                textDirection:TextDirection.rtl,
                                textInputAction:TextInputAction.done,
                                      textAlign: TextAlign.right,
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                        suffixIcon: const Icon(Icons.email),
                                        hintText: "البريد الالكتروني",
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(width: 1.0.w),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty || value == null) {
                                          return 'البريد الالكتروني فارغ';
                                        } else if (!RegExp(
                                                r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}')
                                            .hasMatch(value)) {
                                          return 'البريد الالكتروني غير صحيح';
                                        }
                                        {
                                          return null;
                                        }
                                      },
                                    )
                                  : Consumer<Visible1>(
                                      builder: (context, visible1, child) {
                                      return !visible1.vis1
                                          ? Column(
                                            children: [
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                          horizontal: 30.0),
                                                  child: PinCodeTextField(
                                                    appContext: context,
                                                    length: 4,
                                                    onChanged: (value) {},
                                                    onCompleted: (value) {
                                                    
                                                       flag=true;
                                                      
                                                    },
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter
                                                          .digitsOnly
                                                    ],
                                                    pinTheme: PinTheme(
                                                        shape:
                                                            PinCodeFieldShape.box,
                                                        activeColor: Colors.green,
                                                        inactiveColor: Colors.green,
                                                        selectedColor: Colors.red,
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                8.sp)),
                                                  ),
                                                ),
                                            ],
                                          )
                                          : Text("");
                                    });
                            }),
                            Consumer<Visible1>(
                                builder: (context, visible1, child) {
                              return visible1.vis1
                                  ? Column(
                                      children: [
                                        Consumer<ShowIcon>(
                                          builder: (context, ShowIcon, child) {
                                            return TextFormField(
                                              textAlign: TextAlign.right,
                                              controller: controller,
                                              decoration: InputDecoration(
                                                prefixIcon: IconButton(
                                                  icon: ShowIcon.eye,
                                                  onPressed: () {
                                                    ShowIcon.changeIcon();
                                                  },
                                                ),
                                                suffixIcon:
                                                    const Icon(Icons.lock),
                                                hintText:
                                                    " كلمة المرور الجديدة",
                                                border: OutlineInputBorder(
                                                  borderSide:
                                                      BorderSide(width: 1.0.w),
                                                ),
                                              ),
                                              validator: (value) {
                                                if (value!.isEmpty ||
                                                    value == null) {
                                                  return 'كلمة المرور غير مدخلة';
                                                } else if (value.length < 8) {
                                                  return 'طول كلمة المرور أٌقل من 8 محارف';
                                                } else {
                                                  return null;
                                                }
                                              },
                                              obscureText: ShowIcon.check,
                                            );
                                          },
                                        ),
                                        SizedBox(
                                          height: 7.h,
                                        ),
                                        Consumer<ShowIcon2>(
                                          builder: (context, ShowIcon2, child) {
                                            return TextFormField(
                                              textAlign: TextAlign.right,
                                              decoration: InputDecoration(
                                                prefixIcon: IconButton(
                                                  icon: ShowIcon2.eye,
                                                  onPressed: () {
                                                    ShowIcon2.changeIcon();
                                                  },
                                                ),
                                                suffixIcon:
                                                    const Icon(Icons.lock),
                                                hintText:
                                                    " تأكيد كلمة المرور الجديدة",
                                                border: OutlineInputBorder(
                                                  borderSide:
                                                      BorderSide(width: 1.0.w),
                                                ),
                                              ),
                                              validator: (value) {
                                                if (value!.isEmpty ||
                                                    value == null) {
                                                  return 'كلمة المرور غير مدخلة';
                                                } else if (value.length < 8) {
                                                  return 'طول كلمة المرور أٌقل من 8 محارف';
                                                } else if (value !=
                                                    controller.text) {
                                                  return "غير متطابقة مع كلمة المرور";
                                                }
                                                {
                                                  return null;
                                                }
                                              },
                                              obscureText: ShowIcon2.check,
                                            );
                                          },
                                        ),
                                        SizedBox(
                                          height: 7.h,
                                        ),
                                      ],
                                    )
                                  : Text("");
                            })
                          ])),
                      SizedBox(
                        height: 18.0.h,
                      ),
                      Consumer<Visible>(builder: (context, visible, child) {
                        return !visible.vis
                            ? ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                ),
                                child: const Text("أرسل الكود"),
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    visible.changeVis();
                                 
                                    // Navigator.of(context)
                                    //     .pushReplacementNamed("checkCode");
                                  }
                                },
                              )
                            : Consumer<Visible1>(
                                builder: (context, visible1, child) {
                                return !visible1.vis1
                                    ? ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          foregroundColor: Colors.white,
                                        ),
                                        child: const Text("تأكيد الكود"),
                                        onPressed: () {
                                       
                                         flag? visible1.changeVis(): { 
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                        backgroundColor:Colors.red,
                                        content: Text("يجب إدخال الكود المرسل عبر إيميلك"))),};
                                       
                                        },
                                      )
                                    : ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          foregroundColor: Colors.white,
                                        ),
                                        child: const Text("تأكيد كلمة السر"),
                                        onPressed: () {
                                        
                                         
                                         
                                        },
                                      );
                              });
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
