import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'empty_state.dart';
import 'profile_screen.dart';
import 'widgets/suggestion_widget.dart' as suggestion_widget;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:typed_data';

class HomeFolderScreen extends StatefulWidget {
  const HomeFolderScreen({super.key});

  @override
  _HomeFolderScreenState createState() => _HomeFolderScreenState();
}

class _HomeFolderScreenState extends State<HomeFolderScreen> {
  final List<Map<String, dynamic>> folders = [
    {'name': 'Medical', 'items': 0, 'size': 0},
    {'name': 'ID Cards', 'items': 0, 'size': 0},
  ];

  String _searchQuery = "";
  File? image;
  Uint8List? _webImageBytes;
  final user = FirebaseAuth.instance.currentUser;

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, '/authentication/login1.dart');
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        image = File(pickedFile.path);
        _webImageBytes = bytes;
      });
      _processImage(File(pickedFile.path));
    }
  }

  Future<void> _processImage(File img) async {
    String suggestedFolder = await _classifyImage(img);

    if (!mounted) return;
    suggestion_widget.SuggestionDialog.showFolderDialog(
        context, suggestedFolder, (folderName) {
      _saveImageToFolder(img, folderName);
    });
  }

  Future<String> _classifyImage(File image) async {
    final uri = Uri.parse("http://192.168.124.114:5000/classify");
    print("Sending image to: $uri");

    final request = http.MultipartRequest('POST', uri)
      ..files.add(await http.MultipartFile.fromPath('file', image.path));

    try {
      final response = await request.send().timeout(Duration(seconds: 10));
      print("Got response: ${response.statusCode}");

      if (response.statusCode == 200) {
        final resString = await response.stream.bytesToString();
        final decoded = json.decode(resString);
        print("Prediction: ${decoded['prediction']}");
        return decoded['prediction'];
      } else {
        print("Error from server: ${response.statusCode}");
        throw Exception("Failed to classify image");
      }
    } catch (e) {
      print("Exception during classification: $e");
      throw e;
    }
  }

  void _saveImageToFolder(File image, String folderName) {
    setState(() {
      var folder =
          folders.firstWhere((f) => f['name'] == folderName, orElse: () {
        folders.add({'name': folderName, 'items': 0, 'size': 0});
        return folders.last;
      });
      folder['items'] += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredFolders = folders.where((folder) {
      return folder["name"]!.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()));
            },
            icon: const Icon(Icons.account_circle,
                size: 42, color: Color(0xFF0071A5)),
          ),
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
                Text('Logged in as: ${user!.email}}',
                    style:
                        const TextStyle(fontSize: 16, color: Colors.black87)),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                child: TextField(
                  onChanged: (value) => setState(() => _searchQuery = value),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: "Search folders",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: filteredFolders.isEmpty
                    ? const EmptyState()
                    : GridView.builder(
                        itemCount: filteredFolders.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 16.0,
                          mainAxisSpacing: 16.0,
                          childAspectRatio: 0.8,
                        ),
                        itemBuilder: (context, index) {
                          final folder = filteredFolders[index];
                          return GestureDetector(
                            onTap: () =>
                                _showFolderOptions(context, folder['name']),
                            child: Column(
                              children: [
                                const Icon(Icons.folder,
                                    color: Color(0xFF0071A5), size: 50),
                                const SizedBox(height: 8),
                                Text(folder['name'],
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF0071A5))),
                                Text("${folder['items']} items",
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.black54)),
                                Text("${folder['size']} KB",
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.black54)),
                              ],
                            ),
                          );
                        },
                      ),
              ),
              if (_webImageBytes != null)
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Column(
                    children: [
                      const Text("Selected Image:",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      Image.memory(_webImageBytes!, height: 150),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          if (image != null) {
                            _processImage(image!);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0071A5),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 12),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        child: const Text("Continue",
                            style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton(
                    onPressed: () => _pickImage(ImageSource.gallery),
                    child: const Icon(Icons.photo_library),
                  ),
                  const SizedBox(width: 10),
                  FloatingActionButton(
                    onPressed: () => _pickImage(ImageSource.camera),
                    child: const Icon(Icons.camera_alt),
                  ),
                ],
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  void _showFolderOptions(BuildContext context, String folderName) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(folderName,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.share),
                title: const Text("Share"),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.drive_file_rename_outline),
                title: const Text("Rename"),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.folder_open),
                title: const Text("Move"),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title:
                    const Text("Delete", style: TextStyle(color: Colors.red)),
                onTap: () {
                  setState(() {
                    folders
                        .removeWhere((folder) => folder["name"] == folderName);
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
