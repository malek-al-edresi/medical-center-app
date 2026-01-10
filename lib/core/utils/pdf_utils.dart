import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class PdfUtils {
  static Future<void> generateAndSharePDF(String content) async {
    final PdfDocument document = PdfDocument();
    final page = document.pages.add();
    page.graphics.drawString(
      content,
      PdfStandardFont(PdfFontFamily.helvetica, 14),
    );
    List<int> bytes = await document.save();
    document.dispose();

    final directory = await getTemporaryDirectory();
    final path = '${directory.path}/report.pdf';
    final file = File(path);
    await file.writeAsBytes(bytes, flush: true);
    // ignore: deprecated_member_use
    Share.shareXFiles([XFile(file.path)], text: 'نتائج الفاتورة بصيغة PDF');
  }
}
