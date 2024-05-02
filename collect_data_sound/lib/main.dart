import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';
import 'login_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

void main() async {
  await dotenv.load(fileName: "assets/.env");
   runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppState()),
        Provider(create: (context) => http.Client()), // เพิ่ม Provider สำหรับ HttpClient
      ],
      child: MaterialApp(
        title: 'My Flutter App',
        theme: ThemeData(
          inputDecorationTheme: const InputDecorationTheme(
            fillColor: Colors.white,
            filled: true,
          ),
          primarySwatch: Colors.blue,
        ),
        home: Consumer<AppState>(
          builder: (context, appState, _) {
            return LoginPage(appState: appState);
          },
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'app_state.dart';
// // import 'home_page.dart';
// import 'login_page.dart';

// void main() {
//   runApp(MyApp(appState: AppState()));
// }

// class MyApp extends StatefulWidget {
//   final AppState appState;
//   final List<int>? recordedAudio;
//   const MyApp({super.key, required this.appState, this.recordedAudio});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }


// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => AppState(), // Provide AppState
//       child: MaterialApp(
//         title: 'My Flutter App',
//         theme: ThemeData(
//           inputDecorationTheme: const InputDecorationTheme(
//             fillColor: Colors.white,
//             filled: true,
//           ),
//           primarySwatch: Colors.blue,
//         ),
//         home: LoginPage(appState: widget.appState),


//         // home: const LoginPage( appState: widget.appState,
//         //               recordedAudio: widget.recordedAudio,),
//       ),
//     );
//   }
// }







// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'app_state.dart';
// import 'home_page.dart';
// import 'login_page.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => AppState(), // Provide AppState
//       child: MaterialApp(
//         title: 'My Flutter App',
//         theme: ThemeData(
//           inputDecorationTheme: const InputDecorationTheme(
//             fillColor: Colors.white,
//             filled: true,
//           ),
//           primarySwatch: Colors.blue,
//         ),
//         home: const LoginPage(),
//       ),
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'login_page.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   // const MyApp({super.key});
//    const MyApp({Key? key}) : super(key: key); 

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'My Flutter App',
//       theme: ThemeData(
//         inputDecorationTheme: const InputDecorationTheme(
//           fillColor: Colors.white,
//           filled: true,
//         ),
//       ),
//       home: const LoginPage(),
//     );
//   }
// }
