import 'dart:async';

import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

class PDFController {
  final String path;
  late PDFViewController viewController;

  final Completer<PDFViewController> pdfViewController =
      Completer<PDFViewController>();

  PDFController({required this.path});

  void turnPage() async {
    int? currentPage = await viewController.getCurrentPage();
    viewController.setPage(currentPage! + 1);
  }
}
