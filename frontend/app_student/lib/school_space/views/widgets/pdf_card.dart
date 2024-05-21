import 'package:flutter/material.dart';
import 'package:app_student/utils/custom_theme.dart';

import 'pdf_view.dart';

class PdfCard extends StatelessWidget {
  final String filePath;
  final String title;

  const PdfCard({super.key, required this.filePath, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: CustomTheme.primaryColor,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(10.0),
        leading: const Icon(Icons.picture_as_pdf, color: Colors.white),
        title: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PdfViewPage(filePath: filePath),
            ),
          );
        },
      ),
    );
  }
}
