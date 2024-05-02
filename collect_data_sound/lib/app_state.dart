// import 'package:flutter/material.dart';

// class AppState extends ChangeNotifier {
//   List<int>? recordedAudio;
//   String? recordedFileName;

//   void setRecordedAudio(List<int>? audioData) {
//     recordedAudio = audioData;
//     notifyListeners();
//   }

//   void setRecordedFileName(String? fileName) {
//     recordedFileName = fileName;
//     notifyListeners();
//   }
// }

// import 'package:flutter/material.dart';

// class AppState extends ChangeNotifier {
//   List<int>? recordedAudio;
//   String? recordedFileName;

//   void setRecordedAudio(List<int>? audioData) {
//     recordedAudio = audioData;
//     notifyListeners();
//   }

//   void setRecordedFileName(String? fileName) {
//     recordedFileName = fileName;
//     notifyListeners();
//   }
// }
// import 'package:flutter/material.dart';

// class AppState extends ChangeNotifier {
//   List<int>? recordedAudio;
//   String? recordedFileName;

//   void setRecordedAudio(List<int>? audioData) {
//     recordedAudio = audioData;
//     notifyListeners();
//   }

//   void setRecordedFileName(String? fileName) {
//     recordedFileName = fileName;
//     notifyListeners();
//   }
// }
import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  List<int>? recordedAudio;
  String? _recordedFileName;

  String? get recordedFileName => _recordedFileName;

  void setRecordedAudio(List<int>? audioData) {
    recordedAudio = audioData;
    notifyListeners(); // เพิ่มการเรียกใช้งาน notifyListeners()
  }

  void setRecordedFileName(String? fileName) {
    _recordedFileName = fileName;
    notifyListeners(); // เพิ่มการเรียกใช้งาน notifyListeners()
  }
}

