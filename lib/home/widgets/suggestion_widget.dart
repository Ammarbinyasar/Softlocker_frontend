import 'package:flutter/material.dart';

class SuggestionDialog {
  static void showFolderDialog(BuildContext context, String suggestedFolder,
      Function(String folderName) onSave) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
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
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[900],
                    ),
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
                _showManualFolderDialog(context, onSave);
              },
              child: const Text('Choose Folder Manually'),
            ),
          ],
        ),
      ),
    );
  }

  static void _showManualFolderDialog(
      BuildContext context, Function(String folderName) onSave) {
    final folders = [
      "Medical",
      "Education",
      "ID Cards",
      "ATM Cards",
      "Certificate",
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
                  onSave(folders[index]);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
