
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:manage/box/custom_card.dart';
import 'package:manage/screen/airquality.dart';
import 'package:manage/screen/lightcontrol.dart';

import 'package:provider/provider.dart';

class Apps extends StatefulWidget {
  const Apps({
    super.key,
  });

  @override
  State<Apps> createState() => _AppsState();
}

class _AppsState extends State<Apps> with TickerProviderStateMixin {
  int dusty = 0;
  List<Map<String, dynamic>> Device = [];
  late TabController _tabController;
  late List<Widget> _views; // Declare the variable here
  final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.reference().child('user');
  @override
  void dispose() {
    // ignore: todo
    // TODO: implement dispose

    super.dispose();
  }

  @override
  void initState() {
    for (int i = 0; i < 6; i++) {
      Device.add({"name": "", "status": 0});
    }
    updateDevice();
    int data = 0;
    // ignore: todo
    // TODO: implement initState
    _tabController = TabController(length: 4, vsync: this);
    _tabController.animateTo(2);

    Future.delayed(const Duration(seconds: 1), () {});
    super.initState();
  }

  @override
  void toggle_d1() {
    //setState(() {
    if (Device[0]['status'] == 0) {
      _databaseReference.child('device/device1/status').set(1);
    } else {
      _databaseReference.child('device/device1/status').set(0);
    }
    //});
  }

  void toggle_d2() {
    if (Device[1]['status'] == 0) {
      _databaseReference.child('device/device2/status').set(1);
    } else {
      _databaseReference.child('device/device2/status').set(0);
    }
  }

  void toggle_d3() {
    if (Device[2]['status'] == 0) {
      _databaseReference.child('device/device3/status').set(1);
    } else {
      _databaseReference.child('device/device3/status').set(0);
    }
  }

  void toggle_d4() {
    if (Device[3]['status'] == 0) {
      _databaseReference.child('device/device4/status').set(1);
    } else {
      _databaseReference.child('device/device4/status').set(0);
    }
  }

  void toggle_d5() {
    if (Device[4]['status'] == 0) {
      _databaseReference.child('device/device5/status').set(1);
    } else {
      _databaseReference.child('device/device5/status').set(0);
    }
  }

  void toggle_d6() {
    if (Device[5]['status'] == 0) {
      _databaseReference.child('device/device6/status').set(1);
    } else {
      _databaseReference.child('device/device6/status').set(0);
    }
  }

  /// List of Tab Bar Item
  List<String> items = [
    "ClassRoom",
    // "Kitchen",
    // "BedRoom",
    // "OutSide",
  ];
  final List<Tab> _tabs = [
    Tab(
      child: Center(
        child: Text("ClassRoom",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              color: Colors.black,
            )),
      ),
    ),
  ];

  int current = 0;

  void updateDevice() {
    _databaseReference.child('device').onValue.listen((event) {
      if (event.snapshot != null) {
        DataSnapshot snapshot = event.snapshot as DataSnapshot;
        Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;

        List<Map<String, dynamic>> settings3 = [];

        data.forEach(
          (key, value) {
            if (value != null && value is Map<dynamic, dynamic>) {
              if (value.containsKey('name')) {
                settings3.add(
                  {
                    'name': value['name'].toString(),
                    'status': int.parse(value['status'].toString()),
                  },
                );
              }
              ;
            }
          },
        );
        setState(() {
          Device = settings3;
          for (int i = 0; i < Device.length; i++) {
            print('Device[$i] status: ${Device[i]['name']}');
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      /// APPBAR
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Rooms',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 25,
            color: Color.fromRGBO(0, 0, 0, 0.8),
            fontFamily: 'Roboto',
          ),
        ),
      ),

      ///Điện năng tiêu thụ
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          AirQualityScreen()), // Replace AirQualityScreen() with your actual screen
                );
              },
              child: Container(
                child: Center(
                  child: Container(
                      width: 300,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.blue,
                          width: 2,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Container(
                              width: 90,
                              height: 90,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(90),
                              ),
                              child: Center(
                                child: Image.asset(
                                  'assets/images/ic_dusty.jpg',
                                  width: 90,
                                  height: 90,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    "Temp : ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontFamily: 'Roboto',
                                    ),
                                  ),
                                  StreamBuilder(
                                    stream: _databaseReference.onValue,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData &&
                                          !snapshot.hasError &&
                                          snapshot.data!.snapshot.value !=
                                              null) {
                                        // Truy cập dữ liệu từ snapshot
                                        Map<dynamic, dynamic> data = snapshot
                                            .data!
                                            .snapshot
                                            .value as Map<dynamic, dynamic>;

                                        String temp = data['temp'].toString();

                                        return Text(
                                          '$temp %',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: Colors.black,
                                            fontFamily: 'Roboto',
                                          ),
                                        );
                                      } else {
                                        return CircularProgressIndicator();
                                      }
                                    },
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  const Text(
                                    "Humi : ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontFamily: 'Roboto',
                                    ),
                                  ),
                                  StreamBuilder(
                                    stream: _databaseReference.onValue,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData &&
                                          !snapshot.hasError &&
                                          snapshot.data!.snapshot.value !=
                                              null) {
                                        // Truy cập dữ liệu từ snapshot
                                        Map<dynamic, dynamic> data = snapshot
                                            .data!
                                            .snapshot
                                            .value as Map<dynamic, dynamic>;

                                        String humi = data['humi'].toString();

                                        return Text(
                                          '$humi %',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: Colors.black,
                                            fontFamily: 'Roboto',
                                          ),
                                        );
                                      } else {
                                        return CircularProgressIndicator();
                                      }
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  StreamBuilder(
                                    stream: _databaseReference.onValue,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData &&
                                          !snapshot.hasError &&
                                          snapshot.data!.snapshot.value !=
                                              null) {
                                        // Truy cập dữ liệu từ snapshot
                                        Map<dynamic, dynamic> data = snapshot
                                            .data!
                                            .snapshot
                                            .value as Map<dynamic, dynamic>;

                                        dusty =
                                            int.parse(data['dusty'].toString());

                                        return Text(
                                          '$dusty',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.black,
                                            fontFamily: 'Roboto',
                                          ),
                                        );
                                      } else {
                                        return CircularProgressIndicator();
                                      }
                                    },
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    'µg/m³',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontFamily: 'Roboto',
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                dusty <= 40 ? "Safe" : "Danger",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                  color:
                                      dusty <= 40 ? Colors.black : Colors.red,
                                ),
                              ),
                            ],
                          )
                        ],
                      )),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.all(size.width * 0.05),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: size.height * 0.025),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustomCard(
                            size: size,
                            icon: Icon(
                              Icons.lightbulb_outline,
                              size: 55,
                              color: Colors.grey.shade400,
                            ),
                            title: Device[0]['name'],
                            statusOn: "ON",
                            statusOff: "OFF",
                            isChecked: Device[0]['status'] == 0 ? false : true,
                            toggle: toggle_d1,
                            onLongPress: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      LightControlScreen(deviceName: "device1"),
                                ),
                              );
                            }),
                        CustomCard(
                            size: size,
                            icon: Icon(
                              Icons.lightbulb_outline,
                              size: 55,
                              color: Colors.grey.shade400,
                            ),
                            title: Device[1]['name'],
                            statusOn: "ON",
                            statusOff: "OFF",
                            isChecked: Device[1]['status'] == 0 ? false : true,
                            toggle: toggle_d2,
                            onLongPress: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      LightControlScreen(deviceName: "device2"),
                                ),
                              );
                            }),
                      ],
                    ),
                    SizedBox(height: size.height * 0.025),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustomCard(
                            size: size,
                            icon: Icon(
                              Icons.lightbulb_outline,
                              size: 55,
                              color: Colors.grey.shade400,
                            ),
                            title: Device[2]['name'],
                            statusOn: "ON",
                            statusOff: "OFF",
                            isChecked: Device[2]['status'] == 0 ? false : true,
                            toggle: toggle_d3,
                            onLongPress: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      LightControlScreen(deviceName: "device3"),
                                ),
                              );
                            }),
                        CustomCard(
                            size: size,
                            icon: Icon(
                              Icons.lightbulb_outline,
                              size: 55,
                              color: Colors.grey.shade400,
                            ),
                            title: Device[3]['name'],
                            statusOn: "ON",
                            statusOff: "OFF",
                            isChecked: Device[3]['status'] == 0 ? false : true,
                            toggle: toggle_d4,
                            onLongPress: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      LightControlScreen(deviceName: "device4"),
                                ),
                              );
                            }),
                      ],
                    ),
                    SizedBox(height: size.height * 0.025),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CustomCard(
                            size: size,
                            icon: Icon(
                              Icons.home_outlined,
                              size: 55,
                              color: Colors.grey.shade400,
                            ),
                            title: Device[4]['name'],
                            statusOn: "OPEN",
                            statusOff: "LOCKED",
                            isChecked: Device[4]['status'] == 0 ? false : true,
                            toggle: toggle_d5,
                            onLongPress: () {},
                          ),
                          CustomCard(
                              size: size,
                              icon: Icon(
                                Icons.home_outlined,
                                size: 55,
                                color: Colors.grey.shade400,
                              ),
                              title: Device[5]['name'],
                              statusOn: "OPEN",
                              statusOff: "LOCKED",
                              isChecked:
                                  Device[5]['status'] == 0 ? false : true,
                              toggle: toggle_d6,
                              onLongPress: () {}),
                        ])
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
