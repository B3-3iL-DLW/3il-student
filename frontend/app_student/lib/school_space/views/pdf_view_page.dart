import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:app_student/shared_components/app_bar.dart';

class PdfViewPage extends StatelessWidget {
  final String filePath;
  final String documentTitle;

  const PdfViewPage(
      {super.key, required this.filePath, required this.documentTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Column(
        children: [
          Expanded(
            child: PDFView(filePath: filePath),
          ),
        ],
      ),
    );
  }
}
