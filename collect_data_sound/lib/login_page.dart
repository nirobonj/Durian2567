import 'package:collect_data_sound/record_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'app_state.dart';
import 'home_page.dart';

// final TextEditingController usernameController = TextEditingController();
// final TextEditingController passwordController = TextEditingController();
class LoginPage extends StatefulWidget {
  final AppState appState;
  final List<int>? recordedAudio;
  const LoginPage({super.key, required this.appState, this.recordedAudio});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _loginUser(BuildContext context) async {
    try {
      String username = usernameController.text;
      String password = passwordController.text;

      var data = {
        'username': username,
        'passwords': password,
      };
      // print(usernameController);
      var response = await http.post(
        Uri.parse('http://${dotenv.env['IP']}:3000/auth/login'),
        // Uri.parse('http://192.168.9.35:3000/auth/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );

      print('Response status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        // Successful login, but staying on the login page
        // Perform any additional actions here

        Navigator.push(
          context,
          MaterialPageRoute(
            // builder: (context) => HomePage(appState: widget.appState),
            builder: (context) => HomePage(
              appState: widget.appState,
              recordedAudio: widget.recordedAudio,
            ),
          ),
        );
      } else {
        // Login failed, show error message
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Login Failed'),
            content: const Text('Invalid username or password'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffff8D),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              width: 200,
              height: 100,
            ),
            SizedBox(
              width: 220,
              height: 50,
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Enter your username',
                  labelText: 'Username',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  fillColor: Colors.white,
                ),
                controller: usernameController,
              ),
            ),
            const SizedBox(height: 25),
            SizedBox(
              width: 220,
              height: 50,
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Enter your password',
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  fillColor: Colors.white,
                ),
                controller: passwordController,
              ),
            ),
            const SizedBox(height: 50),
            SizedBox(
              width: 220,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  _loginUser(
                      context); // เรียกใช้ _loginUser โดยใช้ context ของ Widget
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffffea00),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 220,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      // builder: (context) => HomePage(appState: widget.appState),
                      builder: (context) => HomePage(
                        appState: widget.appState,
                        recordedAudio: widget.recordedAudio,
                      ),
                    ),
                  ); // เรียกใช้ _loginUser โดยใช้ context ของ Widget
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffffea00),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Loginnew',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            // SizedBox(
            //   width: 220,
            //   height: 50,
            //   child: ElevatedButton(
            //     onPressed: () {
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => HomePage(
            //             appState: widget.appState,
            //             recordedAudio: widget.recordedAudio,
            //           ),
            //         ),
            //       );
            //     },
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: const Color(0xffffea00),
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(8),
            //       ),
            //     ),
            //     child: const Text(
            //       'Login new ',
            //       style: TextStyle(
            //         color: Colors.black,
            //         fontWeight: FontWeight.bold,
            //         fontSize: 20,
            //       ),
            //     ),
            //   ),
            // ),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}






// // login_page.dart
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'app_state.dart';
// import 'home_page.dart';

// class LoginPage extends StatefulWidget {
//   final AppState appState;
//   final List<int>? recordedAudio;

//   const LoginPage({Key? key, required this.appState, this.recordedAudio}) : super(key: key);
  
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final TextEditingController usernameController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();

//   void _loginUser(BuildContext context) async {
//     try {
//       String username = usernameController.text;
//       String password = passwordController.text;

//       var data = {
//         'username': username,
//         'password': password,
//       };

//       var response = await http.post(
//         Uri.parse('http://192.168.9.35:3000/auth/login'),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//         body: jsonEncode(data),
//       );

//       if (response.statusCode == 200) {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => HomePage(
//               appState: widget.appState,
//               recordedAudio: widget.recordedAudio,
//             ),
//           ),
//         );
//       } else {
//         showDialog(
//           context: context,
//           builder: (context) => AlertDialog(
//             title: const Text('Login Failed'),
//             content: const Text('Invalid username or password'),
//             actions: <Widget>[
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: const Text('OK'),
//               ),
//             ],
//           ),
//         );
//       }
//     } catch (e) {
//       if (kDebugMode) {
//         print(e);
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xffffff8D),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const SizedBox(
//               width: 200,
//               height: 100,
//             ),
//             SizedBox(
//               width: 220,
//               height: 50,
//               child: TextField(
//                 decoration: InputDecoration(
//                   hintText: 'Enter your username',
//                   labelText: 'Username',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(4),
//                   ),
//                   fillColor: Colors.white,
//                 ),
//                 controller: usernameController,
//               ),
//             ),
//             const SizedBox(height: 25),
//             SizedBox(
//               width: 220,
//               height: 50,
//               child: TextField(
//                 obscureText: true,
//                 decoration: InputDecoration(
//                   hintText: 'Enter your password',
//                   labelText: 'Password',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(4),
//                   ),
//                   fillColor: Colors.white,
//                 ),
//                 controller: passwordController,
//               ),
//             ),
//             const SizedBox(height: 50),
//             SizedBox(
//               width: 220,
//               height: 50,
//               child: ElevatedButton(
//                 onPressed: () {
//                   _loginUser(context); // Call login function
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xffffea00),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 child: const Text(
//                   'Login',
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 20,
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 25),
//           ],
//         ),
//       ),
//     );
//   }
// }


















// import 'package:flutter/material.dart';
// import 'home_page.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'app_state.dart';

// final TextEditingController usernameController = TextEditingController();
// final TextEditingController passwordController = TextEditingController();

// class LoginPage extends StatefulWidget {
//   final AppState appState;
//   const LoginPage({Key? key, required this.appState}) : super(key: key);

//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   void _loginUser(BuildContext context) async {
//     try {
//       String username = usernameController.text;
//       String password = passwordController.text;

//       var data = {
//         'username': username,
//         'password': password,
//       };

//       var response = await http.post(
//         Uri.parse('http://192.168.9.35:3000/auth/login'),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//         body: jsonEncode(data),
//       );

//       if (response.statusCode == 200) {
//         // Login successful
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => HomePage(appState: AppState()),
//             ));
//       } else {
//         // Login failed
//         showDialog(
//           context: context,
//           builder: (context) => AlertDialog(
//             title: const Text('Login Failed'),
//             content: const Text('Invalid username or password'),
//             actions: <Widget>[
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: const Text('OK'),
//               ),
//             ],
//           ),
//         );
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xffffff8D),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const SizedBox(
//               width: 200,
//               height: 100,
//             ),
//             SizedBox(
//               width: 220,
//               height: 50,
//               child: TextField(
//                 decoration: InputDecoration(
//                   hintText: 'Enter your username',
//                   labelText: 'Username',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(4),
//                   ),
//                   fillColor: Colors.white,
//                 ),
//                 controller: usernameController,
//               ),
//             ),
//             const SizedBox(height: 25),
//             SizedBox(
//               width: 220,
//               height: 50,
//               child: TextField(
//                 obscureText: true,
//                 decoration: InputDecoration(
//                   hintText: 'Enter your password',
//                   labelText: 'Password',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(4),
//                   ),
//                   fillColor: Colors.white,
//                 ),
//                 controller: passwordController,
//               ),
//             ),
//             const SizedBox(height: 50),
//             SizedBox(
//               width: 220,
//               height: 50,
//               child: ElevatedButton(
//                 onPressed: () {
//                   _loginUser(context); // Call login function
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xffffea00),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 child: const Text(
//                   'Login',
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 20,
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 25),
//           ],
//         ),
//       ),
//     );
//   }
// }














// import 'package:flutter/material.dart';
// import 'home_page.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'app_state.dart';

// final TextEditingController usernameController = TextEditingController();
// final TextEditingController passwordController = TextEditingController();

// class LoginPage extends StatelessWidget {
//   const LoginPage({Key? key});

//   void _loginUser(BuildContext context) async {
//     try {
//       String username = usernameController.text;
//       String password = passwordController.text;

//       var data = {
//         'username': username,
//         'password': password,
//       };

//       var response = await http.post(
//         Uri.parse('http://192.168.9.35:3000/auth/login'),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//         body: jsonEncode(data),
//       );

//       if (response.statusCode == 200) {
//         // Login successful
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => const HomePage(appState: null,)),
//         );
//       } else {
//         // Login failed
//         showDialog(
//           context: context,
//           builder: (context) => AlertDialog(
//             title: const Text('Login Failed'),
//             content: const Text('Invalid username or password'),
//             actions: <Widget>[
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: const Text('OK'),
//               ),
//             ],
//           ),
//         );
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xffffff8D),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const SizedBox(
//               width: 200,
//               height: 100,
//             ),
//             SizedBox(
//               width: 220,
//               height: 50,
//               child: TextField(
//                 decoration: InputDecoration(
//                   hintText: 'Enter your username',
//                   labelText: 'Username',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(4),
//                   ),
//                   fillColor: Colors.white,
//                 ),
//                 controller: usernameController,
//               ),
//             ),
//             const SizedBox(height: 25),
//             SizedBox(
//               width: 220,
//               height: 50,
//               child: TextField(
//                 obscureText: true,
//                 decoration: InputDecoration(
//                   hintText: 'Enter your password',
//                   labelText: 'Password',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(4),
//                   ),
//                   fillColor: Colors.white,
//                 ),
//                 controller: passwordController,
//               ),
//             ),
//             const SizedBox(height: 50),
//             SizedBox(
//               width: 220,
//               height: 50,
//               child: ElevatedButton(
//                 onPressed: () {
//                   _loginUser(context); // Call login function
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xffffea00),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 child: const Text(
//                   'Login',
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 20,
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 25),
//           ],
//         ),
//       ),
//     );
//   }
// }
