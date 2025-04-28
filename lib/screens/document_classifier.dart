// lib/screens/document_classifier.dart

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:convert';

class DocumentClassifier extends StatefulWidget {
  const DocumentClassifier({super.key});

  @override
  _DocumentClassifierState createState() => _DocumentClassifierState();
}

class _DocumentClassifierState extends State<DocumentClassifier> {
  File? _imageFile;
  String? _predictionResult;
  bool _loading = false;

  Future<void> pickAndClassifyImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) return;

    setState(() {
      _imageFile = File(pickedFile.path);
      _loading = true;
      _predictionResult = null;
    });

    var uri = Uri.parse(
        'http://127.0.0.1:5000/classify'); // use local IP for emulator or actual IP for real device
    var request = http.MultipartRequest('POST', uri);
    request.files
        .add(await http.MultipartFile.fromPath('file', _imageFile!.path));

    try {
      var response = await request.send();
      var responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        var data = jsonDecode(responseBody);
        setState(() {
          _predictionResult =
              "Category: ${data['category']}\nConfidence: ${(data['confidence'] * 100).toStringAsFixed(2)}%";
        });
      } else {
        setState(() {
          _predictionResult = 'Failed to classify document.';
        });
      }
    } catch (e) {
      setState(() {
        _predictionResult = 'Error: $e';
      });
    }

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Document Classifier'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (_imageFile != null) Image.file(_imageFile!, height: 200),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: pickAndClassifyImage,
              child: Text('Pick and Classify Image'),
            ),
            SizedBox(height: 24),
            if (_loading) CircularProgressIndicator(),
            if (_predictionResult != null)
              Text(
                _predictionResult!,
                style: TextStyle(fontSize: 16),
              ),
          ],
        ),
      ),
    );
  }
}
