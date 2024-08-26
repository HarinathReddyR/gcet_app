// import 'dart:html';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

class PdfViewer extends StatefulWidget {
  final String pdfPath;
  const PdfViewer({
    super.key,
    required this.pdfPath,
  });

  @override
  State<PdfViewer> createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  late PdfControllerPinch pdfControllerPinch;
  int totPageCount = 0, currentPage = 1;
  bool isNavigating = false;

  @override
  void initState() {
    super.initState();
    pdfControllerPinch =
        PdfControllerPinch(document: PdfDocument.openAsset(widget.pdfPath));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "pdf",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("totPages : ${totPageCount}"),
              IconButton(
                onPressed: () {
                  pdfControllerPinch.previousPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.linear);
                },
                // r_previousPage,
                icon: Icon(Icons.arrow_back),
              ),
              Text("Current Page:${currentPage}"),
              IconButton(
                onPressed: () {
                  pdfControllerPinch.nextPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.linear);
                },
                icon: Icon(Icons.arrow_forward),
              )
            ],
          ),
          _pdfview(),
        ],
      ),
    );
  }

  Widget _pdfview() {
    return Expanded(
      child: PdfViewPinch(
        controller: pdfControllerPinch,
        scrollDirection: Axis.vertical,
        onDocumentLoaded: (doc) {
          setState(() {
            totPageCount = doc.pagesCount;
          });
        },
        onPageChanged: (page) {
          setState(() {
            currentPage = page;
          });
        },
      ),
    );
  }

  // void _previousPage() {
  //   if (!isNavigating) {
  //     setState(() => isNavigating = true);
  //     pdfControllerPinch
  //         .previousPage(
  //           duration: Duration(milliseconds: 500),
  //           curve: Curves.linear,
  //         )
  //         .whenComplete(() => setState(() => isNavigating = false));
  //   }
  // }

  // void _nextPage() {
  //   if (!isNavigating) {
  //     setState(() => isNavigating = true);
  //     pdfControllerPinch
  //         .nextPage(
  //           duration: Duration(milliseconds: 500),
  //           curve: Curves.linear,
  //         )
  //         .whenComplete(() => setState(() => isNavigating = false));
  //   }
  // }
}
