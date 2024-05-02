import 'package:collect_data_sound/home_page.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'app_state.dart';
import 'package:file_picker/file_picker.dart';

class RecordPage extends StatefulWidget {
  final AppState appState;
  final List<int>? recordedAudio;
  final List<int> _tempRecordedAudio = [];
  String? recordedFileName = '';
  File? _selectedAudioFile;
  // RecordPage({Key? key, required this.appState, this.recordedAudio}) : super(key: key);
  RecordPage({
    Key? key,
    required this.appState,
    this.recordedAudio,
    this.recordedFileName,
  }) : super(key: key);

  @override
  _RecordPageState createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
  late AppState _appState;
  FlutterSoundRecorder? _recorder;
  FlutterSoundPlayer? _player;
  bool _isRecording = false;
  late String _audioFilePath;
  late TextEditingController _fileNameController;
  late String recordingTimeStamp;
  String _selectedType = '1';
  String _selectedStatus = 'ยังไม่เสร็จสิ้น';
  late String? _recordedFileName;
  late List<int> _recordedAudio;
  late List<int> _tempRecordedAudio;
  late String file_path;

  @override
  void initState() {
    super.initState();
    _appState = widget.appState;
    _recorder = FlutterSoundRecorder();
    _player = FlutterSoundPlayer();
    _fileNameController = TextEditingController();
    _initAudioFilePath();
    _recordedAudio = widget.recordedAudio ?? [];
    _tempRecordedAudio = widget.recordedAudio ?? [];
    _recordedFileName = widget.recordedFileName;
  }

  Future<void> _initAudioFilePath() async {
    setState(() {
      _audioFilePath = '/storage/emulated/0/Download/';
    });
  }

  @override
  void dispose() {
    _recorder?.closeRecorder();
    _player?.closePlayer();
    _fileNameController.dispose();
    super.dispose();
  }

  void _toggleRecording() {
    if (_isRecording) {
      _stopRecording();
    } else {
      _startRecording();
    }
  }

  void _startRecording() async {
    _tempRecordedAudio.clear();

    var status = await Permission.microphone.status;
    if (!status.isGranted) {
      await Permission.microphone.request();
      status = await Permission.microphone.status;
      await Permission.storage.request();
      status = await Permission.storage.status;
      if (!status.isGranted) {
        if (kDebugMode) {
          print('ไม่ได้รับอนุญาตให้ใช้ไมค์');
          print('ไม่ได้รับอนุญาตให้เข้าถึงไฟล์เสียง');
        }
        return;
      }
    }
    await _initAudioFilePath();
    try {
      // recordingTimeStamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
      recordingTimeStamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
      file_path = '$_audioFilePath/${recordingTimeStamp}_$_selectedType.wav';
      await _recorder?.openRecorder();
      await _recorder?.startRecorder(
        toFile: '$_audioFilePath/${recordingTimeStamp}_$_selectedType.wav',
        codec: Codec.pcm16WAV,
      );
      setState(() {
        _isRecording = true;
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error starting recording: $e');
      }
    }
  }

  void _stopRecording() async {
    try {
      _appState.setRecordedAudio(_recordedAudio);
      await _recorder?.stopRecorder();
      setState(() {
        _isRecording = false;
      });

      if (kDebugMode) {
        print('Recording time stamp: $recordingTimeStamp');
      }

      String fileName = '$recordingTimeStamp'
          '_$_selectedType.wav';

      if (kDebugMode) {
        print(fileName);
      }

      String filePath = '$_audioFilePath/$fileName';
      File recordedFile = File(filePath);
      _recordedAudio = await recordedFile.readAsBytes();
      _tempRecordedAudio = await recordedFile.readAsBytes();

      setState(() {
        _recordedFileName = fileName;
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error stopping recording: $e');
      }
    }
  }

  void _playRecording() async {
    var status = await Permission.storage.status;

    try {
      await _player?.openPlayer();
      await _player?.startPlayer(
        fromURI: '$_audioFilePath/${recordingTimeStamp}_$_selectedType.wav',
        codec: Codec.pcm16WAV,
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error playing recording: $e');
      }
    }
  }

  // Future<void> _uploadAndSaveRecording() async {
  //   try {
  //     String fileName = '${recordingTimeStamp}_$_selectedType.wav';

  //     var url = Uri.parse('http://${dotenv.env['IP']}:3000/upload');
  //     var request = http.MultipartRequest('POST', url);
  //     if (_recordedAudio != null) {
  //       request.files.add(http.MultipartFile.fromBytes(
  //           'audio', _tempRecordedAudio,
  //           filename: fileName));
  //     }

  //     var response = await request.send();
  //     if (response.statusCode == 200) {
  //       if (kDebugMode) {
  //         print('File uploaded successfully');
  //       }

  //       _appState.setRecordedFileName(fileName);

  //       _recordedAudio = _tempRecordedAudio.toList();

  //       File oldFile = File(file_path);
  //       await oldFile.rename('$_audioFilePath/${_appState.recordedFileName}');

  //       setState(() {
  //         _recordedFileName = _appState.recordedFileName;
  //       });
  //       if (kDebugMode) {
  //         print(_appState.recordedFileName);
  //       }

  //       // Send data back to the previous page
  //       // Navigator.pop(context, {
  //       //   'recordedFileName': _recordedFileName,
  //       //   'selectedStatus': _selectedStatus,
  //       // });
  //     } else {
  //       if (kDebugMode) {
  //         print('File upload failed');
  //       }
  //     }
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print('Error uploading recording: $e');
  //     }
  //   }
  // }
  Future<void> _uploadAndSaveRecording() async {
    try {
      String fileName = '${recordingTimeStamp}_$_selectedType.wav';

      var url = Uri.parse('http://${dotenv.env['IP']}:3000/upload');
      var request = http.MultipartRequest('POST', url);
      if (_recordedAudio != null) {
        request.files.add(http.MultipartFile.fromBytes(
            'audio', _tempRecordedAudio,
            filename: fileName));
      }

      var response = await request.send();
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('File uploaded successfully');
        }
      }

      File localFile = File('$_audioFilePath/$fileName');
      await localFile.writeAsBytes(_tempRecordedAudio);

      _appState.setRecordedFileName(fileName);

      _appState.setRecordedAudio(_tempRecordedAudio);

      setState(() {
        _recordedFileName = _appState.recordedFileName;
         _isRecording = false;
      });

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(
            appState: widget.appState,
            recordedAudio: _tempRecordedAudio,
            recordedFileName: fileName,
          ),
        ),
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error saving recording: $e');
      }
    }
  }

  void _selectAudioFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
    );

    if (result != null) {
      PlatformFile file = result.files.first;
      setState(() {
        // เก็บไฟล์เสียงที่เลือกไว้
        // อ่านไฟล์เป็น bytes ก่อนที่จะเก็บไว้
        widget._selectedAudioFile =
            File(file.path!); // เปลี่ยนเป็นวิธีการในการเก็บไฟล์ที่ถูกเลือก
      });
    } else {
      // ผู้ใช้ยกเลิกการเลือกไฟล์
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('collect data sound'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _isRecording
                ? ElevatedButton(
                    onPressed: _stopRecording,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Stop Recording'),
                  )
                : ElevatedButton(
                    onPressed: _startRecording,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Start Recording'),
                  ),
            const SizedBox(height: 20),
            !_isRecording
                ? ElevatedButton(
                    onPressed: _playRecording,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Play Recording'),
                  )
                : Container(),
            const SizedBox(
              width: 220,
              height: 60,
              child: TextField(
                // obscureText: true,
                decoration: InputDecoration(
                  labelText: 'สถานที่',
                  fillColor: Colors.white,
                ),
              ),
            ),
            SizedBox(
              width: 220,
              height: 70,
              child: DropdownButtonFormField<String>(
                value: _selectedType,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedType = newValue ?? '1';
                    if (_selectedStatus == 'เสร็จสิ้น' &&
                        _recordedAudio.isNotEmpty) {}
                  });
                },
                items: <String>['1', '2', '3', '4', '5', '6']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: const InputDecoration(labelText: 'Type'),
              ),
            ),
            SizedBox(
              width: 220,
              height: 70,
              child: DropdownButtonFormField<String>(
                value: _selectedStatus,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedStatus = newValue ?? 'ยังไม่เสร็จสิ้น';
                    if (_selectedStatus == 'เสร็จสิ้น' &&
                        _recordedAudio.isNotEmpty) {}
                  });
                },
                items: <String>['ยังไม่เสร็จสิ้น', 'เสร็จสิ้น']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: const InputDecoration(labelText: 'Status'),
              ),
            ),
            const SizedBox(height: 20),
            // const SizedBox(height: 20),
            SizedBox(
              width: 150,
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  if (_selectedStatus == 'เสร็จสิ้น' &&
                      _recordedAudio.isNotEmpty) {
                    await _uploadAndSaveRecording();
                    // สั่งให้แอพหยุดบันทึกเสียงเมื่อการอัปโหลดเสร็จสิ้น
                    setState(() {
                      _isRecording = false;
                    });
                    // ส่งข้อมูลกลับไปยังหน้าก่อนหน้า
                    // Navigator.pop(context, {
                    //   'recordedFileName': _recordedFileName,
                    //   'selectedStatus': _selectedStatus,
                    // });
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => HomePage(
                    //       appState: widget.appState,
                    //       recordedAudio: widget.appState.recordedAudio,
                    //       recordedFileName: widget.appState.recordedFileName,
                    //     ),
                    //   ),
                    // );


                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => HomePage(
                    //       appState: widget.appState,
                    //       recordedAudio: _tempRecordedAudio,
                    //       recordedFileName: _recordedFileName,
                    //     ),
                    //   ),
                    // );


                  }
                  // else {
                  //   Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => HomePage(
                  //         appState: widget.appState,
                  //         recordedAudio: widget.appState.recordedAudio,
                  //         recordedFileName: widget.appState.recordedFileName,
                  //       ),
                  //     ),
                  //   );
                  // }
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'บันทึก',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Text(
              _recordedFileName ?? 'ไม่มีไฟล์',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              _recordedFileName == null || _selectedStatus != 'เสร็จสิ้น'
                  ? 'ไม่มีไฟล์'
                  : _recordedFileName!,
              style: const TextStyle(fontSize: 16),
            ),

            Text(
              _selectedStatus ?? 'ไม่มีสถานะ',
              style: const TextStyle(fontSize: 16),
            ),
            // Text(
            //   widget.recordedFileName ?? 'ไม่มีไฟล์',
            //   style: const TextStyle(fontSize: 16),
            // ),
          ],
        ),
      ),
    );
  }
}
