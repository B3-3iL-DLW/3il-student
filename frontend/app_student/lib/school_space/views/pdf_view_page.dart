import 'package:app_student/utils/custom_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PdfViewPage extends StatelessWidget {
  final String filePath;

  const PdfViewPage({super.key, required this.filePath});

  @override
  Widget build(BuildContext context) {
    return CustomLayout(
      appBar: AppBar(
        title: const Text('PDF View'),
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () {
              // Implement your download functionality here
            },
          ),
        ],
      ),
      body: PDFView(filePath: filePath),
    );
  }
}
