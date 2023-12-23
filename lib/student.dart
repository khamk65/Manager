import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:manage/login.dart';
import 'package:intl/intl.dart';
class StudentScreen extends StatefulWidget {
  const StudentScreen({Key? key}) : super(key: key);

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  List<double> x = [];
  String? uid = FirebaseAuth.instance.currentUser?.uid;
  String? email = FirebaseAuth.instance.currentUser?.email;
  late DatabaseReference _messagesRef;
   List<Map<String, dynamic>> messages = [];
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final TextEditingController messageController = TextEditingController();
  Future<void> showNotification(String title, String body) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
    );

    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: 'item x',
    );
  }
  @override
  void initState() {
    super.initState();

    _messagesRef = FirebaseDatabase.instance.ref().child('messages');

    // Khởi tạo plugin thông báo
    var initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');

    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Học sinh'),
        backgroundColor: Color.fromARGB(255, 4, 76, 185),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () => logout(context),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: StreamBuilder(
                    stream: _messagesRef.onChildAdded,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final dynamic values = snapshot.data?.snapshot.value;
                        Map<String, dynamic> message = {
                          'message': values['message'],
                          'timestamp': values['timestamp'],
                          'uid': values['uid'],
                        };

                        messages.add(message);
                        showNotification('New Message', message['message']);
                      }

                      return ListView.builder(
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          if (messages[index]['uid'] == uid) {
                            x.add(5);
                          } else {
                            x.add(90);
                          }
                          return ListTile(
                            contentPadding: EdgeInsets.only(left: x[index]),
                            subtitle: Text(email! +
                                "(student)" +
                                '\n' +
                                DateFormat('yyyy-MM-dd HH:mm:ss')
                                    .format(DateTime.fromMillisecondsSinceEpoch(
                                        messages[index]['timestamp']))),
                            title: Text(messages[index]['message']),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      hintText: 'Nhập thông báo',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: sendMessage,
                  child: Text('Gửi cho học sinh'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> sendMessage() async {
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    String message = messageController.text.trim();
    DateTime currentTime = DateTime.now();
    if (message.isNotEmpty) {
      FirebaseDatabase.instance.ref().child('messages').push().set({
        'uid': uid,
        'message': message,
        'timestamp': currentTime.millisecondsSinceEpoch,
      });

      messageController.clear();
    }
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }
}

