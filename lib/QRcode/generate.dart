import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:provider/provider.dart';
import 'package:wepay/model/Profile.dart';

class GenerateCode extends StatelessWidget {
  const GenerateCode({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProfileProvider(),
        )
      ],
      child: GenerateCode2(),
    );
  }
}

class GenerateCode2 extends StatefulWidget {
  const GenerateCode2({super.key});

  @override
  State<GenerateCode2> createState() => _GenerateCode2State();
}

class _GenerateCode2State extends State<GenerateCode2> {
  @override
  int i = 0;
  Widget build(BuildContext context) {
    var model = Provider.of<ProfileProvider>(context);
    if (i == 0) {
      model.getAllInfoUser(context);
      i++;
    }
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
            padding: EdgeInsets.only(top: height * 0.015),
            child: Container(
              child: Center(
                  child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    Column(
                      children: [
                        model.imageUser == null
                            ? CircleAvatar(
                                radius: width * 0.15,
                              )
                            : CircleAvatar(
                                backgroundImage: NetworkImage(model.imageUser),
                                radius: width * 0.15,
                              ),
                        SizedBox(
                          height: height * 0.008,
                        ),
                        Text(model.firstna + " " + model.lastna,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: width * 0.09)),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.qr_code_scanner,
                              color: Color.fromARGB(255, 82, 173, 117),
                            ),
                            SizedBox(width: width * 0.01),
                            Text(
                              " رمز الخاص بك QrCode ",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 82, 173, 117),
                                  fontSize: width * 0.07),
                            ),
                          ],
                        ),
                      ],
                    ),
                    model.qrcode == ''
                        ? CircularProgressIndicator()
                        : BarcodeWidget(
                            barcode: Barcode.qrCode(
                              errorCorrectLevel: BarcodeQRCorrectionLevel.high,
                            ),
                            data: model.qrcode,
                            width: width * 0.7,
                            height: height * 0.3,
                          ),
                    SizedBox(height: height * 0.02),
                    SizedBox(
                      width: width * 0.7,
                      child: ElevatedButton(
                        onPressed: () async {
                          Navigator.of(context).pushNamed("ScanQr");
                        },

                        style: ElevatedButton.styleFrom(
                            side: BorderSide(
                              width: width * 0.01,
                              color: Color.fromARGB(255, 82, 173, 117),
                            ),
                            backgroundColor: Colors.white,
                            padding: const EdgeInsets.fromLTRB(5, 18, 5, 18),
                            shape: RoundedRectangleBorder(
                              // color:Color.fromARGB(255, 82, 173, 117),

                              borderRadius: BorderRadius.circular(width * 0.3),
                            )),

                        // color:Colors.white,

                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              " امسح الكود الخاص بك",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 82, 173, 117),
                                  fontWeight: FontWeight.bold,
                                  fontSize: width * 0.05),
                            ),
                            SizedBox(width: width * 0.02),
                            Icon(Icons.camera_alt_rounded,
                                color: Color.fromARGB(255, 82, 173, 117),
                                size: width * 0.1),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.numbers_sharp,
                          color: Color.fromARGB(255, 82, 173, 117),
                        ),
                        SizedBox(width: width * 0.01),
                        Text(
                          "أو قم بالاستعلام عن طريق الرقم التالي",
                          style: TextStyle(
                              color: Color.fromARGB(255, 82, 173, 117),
                              fontSize: width * 0.05),
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.02),
                    Container(
                      padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
                      child: Text(model.qrcode,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 82, 173, 117),
                        borderRadius: BorderRadius.circular(width * 0.3),
                      ),
                    ),
                  ])),
            )));
  }
}
