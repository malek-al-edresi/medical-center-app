import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/invoice_details_screen.dart';
import '../screens/lab_results_screen.dart';
import '../screens/radiology_screen.dart';
import '../screens/pdf_preview_screen.dart';

class AppRoutes {
  static const String home = '/';
  static const String invoiceDetails = '/invoice_details';
  static const String labResults = '/lab_results';
  static const String radiology = '/radiology';
  static const String pdfPreview = '/pdf_preview';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case invoiceDetails:
        return MaterialPageRoute(builder: (_) => const InvoiceDetailsScreen());
      case labResults:
        return MaterialPageRoute(builder: (_) => const LabResultsScreen());
      case radiology:
        return MaterialPageRoute(builder: (_) => const RadiologyScreen());
      case pdfPreview:
        return MaterialPageRoute(builder: (_) => const PdfPreviewScreen());
      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Route not found'))),
        );
    }
  }
}
