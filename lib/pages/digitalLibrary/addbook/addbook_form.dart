import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gcet_app/api/api_connection.dart';
import 'package:gcet_app/theme/theme.dart';
import 'dart:html' as html;

class AddBook extends StatefulWidget {
  const AddBook({super.key});

  @override
  State<AddBook> createState() => _AddBookState();
}

class _AddBookState extends State<AddBook> {
  final _titleController = TextEditingController();
  final _authorController = TextEditingController();
  final _aboutController = TextEditingController();
  PlatformFile? selectedFile;
  //final _Controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(context),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              heading("Post Book"),
              _inputField("Title", Icons.title_sharp, _titleController),
              _inputField("Author", Icons.person, _authorController),
              _inputField("about", Icons.description, _aboutController),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: selectedFile == null ? _selectFiles : null,
                  child: const Text("select")),
              if (selectedFile != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        'Selected File: ${selectedFile!.name}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: _deselectFile,
                    ),
                  ],
                ),
              if (selectedFile != null)
                TextButton(
                  onPressed: () {
                    postBook(_titleController.text, _authorController.text,
                        _aboutController.text, selectedFile!);
                  },
                  child: Text("submit"),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _selectFiles() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null && result.files.isNotEmpty) {
        final file = result.files.single;
        setState(() {
          selectedFile = result.files.single;
        });
        // Check if we're on the web
        if (file.bytes != null) {
          // Web: Handle file using bytes
          final bytes = file.bytes!;
          print("File selected with ${bytes.length} bytes.");

          // Optionally, create a Blob URL for web applications
          final blob = html.Blob([Uint8List.fromList(bytes)]);
          final url = html.Url.createObjectUrlFromBlob(blob);
          print("Blob URL: $url");

          // You can use this URL to display or download the file if needed
        } else if (file.path != null) {
          // Mobile (or if `path` is available): Handle file using path
          String filePath = file.path!;
          print("File selected with path: $filePath");

          // If needed, you can use the file path for further operations
          // e.g., loading the file into a File object (for mobile)
          // File file = File(filePath);
        } else {
          print("No file data available.");
        }
      } else {
        // User canceled the picker or no files selected
        print("User canceled the picker or no files selected.");
      }
    } catch (e) {
      // Catch any potential errors
      print("Error occurred while picking files: $e");
    }
  }

  void _deselectFile() {
    setState(() {
      selectedFile = null;
    });
  }

  Widget _inputField(String s, IconData ic, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5.5),
      child: SizedBox(
        height: 50,
        child: Material(
          elevation: 8,
          shadowColor: Colors.black12,
          color: Colors.transparent,
          borderRadius: BorderRadiusDirectional.circular(30),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: s,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none),
              fillColor: Colors.blue.withOpacity(0.2),
              filled: true,
              prefixIcon: Icon(ic),
            ),
          ),
        ),
      ),
    );
  }

  AppBar _appbar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(CupertinoIcons.back, color: Colors.black),
        onPressed: () {
          Navigator.pop(context); // Navigate back to the previous page
        },
      ),
      title: heading("Add Book"),
    );
  }
}
