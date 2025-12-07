import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart'; // هذا هو الاستيراد الناقص
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';

class ExportUtils {
  static Future<void> exportAsPdfWithQR({
    required BuildContext context,
    required String invoiceId,
    required Map<String, String> data,
  }) async {
    final pdf = pw.Document();
    final ScreenshotController screenshotController = ScreenshotController();

    final qrWidget = QrImageView(
      data: invoiceId,
      version: QrVersions.auto,
      size: 120.0,
      backgroundColor: Colors.white,
    );

    final qrImage = await screenshotController.captureFromWidget(
      Material(
        type: MaterialType.transparency,
        child: Center(child: qrWidget),
      ),
    );

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('Patient Report - Invoice ID: $invoiceId',
                style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 20),
            ...data.entries.map((e) =>
                pw.Text('${e.key}: ${e.value}', style: pw.TextStyle(fontSize: 14))),
            pw.SizedBox(height: 30),
            pw.Image(pw.MemoryImage(qrImage), width: 120, height: 120),
          ],
        ),
      ),
    );

    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save());
  }
}
