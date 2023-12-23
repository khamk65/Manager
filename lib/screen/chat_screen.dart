import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:manage/student.dart';
import 'package:manage/teacher.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // void route1() {
  //   User? user = FirebaseAuth.instance.currentUser;
  //   var kk = FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(user!.uid)
  //       .get()
  //       .then((DocumentSnapshot documentSnapshot) {
  //     if (documentSnapshot.exists) {
  //       if (documentSnapshot.get('rool') == "Teacher") {
  //         Navigator.pushReplacement(
  //           context,
  //           MaterialPageRoute(
  //             builder: (context) => Teacher(),
  //           ),
  //         );
  //       } else {
  //         Navigator.pushReplacement(
  //           context,
  //           MaterialPageRoute(
  //             builder: (context) => StudentScreen(),
  //           ),
  //         );
  //       }
  //     } else {
  //       print('Document does not exist on the database');
  //     }
  //   });
  // }

  @override
  void initState() {
   // route1();
    super.initState();
  }

  @override
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        // Sử dụng FutureBuilder để xử lý logic dựa trên dữ liệu của documentSnapshot
        future: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Nếu đang đợi dữ liệu, hiển thị màn hình chờ
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            // Nếu có lỗi, xử lý lỗi (ở đây chỉ là hiển thị thông báo lỗi)
            return Text('Error: ${snapshot.error}');
          } else {
            // Nếu có dữ liệu, kiểm tra giá trị của 'rool'
            if (snapshot.data!.exists) {
              String userRole = snapshot.data!.get('rool');

              // Kiểm tra và chuyển hướng đến màn hình phù hợp
              if (userRole == "Teacher") {
                return Teacher();
              } else {
                return StudentScreen();
              }
            } else {
              // Trường hợp không có dữ liệu
              print('Document does not exist in the database');
              return Scaffold(
                body: Center(
                  child: Text('Document does not exist in the database'),
                ),
              );
            }
          }
        },
      ),
    );
  }
}
