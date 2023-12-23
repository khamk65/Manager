// import 'dart:ffi';

// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../box/custom_card.dart';

// class ClassRoom extends StatefulWidget {
//   ClassRoom(
//       {super.key,
//       required this.state_d1,
//       required this.state_d2,
//       required this.state_d3,
//       required this.state_d4});

//   int state_d1;
//   int state_d2;
//   int state_d3;
//   int state_d4;

//   @override
//   State<ClassRoom> createState() => _ClassRoomState();
// }

// class _ClassRoomState extends State<ClassRoom> {
//   final DatabaseReference _databaseReference =
//       FirebaseDatabase.instance.reference().child('users');
//   void toggle_d1() {
//     //setState(() {
//     if (widget.state_d1 == 0) {
//       widget.state_d1 = 1;
//     } else {
//       widget.state_d1 = 0;
//     }
//     //});
//   }

//   void toggle_d2() {
//     if (widget.state_d2 == 0) {
//       widget.state_d2 = 1;
//     } else {
//       widget.state_d2 = 0;
//     }
//   }

//   void toggle_d3() {
//     if (widget.state_d3 == 0) {
//       widget.state_d3 = 1;
//     } else {
//       widget.state_d3 = 0;
//     }
//   }

//   void toggle_d4() {
//     if (widget.state_d4 == 0) {
//       widget.state_d4 = 1;
//     } else {
//       widget.state_d4 = 0;
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;

//     return Scaffold(
//       body: Container(
//         margin: EdgeInsets.all(size.width * 0.05),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               SizedBox(height: size.height * 0.025),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   CustomCard(
//                     size: size,
//                     icon: Icon(
//                       Icons.home_outlined,
//                       size: 55,
//                       color: Colors.grey.shade400,
//                     ),
//                     title: "ENTRY",
//                     statusOn: "OPEN",
//                     statusOff: "LOCKED",
//                     isChecked: widget.state_d1 == 0 ? false : true,
//                     toggle: toggle_d1,
//                   ),
//                   CustomCard(
//                     size: size,
//                     icon: Icon(
//                       Icons.lightbulb_outline,
//                       size: 55,
//                       color: Colors.grey.shade400,
//                     ),
//                     title: "LIGHTS",
//                     statusOn: "ON",
//                     statusOff: "OFF",
//                     isChecked: widget.state_d2 == 0 ? false : true,
//                     toggle: toggle_d2,
//                   ),
//                 ],
//               ),
//               SizedBox(height: size.height * 0.025),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   CustomCard(
//                     size: size,
//                     icon: Icon(
//                       Icons.home_outlined,
//                       size: 55,
//                       color: Colors.grey.shade400,
//                     ),
//                     title: "ENTRY",
//                     statusOn: "OPEN",
//                     statusOff: "LOCKED",
//                     isChecked: widget.state_d3 == 0 ? false : true,
//                     toggle: toggle_d3,
//                   ),
//                   CustomCard(
//                     size: size,
//                     icon: Icon(
//                       Icons.lightbulb_outline,
//                       size: 55,
//                       color: Colors.grey.shade400,
//                     ),
//                     title: "LIGHTS",
//                     statusOn: "ON",
//                     statusOff: "OFF",
//                     isChecked: widget.state_d4 == 0 ? false : true,
//                     toggle: toggle_d4,
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
