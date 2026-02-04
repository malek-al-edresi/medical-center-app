import 'package:flutter/material.dart';
import '../../core/widgets/empty_state.dart';
import '../layout/app_scaffold.dart';

class PdfPreviewScreen extends StatelessWidget {
  const PdfPreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Placeholder for PDF Preview using pdf_utils
    return const AppScaffold(
      title: 'PDF Preview',
      body: EmptyState(
        message:
            'PDF Generation Preview\n(Implementation pending PDF logic refinement)',
        icon: Icons.picture_as_pdf,
      ),
    );
  }
}
