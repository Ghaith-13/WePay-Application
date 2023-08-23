import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:wepay/model/Pay.dart';

import '../../model/Payment.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  static List<Pay> main_List = [
    Pay("شحن", "رصيد الحساب", "300000", DateTime.now()),
    Pay("شحن", "رصيد الحساب", "300000", DateTime.now()),
    Pay("شحن", "رصيد الحساب", "300000", DateTime.now()),
    Pay("شحن", "رصيد الحساب", "300000", DateTime.now()),
    // Pay("شحن", "رصيد الحساب", "300000", DateTime.now()),
  ];
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
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Consumer<depositandwithdraw>(
          builder: (context, depositandwithdraw, child) {
            return SingleChildScrollView(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    depositandwithdraw.nameOfPage,
                    SizedBox(
                      height: height * 0.03,
                    ),
                    depositandwithdraw.nameOfPage2
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
