// ignore_for_file: unused_local_variable

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';
// import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:wepay/Participants/api.dart';
import 'dart:convert';

import '../model/ForMap.dart';
import 'LastTranstion.dart';
import 'package:geolocator/geolocator.dart';

var numberPage;

class MapPage extends StatefulWidget {
  final String num;

  const MapPage({Key? key, required this.num}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  void initState() {
    super.initState();

    numberPage = widget.num;
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => Formap()),
    ], child: MapScreen());
  }
}

class MapScreen extends StatefulWidget {
  // const MapScreen({super.key

  // });

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> with TickerProviderStateMixin {
  List listOfPoints = [];
  List listOfPoints1 = [];
  List<LatLng> points = [];
  List listOfPoints2 = [];
  List listOfPoints22 = [];
  List<LatLng> points2 = [];
  String NameStart = "";
  String NameEnd = "";
  late double total_distance = 0.0;
  late double total_duration = 0.0;
  late double total_distance1 = 0.0;
  late double total_duration1 = 0.0;
  late double EndLat = 1.0;
  late double EndLog = 1.0;
  late AnimationController _animController;
  late AnimationController _controller;
  late CurvedAnimation _animation;
  late double l1 = 0;
  late double l2 = 0;
  // late LocationData data = new LocationData.fromMap({'lat1': 0.0, 'log1': 1.0});
  bool showMarkerInfo = false;
  late LatLng selectedMarkerPosition = LatLng(0.0, 0.0);
  late int selectedMarkerTnumber = 0;
  var r = [];

  var r1 = [];
  bool flag1 = false;
  bool flag2 = false;
  void onMarkerTap(LatLng position, int num) {
    // print("skdhsk");
    setState(() {
      flag2 = true;
      showMarkerInfo = !showMarkerInfo;
      selectedMarkerPosition = position;
      selectedMarkerTnumber = num;
    });
  }

  // Method to consume the OpenRouteService API
  getCoordinates(double x, double y) async {
    EndLat = x;
    EndLog = y;
    total_distance = 0.0;
    total_duration = 0.0;
    total_distance1 = 0.0;
    total_duration1 = 0.0;
    
    var response = await http
        .get(getRouteUrl('${l2},${l1}', '${x},${y}'));
    var response1 = await http
        .get(getRouteUrl1('${l2},${l1}', '${x},${y}'));

    setState(() {
      if (response.statusCode == 200) {
        // print(23);
        var data = jsonDecode(response.body);
        var data1 = jsonDecode(response1.body);
        r = data['features'][0]['properties']['segments'][0]['steps'];
        //  print(r);
        listOfPoints = data['features'][0]['geometry']['coordinates'];
        listOfPoints1 =
            data['features'][0]['properties']['segments'][0]['steps'];
        points = listOfPoints
            .map((p) => LatLng(p[1].toDouble(), p[0].toDouble()))
            .toList();
        r.forEach((element) {
          print(element['name']);

          total_distance += element['distance'];
        });
        r.forEach((ele) {
          total_duration += ele['duration'];
        });

        r1 = data1['features'][0]['properties']['segments'][0]['steps'];
        print(r);
        NameStart = r[0]['name'];

        listOfPoints2 = data['features'][0]['geometry']['coordinates'];
        listOfPoints22 =
            data['features'][0]['properties']['segments'][0]['steps'];
        points2 = listOfPoints2
            .map((p) => LatLng(p[1].toDouble(), p[0].toDouble()))
            .toList();
        r1.forEach((element) {
          total_distance1 += element['distance'];
        });
        r1.forEach((ele) {
          total_duration1 += ele['duration'];
        });
        print(points);
      }
    });
    print(total_duration);
  }

  // Location location = Location();
  double lat = 0.0, log = 0.0;
  void check() async {
    print(5);
    await Geolocator.requestPermission();
    Position pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    bool _serviceEnabled;
    StreamSubscription<Position> stream =
        Geolocator.getPositionStream().listen((event) {
      setState(() {
        l1 = event.latitude;
        l2 = event.longitude;
      });
    }) as StreamSubscription<Position>;
  }

  late bool flog = false;
  late Timer time;
  @override
  void initState() {
    print(numberPage);
    print("ssssssssssssssssssss");
    Future.delayed(Duration(seconds: 30), () {
      setState(() {
        flog = true;
      });
    });
    _controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 750),
        reverseDuration: const Duration(milliseconds: 750));
    _animation =
        CurvedAnimation(parent: _controller, curve: Curves.easeOutBack);
    // _tileLayerController = MapTileLayerController();
    _controller.repeat(min: 0.1, max: 1.0, reverse: true);
    super.initState();
    check();
    // });
//  });
  }

  @override
  void dispose() {
    _controller.stop();
    _controller.dispose();
    // _markers.clear();
    super.dispose();
  }

  MapController _mapController = MapController();
  Map args = {"num": 2.0, "lat": 34.8105, "log": 36.129876};
  @override
  int i = 0;
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
    if (numberPage == "2")
      args = (ModalRoute.of(context)?.settings.arguments ?? {}) as Map;
      print("rounia");
    print(args);
    //  print(args.toString()) ;
    return Consumer<Formap>(builder: (context, formap, child) {
      return formap.display_List != null && l1 != 0 && l2 != 0
          ? Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: numberPage == "2" ? AppBar() : null,
              body: Stack(children: [
                FlutterMap(
                  options: MapOptions(zoom: 12, center: LatLng(l1, l2)),
                  children: [
                    // Layer that adds the map
                    TileLayer(
                      urlTemplate:
                          "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                      userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                    ),
                    // Layer that adds points the map
                    PolylineLayer(
                      polylineCulling: false,
                      polylines: [
                        Polyline(
                            points: points, color: Colors.blue, strokeWidth: 5),
                      ],
                    ),
                    Consumer<Formap>(builder: (context, formap, child) {
                      return MarkerLayer(
                        markers: [
                          Marker(
                            width: 90.0,
                            height: 90.0,
                            point: LatLng(l1, l2),
                            builder: (ctx) => ScaleTransition(
                              alignment: Alignment.bottomCenter,
                              scale: _animation,
                              child: Icon(Icons.location_on,
                                  size: 50, color: Colors.lightGreen),
                            ),
                          ),
                          for (int i = 0; i < formap.display_List.length; i++)
                            Marker(
                              width: 90.0,
                              height: 90.0,
                              point: LatLng(formap.display_List[i]['coo'][1],
                                  formap.display_List[i]['coo'][0]),
                              builder: (ctx) => ScaleTransition(
                                  alignment: Alignment.bottomCenter,
                                  scale: _animation,
                                  child: InkWell(
                                    onTap: () => onMarkerTap(
                                        LatLng(formap.display_List[i]['coo'][1],
                                            formap.display_List[i]['coo'][0]),
                                        i),
                                    child: Icon(Icons.location_on,
                                        size: 50, color: Colors.blue),
                                  )),
                            ),
                        ],
                      );
                    }),

                    // Polylines layer
                  ],
                ),
                AnimatedPositioned(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    top: flag1 ? 10 : -230,
                    right: 10,
                    child: Center(
                      child: Container(
                        height: 230,
                        // width:150,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 243, 237, 237),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: Color.fromARGB(249, 59, 203, 78),
                            width: 2.0,
                          ),
                        ),

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(height: 10.h),
                            Text(
                              "  عبر قيادة السيارة  ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("كم"),
                                Text(
                                    "${(total_distance / 1000).toInt().toString()}"),
                                SizedBox(width: 10),
                                Icon(Icons.car_crash),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("ثا"),
                                Text(
                                    "${((total_duration % 60)).toInt().toString()}"),
                                SizedBox(width: 3),
                                Text("د"),
                                Text(
                                    "${((total_duration % 3600) / 60).toInt().toString()}"),
                                SizedBox(width: 3),
                                Text("سا"),
                                Text(
                                    "${(total_duration ~/ 3600).toInt().toString()}"),
                                SizedBox(width: 5),
                                Icon(Icons.watch),
                              ],
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              "   مشيا على الأقدام   ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("كم"),
                                Text(
                                    "${(total_distance1 / 1000).toInt().toString()}"),
                                SizedBox(width: 10),
                                Icon(Icons.directions_walk),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("ثا"),
                                Text(
                                    "${((total_duration1 % 60)).toInt().toString()}"),
                                SizedBox(width: 3),
                                Text("د"),
                                Text(
                                    "${((total_duration1 % 3600) / 60).toInt().toString()}"),
                                SizedBox(width: 3),
                                Text("سا"),
                                Text(
                                    "${(total_duration1 ~/ 3600).toInt().toString()}"),
                                SizedBox(width: 5),
                                Icon(Icons.watch),
                              ],
                            ),
                            SizedBox(height: 10.h)
                          ],
                        ),
                      ),
                    )),
                AnimatedPositioned(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    top: 8,
                    left: 10,
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 243, 237, 237),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: Color.fromARGB(249, 59, 203, 78),
                            width: 2.0,
                          ),
                        ),
                        height: 120,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(height: 10),
                            Center(
                              child: Text(
                                "  الخريطة الدليلية     ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(" موقعك "),
                                Icon(Icons.location_on,
                                    size: 35, color: Colors.green),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("المتاجر "),
                                Icon(Icons.location_on,
                                    size: 35, color: Colors.blue),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )),
                Consumer<Formap>(builder: (context, formap, child) {
                  return AnimatedPositioned(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                      bottom: showMarkerInfo ? 120 : -400,
                      left: 0,
                      right: 0,
                      child: Container(
                        //
                        // color:Colors.green,
                        padding: EdgeInsets.only(
                            top: 2.sp, left: 0.sp, bottom: 2.sp, right: 5.sp),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                SizedBox(height: 4.h),
                                // Positioned(
                                //     top: 3,
                                //     left: 4,
                                //     child: IconButton(
                                //       icon: Icon(Icons.close),
                                //       onPressed: () {
                                //         setState(() {
                                //           showMarkerInfo = false;
                                //           flag2 = false;
                                //         });
                                //       },
                                //     )),
                              ],
                            ),

                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(height: 15.h),
                                  RichText(
                                    textAlign: TextAlign.end,
                                    text: TextSpan(children: [
                                      TextSpan(
                                          text: formap.display_List[
                                                      selectedMarkerTnumber]
                                                  ['storeName'] +
                                              "\n",
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  221, 12, 12, 12),
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                          text: "محل " +
                                              formap.display_List[
                                                      selectedMarkerTnumber]
                                                  ['storeType'] +
                                              "\n",
                                          style: TextStyle(
                                            color:
                                                Color.fromARGB(221, 12, 12, 12),
                                            fontSize: 12.sp,
                                          )),

                                      TextSpan(
                                          text: formap.display_List[
                                                      selectedMarkerTnumber]
                                                  ['city'] +
                                              "-" +
                                              formap.display_List[
                                                      selectedMarkerTnumber]
                                                  ['address'],
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 12.sp,
                                          )),
                                    ]),
                                  ),
                                ]),

                            // SizedBox(width: 5.w),

                            CircleAvatar(
                              backgroundImage: NetworkImage(model.display_List[
                                          selectedMarkerTnumber] !=
                                      null
                                  ? model.display_List[selectedMarkerTnumber]
                                      ['storeImgURL']
                                  : "https://www.bing.com/images/search?view=detailV2&ccid=dv4q%2fAZd&id=D1AD8CC40A6F3734E334C17AB61A7EF2A36871AE&thid=OIP.dv4q_AZdgAxN9Xqz-hdMRwHaFj&mediaurl=https%3a%2f%2fth.bing.com%2fth%2fid%2fR.76fe2afc065d800c4df57ab3fa174c47%3frik%3drnFoo%252fJ%252bGrZ6wQ%26riu%3dhttp%253a%252f%252fevolutionarydesigns.net%252fphotography%252fwp-content%252fuploads%252f2011%252f10%252fstore-1-vintage-2.jpg%26ehk%3dETHaIJufXT%252b54mshlzPrHH2B%252funrjDK2F1jOU24%252b3vM%253d%26risl%3d%26pid%3dImgRaw%26r%3d0&exph=768&expw=1024&q=image+store&simid=608009684226693471&FORM=IRPRST&ck=6D595D0A49E0ECD2D1FAE44884223CA4&selectedIndex=9"),
                              radius: 30.r,
                            ),

                            //  SizedBox(width: 5.w),
                          ],
                        ),
                        //Cart for User(Send & request)

                        height: 95.h,
                        margin:
                            EdgeInsets.only(left: 20.w, top: 5.h, right: 20.w),

                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color.fromARGB(249, 59, 203, 78),
                            width: 2.0,
                          ),
                          color: Color.fromARGB(255, 243, 237, 237),
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
                      ));
                }),
              ]),

              floatingActionButton: !flag2 && numberPage == "2"
                  ? Consumer<Formap>(builder: (context, formap, child) {
                      print("ssssssssssss");
                      return FloatingActionButton(
                        backgroundColor: Colors.green,
                        onPressed: () async => {
                          print(formap.lat),
                          // print(args),
                          flag1 = true,
                          
                          await getCoordinates(args['lat']!=null?args['lat']:0.0, args['log']!=null?args['log']:0.0),
                        },
                        child: const Icon(
                          Icons.route,
                          color: Colors.black,
                        ),
                      );
                    })
                  : Text(""),

              // floatingActionButtonLocation:FloatingActionButtonLocation.miniStartTop,
            )
          : Container(
              color: Colors.white,
              child: Center(child: CircularProgressIndicator()),
            );
    });
  }
}
