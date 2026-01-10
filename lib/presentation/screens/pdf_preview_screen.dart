import 'package:flutter/material.dart';
import '../../core/widgets/empty_state.dart';

class PdfPreviewScreen extends StatelessWidget {
  const PdfPreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Placeholder for PDF Preview using pdf_utils
    return Scaffold(
      appBar: AppBar(title: const Text('PDF Preview')),
      body: const EmptyState(
        message:
            'PDF Generation Preview\n(Implementation pending PDF logic refinement)',
        icon: Icons.picture_as_pdf,
      ),
    );
  }
}
