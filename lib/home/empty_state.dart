import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:typed_data';
import 'dart:html' as html;

class EmptyState extends StatefulWidget {
  const EmptyState({super.key});

  @override
  _EmptyStateState createState() => _EmptyStateState();
}

class _EmptyStateState extends State<EmptyState> {
  String _searchQuery = "";
  Uint8List? imageBytes;
  String? imageName;
  final user = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, '/authentication/login1');
  }

  Future<void> _saveDocumentToFirestore(BuildContext context) async {
    if (imageBytes == null || imageName == null || user == null) return;

    await _firestore.collection('Documents').add({
      'fileName': imageName,
      'uploadedBy': user!.email,
      'uploadedAt': Timestamp.now(),
    }).then((_) async {
      String suggestedFolder = await _classifyDocument(imageBytes!, imageName!);

      if (!mounted) return;
      showDialog(
        context: context,
        builder: (_) => SuggestionDialog(
          suggestedFolder: suggestedFolder,
          onSave: (folder) {
            print("Saved to $folder folder");
            Navigator.pushReplacementNamed(context, '/file_screen');
          },
          onChooseManually: () {
            _showManualFolderDialog(context);
          },
        ),
      );
    }).catchError((error) {
      print('Error saving document to Firestore: $error');
    });
  }

  Future<String> _classifyDocument(Uint8List bytes, String fileName) async {
    final uri = Uri.parse("http://192.168.1.40:5000/classify"); // your Flask IP
    final request = http.MultipartRequest('POST', uri)
      ..files.add(
          http.MultipartFile.fromBytes('image', bytes, filename: fileName));

    final response = await request.send();

    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      final decoded = json.decode(responseString);
      return decoded['category'];
    } else {
      throw Exception(
          "Failed to classify image. Status Code: ${response.statusCode}");
    }
  }

  void _showManualFolderDialog(BuildContext context) {
    final folders = [
      "Medical",
      "Education",
      "ID Cards",
      "ATM Cards",
      "Certificate"
    ];

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Choose Folder"),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: folders.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: const Icon(Icons.folder, color: Colors.blue),
                title: Text(folders[index]),
                onTap: () {
                  Navigator.pop(context);
                  print("Saved to ${folders[index]} folder");
                  Navigator.pushReplacementNamed(context, '/file_screen');
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _pickImageFromGallery(BuildContext context) async {
    final input = html.FileUploadInputElement()..accept = 'image/*';
    input.click();

    input.onChange.listen((event) {
      final reader = html.FileReader();
      final file = input.files!.first;
      reader.readAsArrayBuffer(file);

      reader.onLoadEnd.listen((event) async {
        final bytes = reader.result as Uint8List;
        setState(() {
          imageBytes = bytes;
          imageName = file.name;
        });
        await _saveDocumentToFirestore(context);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: signOut,
            icon: const Icon(Icons.logout, size: 24, color: Color(0xFF0071A5)),
          ),
        ],
        automaticallyImplyLeading: false,
        title: Image.asset('assets/logo.png', width: 40, height: 33),
        backgroundColor: Colors.transparent,
        elevation: 0,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Divider(color: Colors.grey, thickness: 1),
        ),
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(17, 14, 17, 0),
          child: Column(
            children: [
              if (user != null)
                Text('Logged in as: ${user!.email}',
                    style:
                        const TextStyle(fontSize: 16, color: Colors.black87)),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: "Search documents",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              if (imageBytes == null)
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/empty_docs.png',
                        width: 179, fit: BoxFit.contain),
                    const SizedBox(height: 10),
                    const Text("You don't have any documents!",
                        style: TextStyle(
                            color: Color(0xFF51506B),
                            fontSize: 14,
                            fontWeight: FontWeight.w500)),
                    const SizedBox(height: 6),
                    const Text(
                        'Scan or add your document by clicking the + button',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color(0x73272643),
                            fontSize: 10,
                            fontWeight: FontWeight.w400)),
                  ],
                ),
              if (imageBytes != null)
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Column(
                    children: [
                      const Text("Selected Image:",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      Image.memory(imageBytes!, height: 150),
                    ],
                  ),
                ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton(
                    onPressed: () => _pickImageFromGallery(context),
                    child: const Icon(Icons.photo_library),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SuggestionDialog extends StatelessWidget {
  final String suggestedFolder;
  final Function(String) onSave;
  final Function onChooseManually;

  const SuggestionDialog({
    super.key,
    required this.suggestedFolder,
    required this.onSave,
    required this.onChooseManually,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: Colors.blueAccent),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text.rich(
            TextSpan(
              text: 'Suggested folder: ',
              children: [
                TextSpan(
                  text: suggestedFolder,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue[900]),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              onSave(suggestedFolder);
            },
            child: const Text('Save'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              onChooseManually();
            },
            child: const Text('Choose Folder Manually'),
          ),
        ],
      ),
    );
  }
}
