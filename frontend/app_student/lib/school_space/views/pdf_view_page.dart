import 'package:app_student/utils/custom_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PdfViewPage extends StatelessWidget {
  final String filePath;

  const PdfViewPage({super.key, required this.filePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PDFView(filePath: filePath),
    );
  }
}
