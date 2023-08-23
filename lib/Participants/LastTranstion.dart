// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:wepay/model/ForMap.dart';

import '../model/ListOfcontacts.dart';
class Sellers extends StatelessWidget {
  const Sellers({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => Formap()),
        ],
        child:LastTranstion());
  }
}
class LastTranstion extends StatefulWidget {
  const LastTranstion({super.key});

  @override
  State<LastTranstion> createState() => _LastTranstionState();
}

class _LastTranstionState extends State<LastTranstion> {
  var _controller = TextEditingController();
  String countreyValue = 'حسب المحافظة';
  String categoryValue = 'حسب نوع المتجر';
  static List<Contacts> main_List = [
    Contacts("Rounia1\n", "./assets/forget.png", "حمص", "0937082264", "صاغة"),
    Contacts("Rounia2\n", "./assets/forget.png", "حمص", "0937082264", "صاغة"),
    Contacts("Rounia3\n", "./assets/rounia.jpg", "حمص", "0937082264", "صاغة"),
    Contacts("Rounia4\n", "./assets/rounia.jpg", "حلب", "0937082264", "بقالية"),
    Contacts("Rounia5\n", "./assets/rounia.jpg", "حلب", "0937082264", "بقالية"),
    Contacts("Rounia6\n", "./assets/rounia.jpg", "حلب", "0937082264", "بقالية"),
  ];
  var countries = [
    'حسب المحافظة',
    'حمص',
    'حلب',
    'دمشق',
    'طرطوس',
    'اللاذقية',
    'حماة',
    'إدلب',
    'الرقة',
    'دير الزور',
  ];
  var categories = [
    'حسب نوع المتجر',
    'ألبسة',
    'أحذية',
    'مواد غذائية',
    'صاغة',
    'مواد تنظيف',
    'بقالية',
    'محمصة',
    'بالة',
    'آخرى',

  ];
  List<Contacts> display_List = List.from(main_List);
  void clear() {
    setState(() {
      display_List = main_List;
    });
  }

  void UpdateList(String name) {
    setState(() {
      display_List = main_List
          .where((ele) => ele.name!.toLowerCase().contains(name.toLowerCase()))
          .toList();
    });
  }

  void Updatebycountrey(String site) {
    setState(() {
      // print(categoryValue);
      countreyValue = site;
      if (categoryValue != "حسب نوع المتجر") {
        display_List = main_List
            .where((ele) =>
                ele.site!.toLowerCase().contains(site.toLowerCase()) &
                ele.type!.toLowerCase().contains(categoryValue.toLowerCase()))
            .toList();
      } else {
        display_List = main_List
            .where(
                (ele) => ele.site!.toLowerCase().contains(site.toLowerCase()))
            .toList();
      }
    });
  }

  void Updatebycategory(String type) {
    categoryValue = type;
    setState(() {
      if (countreyValue != "حسب المحافظة") {
        display_List = main_List
            .where((ele) =>
                ele.type!.toLowerCase().contains(type.toLowerCase()) &
                ele.site!.toLowerCase().contains(countreyValue.toLowerCase()))
            .toList();
      } else {
        display_List = main_List
            .where(
                (ele) => ele.type!.toLowerCase().contains(type.toLowerCase()))
            .toList();
      }
    });
  }


  @override
  int i=0;
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    var model = Provider.of<Formap>(context);
    int y = 1;

    if (i == 0) {
      // SearchProvider x = new SearchProvider(context);
      model.fetchData(context);
      i = i + 1;
    }
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    return  Scaffold(
            body: Padding(
          padding: EdgeInsets.all(height*0.002),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.all(height*0.022),
                  child: SizedBox(
                    width: width*0.9,
                    child: TextField(
                      controller: _controller,
                      onChanged: (value) => {  model.filterData(value),
                          model.ChooseValue = value},
                      maxLines: 1,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(width*0.07),
                            borderSide: BorderSide(
                                width: width*0.008,
                                color: Color.fromARGB(250, 58, 165, 117))),
                        hintText: "",
                        alignLabelWithHint: false,
                        hintStyle: TextStyle(color: Colors.grey.shade500),
                        prefixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                 model.clear();
                                _controller.text = "";
                              });
                            },
                            icon: Icon(Icons.close)),
                        prefixIconColor: Color.fromARGB(250, 58, 165, 117),
                        suffixIcon: Icon(Icons.search),
                        suffixIconColor: Color.fromARGB(250, 58, 165, 117),
                      ),
                    ),
                  ),
                ),
                // Text("sdjdh"),
                Row(
                  children: [
                    SizedBox(width: width*0.05),
                    Expanded(
                        child: DropdownButtonFormField(
                      // colo
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            //<-- SEE HERE
                            borderSide: BorderSide(
                                color: Color.fromARGB(250, 58, 165, 117),
                                width: width*0.002),
                            borderRadius: BorderRadius.circular(width*0.08)),
                        focusedBorder: OutlineInputBorder(
                            //<-- SEE HERE
                            borderSide: BorderSide(
                                color: Color.fromARGB(250, 58, 165, 117),
                                width: width*0.002),
                            borderRadius: BorderRadius.circular(width*0.08)),
                        filled: true,
                        fillColor: Color.fromARGB(255, 82, 173, 117),
                      ),
                      dropdownColor: Color.fromARGB(255, 82, 173, 117),
                      value: categoryValue,
                      onChanged: (value) => { model.Updatebycateg(value!)},
                      iconDisabledColor: Colors.white,
                      iconEnabledColor: Colors.white,
                      items: model.categories
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(
                                fontSize: width*0.04,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Cairo",
                                color: Colors.white),
                          ),
                        );
                      }).toList(),
                    )),
                    SizedBox(width: width*0.05),
                    Expanded(
                        child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            //<-- SEE HERE
                            borderSide:
                                BorderSide(color: Colors.white, width: width*0.002),
                            borderRadius: BorderRadius.circular(width*0.08)),
                        focusedBorder: OutlineInputBorder(
                            //<-- SEE HERE
                            borderSide:
                                BorderSide(color: Colors.white, width: width*0.002),
                            borderRadius: BorderRadius.circular(width*0.08)),
                        filled: true,
                        fillColor: Color.fromARGB(255, 82, 173, 117),
                      ),
                      dropdownColor: Color.fromARGB(255, 82, 173, 117),
                      value: countreyValue,
                      onChanged: (value) => { model.Updatebycountrey(value!)},
                      iconDisabledColor: Colors.white,
                      iconEnabledColor: Colors.white,
                      items: model.syrianCities
                          .map<DropdownMenuItem<String>>((String value) {
                        print(value);
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Center(
                            child: Text(
                              value,
                              style: TextStyle(
                                  fontSize: width*0.04,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        );
                      }).toList(),
                    )),
                    SizedBox(width: width*0.05),
                  ],
                ),
                SizedBox(
                  height: height*0.008,
                ),
                Expanded(
                    child: model.display_List == null
                        ? Center(
                            child: Lottie.asset('./assets/Loading Files.json'),
                          )
                        : model.display_List.length == 0
                            ? Center(
                                child: Lottie.asset('./assets/one.json'),
                              )
                            : ListView.builder(
                            shrinkWrap: true,
                            itemCount: model.display_List.length,
                            // physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Container(
                                //
                                padding: EdgeInsets.only(
                                    top: width*0.03,
                                    left: height*0.008,
                                    bottom: width*0.03,
                                    right: height*0.008),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                     Padding(
                                            padding: EdgeInsets.only(
                                                left: 0, top: 0),
                                            child: Row(
                                              // mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Icon(Icons.location_pin,
                                                    size: width*0.07,
                                                    color: Colors.red),
                                                Consumer<Formap>(builder:
                                                    (context, formap, child) {
                                                  return InkWell(
                                                      onTap: () async {
                                                        print("hgjdh");
                                                        print(model.display_List[index]['coo'][0]
                                                                  .toDouble());
                                                         print(model.display_List[index]['coo'][1]
                                                                  .toDouble());
                                                        Provider.of<Formap>(
                                                                context,
                                                                listen: false)
                                                            .changeLatAndLog(
                                                               model.display_List[index]['coo'][0]
                                                                  .toDouble(),
                                                                model.display_List[index]['coo'][1]
                                                                  .toDouble());
                                                        print(model.display_List[index]['coo'][0]
                                                                  .toDouble());

                                                        Navigator.of(context)
                                                            .pushNamed("Map",
                                                                arguments: <
                                                                    String,
                                                                    double>{
                                                              'num': 2.0,
                                                              'lat': model.display_List[index]['coo'][0]
                                                                  .toDouble(),
                                                              'log':model.display_List[index]['coo'][1]
                                                                  .toDouble()
                                                            });
                                                      },
                                                      child: Text("الموقع",
                                                          style: TextStyle(
                                                              color: Colors.red,
                                                              fontSize: width*0.048,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)));
                                                }),
                                              ],
                                            )),
                                    // SizedBox(width: 5.w),

                                    
                                        RichText(
                                          textAlign:TextAlign.end ,
                                          text: TextSpan(children: [
                                            TextSpan(
                                                text: model.display_List[index]['storeName']+"\n",
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        221, 12, 12, 12),
                                                    fontSize: width*0.048,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                                         TextSpan(
                                                text: model.display_List[index]['storeType']+"\n",
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        221, 12, 12, 12),
                                                    fontSize: width*0.04,
                                                   
                                                      )),
                                            TextSpan(
                                                text:
                                                    model.display_List[index]['city']+"-"+ model.display_List[index]['address'],
                                                style: TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: width*0.04,
                                                )),
                                          ]),
                                        ),
                                      
                                    
                                    //  SizedBox(width: 10.w),

                                    CircleAvatar(
                                      backgroundImage:NetworkImage(
                                          model.display_List[index]['storeImgURL']),
                                      radius: width*0.1,
                                    ),
                                    //  SizedBox(width: 5.w),
                                  ],
                                ),
                                //Cart for User(Send & request)

                               
                                height: height*0.15,
                                margin: EdgeInsets.only(
                                    left: width*0.03,
                                    top: height*0.015,
                                    right:width*0.03,
                                    bottom: height*0.015),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(width*0.03)),
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
                              );
                            })),
               
              ]),
        ));
  }
}
