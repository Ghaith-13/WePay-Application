import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wepay/Contact/AddDealer.dart';
import '../../model/ListOfcontacts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/Contact.dart';

class Contact extends StatefulWidget {
  const Contact({super.key});

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => SearchProvider()),
    ], child: dellers());
  }
}

class dellers extends StatefulWidget {
  const dellers({super.key});

  @override
  State<dellers> createState() => _dellers();
}

class _dellers extends State<dellers> {
  var _controller = TextEditingController();
  String countreyValue = 'حسب المحافظة';
  final keyIsFirstLoaded = 'is_first_loaded';
  bool _isInitComplete = false;
  @override
  void initState() {
    super.initState();
  }

  var i = 0;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    var model = Provider.of<SearchProvider>(context);
    int y = 1;

    if (i == 0) {
      // SearchProvider x = new SearchProvider(context);
      model.fetchData(context);
      i = i + 1;
    }

    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    return Scaffold(
        floatingActionButton: Visibility(
          visible: model.role == 'admin' ? true : false,
          child: FloatingActionButton(
            backgroundColor: Colors.white,
            onPressed: () {
              Navigator.push(
                  context,
                  PageRouteBuilder(
                    transitionDuration: const Duration(milliseconds: 600),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return ScaleTransition(
                        alignment: Alignment.center,
                        scale: animation,
                        child: child,
                      );
                    },
                    pageBuilder: (context, animation, secondaryAnimation) {
                      return AddDealer();
                    },
                  ));
            },
            child: Icon(
              Icons.add,
              color: Color.fromARGB(250, 58, 165, 117),
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(0.025 * width),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Consumer<SearchProvider>(builder: (context, searchProvider, _) {
                  return Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color.fromARGB(255, 120, 220, 175),
                          Color.fromARGB(255, 30, 84, 59),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(width * 0.05),
                    ),
                    margin: EdgeInsets.symmetric(vertical: height * 0.005),
                    child: SizedBox(
                      width: width,
                      child: TextField(
                        cursorColor: Colors.white,
                        textAlign: TextAlign.right,
                        controller: _controller,
                        onChanged: (value) => {
                          searchProvider.filterData(value),
                          searchProvider.ChooseValue = value
                        },
                        maxLines: 1,
                        decoration: InputDecoration(
                          prefixStyle: TextStyle(color: Colors.white),
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(width * 0.05),
                              borderSide: BorderSide(
                                  width: width * 0.001, color: Colors.white)),
                          hintText: "",
                          alignLabelWithHint: false,
                          hintStyle: TextStyle(color: Colors.grey.shade500),
                          prefixIcon: IconButton(
                              onPressed: () {
                                searchProvider.clear();
                                _controller.text = "";
                              },
                              icon: Icon(Icons.close)),
                          prefixIconColor: Colors.white,
                          suffixIcon: Icon(Icons.search),
                          suffixIconColor: Colors.white,
                        ),
                      ),
                    ),
                  );
                }),
                // Text("sdjdh"),
                Consumer<SearchProvider>(builder: (context, searchProvider, _) {
                  return DropdownButtonFormField(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          //<-- SEE HERE
                          borderSide: BorderSide(
                              color: Color.fromARGB(250, 58, 165, 117),
                              width: 2),
                          borderRadius: BorderRadius.circular(width * 0.05)),
                      focusedBorder: OutlineInputBorder(
                          //<-- SEE HERE
                          borderSide: BorderSide(
                              color: Color.fromARGB(250, 58, 165, 117),
                              width: 2),
                          borderRadius: BorderRadius.circular(width * 0.05)),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    dropdownColor: Color.fromARGB(255, 253, 253, 253),
                    value: countreyValue,
                    onChanged: (value) => {
                      searchProvider.Updatebycountrey(value!)
                    }, //Updatebycountrey(value!)},
                    iconDisabledColor: Color.fromARGB(250, 58, 165, 117),
                    iconEnabledColor: Color.fromARGB(250, 58, 165, 117),
                    items: searchProvider.syrianCities
                        .map<DropdownMenuItem<String>>((String value) {
                      // print(value);
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Center(
                          child: Text(
                            value,
                            style: TextStyle(
                                fontSize: width * 0.041,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(250, 58, 165, 117)),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                }),

                SizedBox(
                  height: height * 0.02,
                ),
                Consumer<SearchProvider>(builder: (context, searchProvider, _) {
                  return Expanded(
                    child: searchProvider.display_List == null
                        ? Center(
                            child: Lottie.asset('./assets/Loading Files.json'),
                          )
                        : searchProvider.display_List.length == 0
                            ? Center(
                                child: Lottie.asset('./assets/one.json'),
                              )
                            : GridView.builder(
                                padding: EdgeInsets.only(top: height * 0.02),
                                itemCount: searchProvider.display_List.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 50,
                                  childAspectRatio: (width / height) / 0.7,
                                ),
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    padding: EdgeInsets.all(width * 0.01),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Visibility(
                                          visible:
                                              searchProvider.display_List[index]
                                                          ["dealerImgURL"] ==
                                                      null
                                                  ? false
                                                  : true,
                                          child: CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                '${searchProvider.display_List[index]["dealerImgURL"]}'),
                                            radius: width * 0.09,
                                          ),
                                        ),
                                        RichText(
                                            textAlign: TextAlign.center,
                                            text: TextSpan(children: [
                                              TextSpan(
                                                  text: searchProvider
                                                              .display_List[
                                                          index]["fullName"] +
                                                      "\n",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: width * 0.05,
                                                  )),
                                              TextSpan(
                                                  text: searchProvider
                                                              .display_List[
                                                          index]["city"] +
                                                      " - " +
                                                      searchProvider
                                                              .display_List[
                                                          index]["address"] +
                                                      "\n",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: width * 0.05,
                                                  )),
                                              TextSpan(
                                                  text: searchProvider
                                                          .display_List[index]
                                                      ["phoneNumber"],
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: width * 0.05,
                                                      fontWeight:
                                                          FontWeight.bold))
                                            ])),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(width: width * 0.01),
                                            ElevatedButton(
                                              onPressed: () async {
                                                launch("tel://" +
                                                    searchProvider
                                                            .display_List[index]
                                                        ["phoneNumber"]);
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  side: BorderSide(
                                                    width: width * 0.02,
                                                    color: Color.fromARGB(
                                                        255, 243, 245, 243),
                                                  ),
                                                  backgroundColor:
                                                      Color.fromARGB(
                                                          255, 255, 255, 255),
                                                  padding: EdgeInsets.all(
                                                      width * 0.03),
                                                  shape: RoundedRectangleBorder(
                                                    // color:Color.fromARGB(250, 58, 165, 117),

                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            width * 0.05),
                                                  )),

                                              // color:Colors.white,

                                              child: Text(
                                                "اتصال",
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 58, 165, 117)),
                                              ),
                                            ),
                                            SizedBox(width: width * 0.01),
                                            ElevatedButton(
                                              onPressed: () async {
                                                launch("sms://" +
                                                    searchProvider
                                                            .display_List[index]
                                                        ["phoneNumber"]);
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  side: BorderSide(
                                                    width: width * 0.02,
                                                    color: Color.fromARGB(
                                                        255, 243, 245, 243),
                                                  ),
                                                  backgroundColor:
                                                      Color.fromARGB(
                                                          255, 255, 255, 255),
                                                  padding: EdgeInsets.all(
                                                      width * 0.03),
                                                  shape: RoundedRectangleBorder(
                                                    // color:Color.fromARGB(250, 58, 165, 117),

                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            width * 0.05),
                                                  )),

                                              // color:Colors.white,

                                              child: Text(
                                                "رسالة",
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 58, 165, 117)),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),

                                    // height: height * 0.6,
                                    margin: EdgeInsets.symmetric(
                                        horizontal: width * 0.01),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Color.fromARGB(255, 120, 220, 175),
                                          Color.fromARGB(255, 30, 84, 59),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(width * 0.05)),
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
                                  ); ////
                                }),
                  );
                })
              ]),
        ));
  }
}
