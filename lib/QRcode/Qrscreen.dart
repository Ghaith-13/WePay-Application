import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../Pages.dart';
import '../model/pages.dart';
import 'generate.dart';

class QrScreen extends StatefulWidget {
  const QrScreen({super.key});

  @override
  State<QrScreen> createState() => _QrScreenState();
}

class _QrScreenState extends State<QrScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => ConvertPages(),
          ),
        ],
        child: SingleChildScrollView(
          child: Container(
            child: Center(
              child: Container(
                margin: EdgeInsets.only(bottom: 60.0.sp),
                padding: EdgeInsets.all(8.sp),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 20.h),
                      Image.asset('assets/4.png'),
                      SizedBox(height: 60.0.h),
                      SizedBox(
                        width: 350,
                        child: ElevatedButton(
                          onPressed: () async {
                            // Navigator.of(context).push(
                            Navigator.of(context).pushNamed("ScanQr");
                            //     MaterialPageRoute(builder: (context) => ScanCode()));
                          },

                          style: ElevatedButton.styleFrom(
                              side: const BorderSide(
                                width: 4.0,
                                color: Color.fromARGB(250, 58, 165, 117),
                              ),
                              backgroundColor: Colors.white,
                              padding: const EdgeInsets.fromLTRB(4, 20, 10, 20),
                              shape: RoundedRectangleBorder(
                                // color:Color.fromARGB(250, 58, 165, 117),

                                borderRadius: BorderRadius.circular(20.0),
                              )),

                          // color:Colors.white,

                          child: Text(
                            "QR مسح رمز",
                            style: TextStyle(
                                color: Color.fromARGB(250, 58, 165, 117),
                                fontWeight: FontWeight.bold,
                                fontSize: 18.sp),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0.h),
                      SizedBox(
                        width: 350,
                        child: Consumer<ConvertPages>(
                            builder: (context, ConvertPages, child) {
                          return ElevatedButton(
                            onPressed: () async {
                              ConvertPages.onClick2(-2);
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => GenerateCode()));
                            },

                            style: ElevatedButton.styleFrom(
                                side: const BorderSide(
                                  width: 4.0,
                                  color: Color.fromARGB(250, 58, 165, 117),
                                ),
                                backgroundColor: Colors.white,
                                padding:
                                    const EdgeInsets.fromLTRB(4, 20, 10, 20),
                                shape: RoundedRectangleBorder(
                                  // color:Color.fromARGB(250, 58, 165, 117),

                                  borderRadius: BorderRadius.circular(20.0),
                                )),

                            // color:Colors.white,

                            child: Text(
                              "QR إنشاء رمز ",
                              style: TextStyle(
                                  color: Color.fromARGB(250, 58, 165, 117),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.sp),
                            ),
                          );
                        }),
                      ),
                    ]),
              ),
            ),
          ),
        ));
  }
}
