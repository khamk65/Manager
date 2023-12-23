import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class LightControlScreen extends StatefulWidget {
  LightControlScreen({required this.deviceName});
  final String deviceName;
  @override
  _LightControlScreenState createState() => _LightControlScreenState();
}

class _LightControlScreenState extends State<LightControlScreen> {
  final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.reference().child('user');
  double brightnessLevel = 1.0;

  Future<String> fetchData() async {
    try {
      DatabaseEvent snapshot = (await _databaseReference
          .child("device/${widget.deviceName}")
          .once());

      if (snapshot.snapshot.value != null) {
        // Truy cập dữ liệu từ snapshot
        dynamic data1 = snapshot.snapshot.value;

        // Đối với ví dụ này, giả sử 'name' là một chuỗi
        String name = data1['name'].toString();
        brightnessLevel = double.parse(data1['level']);
        print('Name: $name');
        return name;
      } else {
        print('Data is null');
        return '';
      }
    } catch (error) {
      print('Error fetching data: $error');
      return '';
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<String>(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Dữ liệu đang tải, bạn có thể hiển thị một widget loading
              return Text('Light Control');
            } else if (snapshot.hasError) {
              // Xử lý lỗi nếu có
              return Text('Error: ${snapshot.error}');
            } else {
              // Dữ liệu đã tải xong, cập nhật UI với dữ liệu mới
              return Text('Light Control ${snapshot.data}');
            }
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Brightness Level: $brightnessLevel',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Slider(
              value: brightnessLevel,
              min: 1.0,
              max: 5.0,
              divisions: 4,
              onChanged: (value) {
                setState(() {
                  brightnessLevel = value;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _databaseReference
                    .child("device/${widget.deviceName}/level")
                    .set(brightnessLevel);
              },
              child: Text('Apply Brightness'),
            ),
          ],
        ),
      ),
    );
  }
}
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';

// class LightControlScreen extends StatefulWidget {
//   LightControlScreen({required this.deviceName});
//   final String deviceName;
//   @override
//   _LightControlScreenState createState() => _LightControlScreenState();
// }

// class _LightControlScreenState extends State<LightControlScreen> {
//   final DatabaseReference _databaseReference =
//       FirebaseDatabase.instance.reference().child('user');
//   double brightnessLevel = 1.0;

//   Future<String> fetchData() async {
//     try {
//       DatabaseEvent snapshot = (await _databaseReference
//           .child("device/${widget.deviceName}")
//           .once());

//       if (snapshot.snapshot.value != null) {
//         // Truy cập dữ liệu từ snapshot
//         dynamic data1 = snapshot.snapshot.value;

//         // Đối với ví dụ này, giả sử 'name' là một chuỗi
//         String name = data1['name'].toString();

//         print('Name: $name');
//         return name;
//       } else {
//         print('Data is null');
//         return '';
//       }
//     } catch (error) {
//       print('Error fetching data: $error');
//       return '';
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: FutureBuilder<String>(
//           future: fetchData(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               // Dữ liệu đang tải, bạn có thể hiển thị một widget loading
//               return Text('Light Control');
//             } else if (snapshot.hasError) {
//               // Xử lý lỗi nếu có
//               return Text('Error: ${snapshot.error}');
//             } else {
//               // Dữ liệu đã tải xong, cập nhật UI với dữ liệu mới
//               return Text('Light Control ${snapshot.data}');
//             }
//           },
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Brightness Level: $brightnessLevel',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 20),
//             Slider(
//               value: brightnessLevel,
//               min: 1.0,
//               max: 5.0,
//               divisions: 4,
//               onChanged: (value) {
//                 setState(() {
//                   brightnessLevel = value;
//                 });
//               },
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 _databaseReference
//                     .child("device/${widget.deviceName}/level")
//                     .set(brightnessLevel);
//               },
//               child: Text('Apply Brightness'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
