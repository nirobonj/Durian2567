// import 'package:flutter/material.dart';
// import 'record_page.dart';
// import 'app_state.dart';
// // import 'package:provider/provider.dart';

// class HomePage extends StatefulWidget {
//   // const HomePage({Key? key, required this.appState, this.recordedAudio}) : super(key: key);
//   final AppState appState;
//   final List<int>? recordedAudio;
//   String? recordedFileName;
//   // const HomePage({Key? key, required this.appState, this.recordedAudio}) : super(key: key);
//   HomePage({super.key, required this.appState, this.recordedAudio, this.recordedFileName});
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Home Page'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Text(
//               'Welcome to the Home Page!',
//               style: TextStyle(fontSize: 24),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => RecordPage(
//                       appState: widget.appState,
//                       recordedAudio: widget.appState.recordedAudio,
//                       recordedFileName: widget.appState.recordedFileName,
//                     ),
//                   ),
//                 );
//               },
//               child: const Text('Go to Record Page'),
//             ),
//             Text(
//               recordedFileName ?? 'ไม่มีไฟล์',
//               style: const TextStyle(fontSize: 16),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'record_page.dart';
import 'app_state.dart';
// import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  // const HomePage({Key? key, required this.appState, this.recordedAudio}) : super(key: key);
  final AppState appState;
  final List<int>? recordedAudio;
  String? recordedFileName;
  // const HomePage({Key? key, required this.appState, this.recordedAudio}) : super(key: key);
  HomePage(
      {super.key,
      required this.appState,
      this.recordedAudio,
      this.recordedFileName});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to the Home Page!',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => RecordPage(
            //           appState: widget.appState,
            //           recordedAudio: widget.appState.recordedAudio,
            //           recordedFileName: widget.appState.recordedFileName,
            //         ),
            //       ),
            //     );
            //   },
            //   child: const Text('Go to Record Page'),
            // ),
            ElevatedButton(
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RecordPage(
                      appState: widget.appState,
                      recordedAudio: widget.appState.recordedAudio,
                      recordedFileName: widget.appState.recordedFileName,
                    ),
                  ),
                );
                if (result != null) {
                  setState(() {
                    // อัปเดต recordedFileName ในสถานะของ HomePage
                    widget.recordedFileName =
                        result['recordedFileName'];
                    // คุณสามารถอัปเดตค่าอื่นๆ ได้เช่นกัน
                  });
                }
              },
              child: const Text('ไปที่ Record Page'),
            ),

            Text(
              widget.recordedFileName ?? 'ไม่มีไฟล์',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
