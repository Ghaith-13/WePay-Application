import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:wepay/model/Pay.dart';
import 'package:wepay/model/Payment.dart';
import 'package:wepay/model/Payment.dart';
import 'package:wepay/model/Payment.dart';

import '../../../model/Payment.dart';
import '../../../model/Payment.dart';

class rechargeSalary extends StatefulWidget {
  const rechargeSalary({super.key});

  @override
  State<rechargeSalary> createState() => _rechargeSalaryState();
}

class _rechargeSalaryState extends State<rechargeSalary> {
  depositandwithdraw x = new depositandwithdraw();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => depositandwithdraw(),
          )
        ],
        child: Container(
          padding: EdgeInsets.all(8.sp),
          width: 550.w,
          height: 250.h,
          margin: EdgeInsets.only(left: 15.w, top: 20.h, right: 15.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10.r)),
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
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
                    width: width * 0.15,
                  ),
                  Text(
                    "اختر طريقة الشحن المستخدمة",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12.sp,
                        color: Color.fromARGB(250, 58, 165, 117)),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              ElevatedButton(
                onPressed: () {
                  print("1");
                  // // depositandwithdraw.onClick(1);
                   Provider.of<depositandwithdraw>(context,listen:false).onClick(9);
                   Provider.of<depositandwithdraw>(context,listen:false).onClick2(4);
                },
                style: ElevatedButton.styleFrom(
                    side: BorderSide(
                      width: 4.0.w,
                      color: Color.fromARGB(250, 58, 165, 117),
                    ),
                    backgroundColor: Color.fromARGB(250, 58, 165, 117),
                    padding: EdgeInsets.only(
                        left: 55.sp, right: 55.sp, top: 10.sp, bottom: 10.sp),
                    shape: RoundedRectangleBorder(
                      // color:Colors.green,

                      borderRadius: BorderRadius.circular(20.0.r),
                    )),

                // color:Colors.white,

                child: Text(
                  " شركة الهرم للحوالات المالية",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              ElevatedButton(
                onPressed: () async {
                  Provider.of<depositandwithdraw>(context, listen: false)
                      .onClick(4);
                      Provider.of<depositandwithdraw>(context, listen: false)
                      .onClick2(4);
                  
                },
                style: ElevatedButton.styleFrom(
                    side: BorderSide(
                      width: 4.0.w,
                      color: Color.fromARGB(250, 58, 165, 117),
                    ),
                    backgroundColor: Color.fromARGB(250, 58, 165, 117),
                    padding: EdgeInsets.only(
                        left: 40.sp, right: 40.sp, top: 10.sp, bottom: 10.sp),
                    shape: RoundedRectangleBorder(
                      // color:Colors.green,

                      borderRadius: BorderRadius.circular(20.0.r),
                    )),

                // color:Colors.white,

                child: Text(
                  " SYRIATEL CASH سيرياتيل كاش",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              ElevatedButton(
                onPressed: () async {
                      Provider.of<depositandwithdraw>(context,listen:false).onClick(11);
                   Provider.of<depositandwithdraw>(context,listen:false).onClick2(4); 
                },
                style: ElevatedButton.styleFrom(
                    side: BorderSide(
                      width: 4.0.w,
                      color: Color.fromARGB(250, 58, 165, 117),
                    ),
                    backgroundColor: Color.fromARGB(250, 58, 165, 117),
                    padding: EdgeInsets.only(
                        left: 60.sp, right: 60.sp, top: 10.sp, bottom: 10.sp),
                    shape: RoundedRectangleBorder(
                      // color:Colors.green,

                      borderRadius: BorderRadius.circular(20.0.r),
                    )),

                // color:Colors.white,

                child: Text(
                  "بنك بيمو الفرنسي السعودي",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ));
  }
}
