import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'LoginSignupPage.dart';
import 'HomePage.dart';
import 'TaskListPage.dart'; // Import trang HomePage ở đây
import 'edittaskpage.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (kDebugMode) {
    print("Handling a background message: ${message.messageId}");
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, Key? hay});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter FCM Example',
      // Thiết lập trang LoginSignupPage làm trang chính
      initialRoute: '/login',
      routes: {
        // Tạo một bộ tạo tuyến đường với các tuyến đường cụ thể
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
        '/tasklist': (context) => const TaskListPage(),
        '/edittaskpage': (context) => const EditTaskPage(taskId: '', initialTitle: '', initialDescription: '',),
        // Thêm các tuyến đường khác ở đây nếu cần thiết
      },
      // Sử dụng onGenerateRoute để tạo động các tuyến đường khác
      onGenerateRoute: (settings) {
        // Kiểm tra settings.name và trả về các tuyến đường tương ứng
        // Nếu không có tuyến đường nào được tìm thấy, bạn có thể trả về một tuyến đường mặc định hoặc null
        return null;
      },
    );
  }
}
