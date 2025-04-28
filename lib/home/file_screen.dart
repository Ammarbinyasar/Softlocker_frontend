import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Firestore

class FileScreen extends StatelessWidget {
  const FileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Uploaded Files"),
        backgroundColor: Color(0xFF0071A5),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Documents').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final documents = snapshot.data!.docs;

          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context, index) {
              var doc = documents[index];
              return ListTile(
                title: Text(doc['fileName']),
                subtitle: Text("Uploaded by: ${doc['uploadedBy']}"),
                trailing: Text(
                  (doc['uploadedAt'] as Timestamp).toDate().toString(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
