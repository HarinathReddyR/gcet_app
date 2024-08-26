import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:gcet_app/api/api_connection.dart';
import 'package:gcet_app/common/pdfViewer.dart';
import 'package:gcet_app/common/downloadFile.dart';
import 'package:gcet_app/models/book_model.dart';
import 'package:flutter/material.dart';
import 'package:gcet_app/theme/theme.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class BookDetailsPage extends StatefulWidget {
  final Book book;
  final Function(Book) onBookRead;

  const BookDetailsPage({required this.book, required this.onBookRead});

  @override
  State<BookDetailsPage> createState() => _BookDetailsPageState();
}

class _BookDetailsPageState extends State<BookDetailsPage> {
  OverlayEntry? _overlayEntry;
  @override
  Widget build(BuildContext context) {
    final screensize = MediaQuery.of(context).size;
    final Book book = widget.book;

    return Scaffold(
      appBar: _appbar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Material(
                  elevation: 20,
                  borderRadius: BorderRadius.circular(20),
                  shadowColor: Colors.black.withOpacity(0.5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(widget.book.imageUrl,
                        width: 200, height: 280, fit: BoxFit.cover),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Column(
                  children: [
                    Text(
                      book.title,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'By Tennen bumb',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.star, color: Colors.orange, size: 20),
                        SizedBox(width: 5),
                        Text(
                          '4.5',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              // Center(
              //   child: Wrap(
              //     spacing: 25.0,
              //     runSpacing: 25.0,
              //     alignment: WrapAlignment.center,
              //     runAlignment: WrapAlignment.center,
              //     children: [
              //       _buildDetailColumn(Icons.book, '240'),
              //       _buildDetailColumn(Icons.language, 'ENG'),
              //       _buildDetailColumn(Icons.access_time, '02 hr'),
              //       _buildDetailColumn(Icons.memory, '512 MB'),
              //     ],
              //   ),
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildDetailColumn(Icons.book, '240'),
                  _buildDetailColumn(Icons.language, 'ENG'),
                  _buildDetailColumn(Icons.memory, '512 MB'),
                ],
              ),
              // SingleChildScrollView(
              //   scrollDirection: Axis.horizontal,
              //   child: Row(
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     mainAxisAlignment:
              //         MainAxisAlignment.spaceEvenly, // Align items to start
              //     children: [
              //       _buildDetailColumn(Icons.book, '240'),
              //       _buildDetailColumn(Icons.language, 'ENG'),
              //       _buildDetailColumn(Icons.memory, '25 MB'),
              //       _buildDetailColumn(Icons.memory, '25 MB'),
              //       // Add more _buildDetailColumn as needed
              //     ],
              //   ),
              // ),
              const SizedBox(height: 30),
              subheading("About"),
              const SizedBox(height: 10),
              Description(
                  "Our DAA Tutorial includes all topics of algorithm, asymptotic analysis, algorithm control structure, recurrence, master method, recursion tree method, simple sorting algorithm, bubble sort, selection sort, insertion sort, divide and conquer, binary search, merge sort, counting sort, lower bound theory etc."),
              const SizedBox(
                height: 15,
              ),
              Container(
                height: 40,
                width: MediaQuery.of(context)
                    .size
                    .width, // Set the width to the screen width
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor:
                        Color.fromARGB(255, 25, 90, 211), // Text color
                    elevation: 5, // Button elevation
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30), // Circular edges
                    ),
                  ),
                  onPressed: () {
                    widget.onBookRead(widget.book); // Execute the callback
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PdfViewer(
                          pdfPath: widget.book.bookUrl,
                        ), // Navigate to PdfViewer
                      ),
                    );
                  },
                  child: Text(
                    "Read",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _appbar() {
    return AppBar(
      backgroundColor: Colors.white, // Set AppBar background color to white
      leading: IconButton(
        icon: const Icon(CupertinoIcons.back, color: Colors.black),
        onPressed: () {
          Navigator.pop(context); // Navigate back to the previous page
        },
      ),
      actions: [
        Stack(
          children: [
            IconButton(
              icon: Icon(Icons.more_vert_sharp, color: Colors.black),
              onPressed: () {
                _showMenu(context);
              },
            ),
          ],
        ),
      ],
      elevation: 0, // Remove AppBar shadow
    );
  }

  Column _buildDetailColumn(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, size: 30, color: Colors.green),
        SizedBox(height: 5),
        Text(label, style: TextStyle(fontSize: 16)),
      ],
    );
  }

  void _showMenu(BuildContext context) {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    _overlayEntry = _createOverlayEntry(context, size, offset);

    Overlay.of(context)?.insert(_overlayEntry!);
  }

  OverlayEntry _createOverlayEntry(
      BuildContext context, Size size, Offset offset) {
    return OverlayEntry(
      builder: (context) => GestureDetector(
        onTap: () {
          _hideMenu();
        },
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(color: Colors.transparent),
            ),
            Positioned(
              top: 10, //offset.dy + 10, // Adjust position as needed
              right:
                  10, //size.width - offset.dx - 10, // Adjust position as needed
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildMenuItem(
                        icon: widget.book.inList
                            ? Icons.remove_circle_outline
                            : Icons.add_circle_outline_outlined,
                        text: 'MyList',
                        onTap: () {
                          _toggleReadList();
                        },
                      ),
                      _buildMenuItem(
                        icon: Icons.ios_share_sharp,
                        text: 'Share',
                        onTap: () {
                          _hideMenu();
                          // Perform respective action here
                          print('share');
                        },
                      ),
                      _buildMenuItem(
                        icon: Icons.download_rounded,
                        text: 'Download',
                        onTap: () {
                          _hideMenu();
                          _downloadFile('abhi.pdf');
                          // Perform respective action here
                          print('Downloaded');
                        },
                      ),
                      _buildMenuItem(
                        icon: Icons.insert_chart,
                        text: 'Activity Log',
                        onTap: () {
                          _hideMenu();
                          // Perform respective action here
                          print('Activity Log');
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _hideMenu() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _toggleReadList() async {
    try {
      await toggleReadListReqquest(widget.book.id);
      setState(() {
        widget.book.inList = !widget.book.inList;
        _overlayEntry?.remove(); // Remove the old overlay
        _overlayEntry = _createOverlayEntry(
            context, Size.zero, Offset.zero); // Create a new one
        Overlay.of(context)?.insert(_overlayEntry!); // Insert the new overlay
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        child: Row(
          children: [
            Icon(icon, color: Colors.white),
            SizedBox(width: 16.0),
            Text(
              text,
              style: TextStyle(color: Colors.white, fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> checkAndRequestStoragePermission() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      status = await Permission.storage.request();
      openAppSettings();
    }
    return status.isGranted;
    // Map<Permission, PermissionStatus> statuses = await [
    //   Permission.storage,
    //   Permission.manageExternalStorage,
    // ].request();

    // if (statuses[Permission.storage]!.isGranted ||
    //     statuses[Permission.manageExternalStorage]!.isGranted) {
    //   return true;
    // } else {
    //   return false;
    // }
    // if (await Permission.storage.isPermanentlyDenied) {
    //   openAppSettings(); // Opens the app settings to manually allow permissions
    // }
    // if (await Permission.storage.isGranted) {
    //   return true;
    // }

    // // Request storage permission (for Android 9 and below)
    // var status = await Permission.storage.request();
    // if (status.isGranted) {
    //   return true;
    // }

    // // For Android 10+, check MANAGE_EXTERNAL_STORAGE permission
    // if (await Permission.manageExternalStorage.isGranted) {
    //   return true;
    // }

    // // Request MANAGE_EXTERNAL_STORAGE permission for Android 10+
    // status = await Permission.manageExternalStorage.request();
    // return status.isGranted;
  }

  Future<void> _downloadFile(String filename) async {
    // try {
    //   await checkAndRequestStoragePermission();

    //   // Get the directory for the downloads/textbooks
    //   Directory? directory = await getExternalStorageDirectory();
    // if (directory != null) {
    //   String newPath = '';
    //   List<String> folders = directory.path.split('/');
    //   for (int x = 1; x < folders.length; x++) {
    //     String folder = folders[x];
    //     if (folder != 'Android') {
    //       newPath += '/' + folder;
    //     } else {
    //       break;
    //     }
    //   }
    //   newPath = newPath + '/Downloads/Textbooks';
    //   directory = Directory(newPath);

    //       if (!await directory.exists()) {
    //         await directory.create(recursive: true);
    //       }

    //       // File download path
    //       String filePath = '${directory.path}/$filename';

    //       // Dio instance for downloading
    //       Dio dio = Dio();

    //       // Download the file
    //       await dio.download(
    //         'http://192.168.1.5:3000/download/$filename', // Replace with your server's URL
    //         filePath,
    //         onReceiveProgress: (received, total) {
    //           if (total != -1) {
    //             print(
    //                 'Received: ${(received / total * 100).toStringAsFixed(0)}%');
    //           }
    //         },
    //       );

    //       print('File downloaded to $filePath');
    //     }
    //   } catch (e) {
    //     print('Error downloading file: $e');
    //   }
    // }
    bool permissionGranted = await checkAndRequestStoragePermission();
    if (!permissionGranted) {
      print('Storage permission NOT GRANTED....');
      return;
    }

    try {
      // Get the app-specific directory for external storage
      Directory? directory = await getExternalStorageDirectory();
      if (directory != null) {
        // Create a new directory inside the external storage for your textbooks
        String newPath = '${directory.path}/Textbooks';
        directory = Directory(newPath);

        if (!await directory.exists()) {
          await directory.create(recursive: true);
        }

        // File download path
        String filePath = '${directory.path}/$filename';

        // Dio instance for downloading
        Dio dio = Dio();

        // Download the file
        await dio.download(
          'http://192.168.1.5:3000/download/$filename', // Replace with your server's URL
          filePath,
          onReceiveProgress: (received, total) {
            if (total != -1) {
              print(
                  'Received: ${(received / total * 100).toStringAsFixed(0)}%');
            }
          },
        );

        print('File downloaded to $filePath');
      }
    } catch (e) {
      print('Error downloading file: $e');
    }
  }
}
