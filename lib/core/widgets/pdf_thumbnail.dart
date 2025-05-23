import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
import 'package:dio/dio.dart';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';

class PdfThumbnail extends StatelessWidget {
  final String pdfUrl; // URL dari API

  const PdfThumbnail({super.key, required this.pdfUrl});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List?>(
      future: _downloadAndRenderThumbnail(pdfUrl),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            width: 150,
            height: 200,
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return const Icon(Icons.error, color: Colors.red);
        } else if (snapshot.hasData && snapshot.data != null) {
          return Image.memory(
            snapshot.data!,
            width: 150,
            height: 200,
            fit: BoxFit.cover,
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Future<Uint8List?> _downloadAndRenderThumbnail(String url) async {
    final dio = Dio();
    try {
      final tempDir = await getTemporaryDirectory();
      final filePath =
          '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.pdf';

      // 1. Download file PDF ke file lokal
      await dio.download(
        url,
        filePath,
        options: Options(responseType: ResponseType.bytes),
      );

      // 2. Render halaman pertama PDF
      final doc = await PdfDocument.openFile(filePath);
      final page = await doc.getPage(1);
      final pageImage = await page.render(
        width: 300,
        height: 400,
        backgroundColor: '#FFFFFF',
      );
      await page.close();
      await doc.close();

      return pageImage?.bytes;
    } catch (e) {
      print('Error downloading or rendering PDF: $e');
      return null;
    }
  }
}
