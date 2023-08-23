import 'dart:ui';

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wepay/BudgetMangment/BudgetManagement.dart';
import 'package:wepay/QRcode/generate.dart';
import 'package:wepay/auth/Log_in.dart';
import 'package:wepay/model/Budgetmangment.dart';
import 'package:wepay/model/Main.dart';

import 'Participants/LastTranstion.dart';
import 'model/Profile.dart';
import 'model/pages.dart';
//import 'package:wepay/QRcode/scan.dart';

class Pages extends StatefulWidget {
  const Pages({super.key});

  @override
  State<Pages> createState() => _PagesState();
}

class _PagesState extends State<Pages> {
  @override
  int i = 0;

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    var model = Provider.of<ProfileProvider>(context);
    var model2 = Provider.of<ModelForName>(context);
    if (i == 0) {
      model.getAllInfoUser(context);
      i++;
    }
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ConvertPages(),
        ),
        ChangeNotifierProvider(
          create: (context) => budgetmanage(),
        ),
        ChangeNotifierProvider(
          create: (context) => tab2model(),
        ),
        ChangeNotifierProvider(
          create: (context) => tab3model(),
        ),
      ],
      child: Scaffold(
        endDrawer: Consumer<ConvertPages>(
          builder: (context, ConvertPages, child) {
            return Drawer(
              child: Column(
                children: [
                  UserAccountsDrawerHeader(
                    currentAccountPicture: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Center(
                        child: Text(
                          model.firstna.isEmpty ? "" : "${model.firstna[0]}",
                          style: TextStyle(
                            fontSize: 30.0.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    accountName: Text(
                      model.firstna != null
                          ? "${model.firstna} ${model.lastna} "
                          : "",
                      style: TextStyle(fontSize: 15.0.sp),
                    ),
                    accountEmail: Text(
                      model.email == null ? "" : model.email,
                      style: TextStyle(fontSize: 13.0.sp),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 420.0.h,
                    child: Padding(
                      padding: EdgeInsets.only(right: 10.0.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                " رصيد حسابي : ${model.balance} ل.س",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Divider(),
                              ListTile(
                                title: Padding(
                                  padding: EdgeInsets.only(top: 10.0.h),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      "الملف الشخصي",
                                      style: TextStyle(fontSize: 12.0.sp),
                                    ),
                                  ),
                                ),
                                trailing: Icon(
                                  Icons.person,
                                  color: Color.fromARGB(255, 82, 173, 117),
                                  size: 30.0.sp,
                                ),
                                onTap: () => ConvertPages.goToProfile(context),
                              ),
                              ListTile(
                                title: Padding(
                                  padding: EdgeInsets.only(top: 10.0.h),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      "إدارة الميزانية",
                                      style: TextStyle(fontSize: 12.0.sp),
                                    ),
                                  ),
                                ),
                                trailing: Icon(
                                  Icons.attach_money,
                                  color: Color.fromARGB(255, 82, 173, 117),
                                  size: 30.0.sp,
                                ),
                                onTap: () =>
                                    ConvertPages.goToBudgetMangment(context),
                              ),
                              ListTile(
                                title: Padding(
                                  padding: EdgeInsets.only(top: 10.0.h),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      "الوكلاء",
                                      style: TextStyle(fontSize: 12.0.sp),
                                    ),
                                  ),
                                ),
                                trailing: Icon(
                                  Icons.people,
                                  color: Color.fromARGB(255, 82, 173, 117),
                                  size: 30.0.sp,
                                ),
                                onTap: () => ConvertPages.goToContact(context),
                              ),
                              ListTile(
                                title: Padding(
                                  padding: EdgeInsets.only(top: 10.0.h),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      " مسح الكود",
                                      style: TextStyle(fontSize: 12.0.sp),
                                    ),
                                  ),
                                ),
                                trailing: Icon(
                                  Icons.qr_code_scanner,
                                  color: Color.fromARGB(255, 82, 173, 117),
                                  size: 30.0.sp,
                                ),
                                onTap: () => ConvertPages.goToQrCode(context),
                              ),
                              ListTile(
                                title: Padding(
                                  padding: EdgeInsets.only(top: 10.0.h),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      "المشتركون ",
                                      style: TextStyle(fontSize: 12.0.sp),
                                    ),
                                  ),
                                ),
                                trailing: Icon(
                                  Icons.people,
                                  color: Color.fromARGB(255, 82, 173, 117),
                                  size: 30.0.sp,
                                ),
                                onTap: () =>
                                    ConvertPages.goToParticipants(context),
                              ),
                              ListTile(
                                title: Padding(
                                  padding: EdgeInsets.only(top: 10.0.h),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      "التحويل",
                                      style: TextStyle(fontSize: 12.0.sp),
                                    ),
                                  ),
                                ),
                                trailing: Icon(
                                  Icons.payments,
                                  color: Color.fromARGB(255, 82, 173, 117),
                                  size: 30.0.sp,
                                ),
                                onTap: () => ConvertPages.goToDepost(context),
                              ),
                            ],
                          ),
                          ListTile(
                            title: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "تسجيل خروج ",
                                style: TextStyle(fontSize: 12.0.sp),
                              ),
                            ),
                            trailing: Icon(
                              Icons.logout,
                              color: Color.fromARGB(255, 82, 173, 117),
                              size: 30.0.sp,
                            ),
                            onTap: () => {model2.logout(context)},
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        appBar: AppBar(
          centerTitle: true,
          title: Consumer<ConvertPages>(
            builder: (context, ConvertPages, child) {
              return Text(
                ConvertPages.Title,
                style: TextStyle(fontSize: width * 0.075, color: Colors.white),
              );
            },
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(width * 0.05),
            ),
          ),
        ),
        bottomNavigationBar: Consumer<ConvertPages>(
          builder: (context, ConvertPages, child) {
            return ConvexAppBar(
              height: height * 0.065,
              backgroundColor: Color.fromARGB(250, 58, 165, 117),
              items: const [
                TabItem(icon: Icons.attach_money, title: 'إدارة الميزانية'),
                TabItem(icon: Icons.people, title: 'الوكلاء'),
                TabItem(icon: Icons.qr_code_scanner, title: 'مسح الكود'),
                TabItem(icon: Icons.people, title: 'المشتركون'),
                TabItem(icon: Icons.payments, title: 'التحويل'),
              ],
              initialActiveIndex: 2,
              onTap: (int i) => {
                ConvertPages.onClick2(i),
              },
            );
          },
        ),
        body: Consumer<ConvertPages>(builder: (context, ConvertPages, child) {
          return ConvertPages.nameOfPage;
        }),
      ),
    );
  }
}
