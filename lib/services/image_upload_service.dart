// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void pickAndUploadImage(
    BuildContext context, Function(String category) onResult) {
  final uploadInput = html.FileUploadInputElement();
  uploadInput.accept = 'image/*';
  uploadInput.click();

  uploadInput.onChange.listen((event) {
    final files = uploadInput.files;
    if (files == null || files.isEmpty) return;

    final file = files.first;
    final reader = html.FileReader();

    reader.readAsArrayBuffer(file);

    reader.onLoadEnd.listen((e) async {
      final uri =
          Uri.parse("http://192.168.1.40:5000/classify"); // your Flask IP

      final request = http.MultipartRequest('POST', uri)
        ..files.add(http.MultipartFile.fromBytes(
          'file',
          reader.result as List<int>,
          filename: file.name,
        ));

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        final result = jsonDecode(responseBody);
        final category = result['category'];
        final confidence = result['confidence'];

        onResult(category); // pass the result to whoever is listening

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  "✅ Classified as $category (${(confidence * 100).toStringAsFixed(2)}%)")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("❌ Upload failed")),
        );
      }
    });
  });
}
