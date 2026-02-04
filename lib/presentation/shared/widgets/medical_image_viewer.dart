import 'package:flutter/material.dart';

class MedicalImageViewer extends StatelessWidget {
  final String imageUrl;

  const MedicalImageViewer({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Stack(
        alignment: Alignment.center,
        children: [
          InteractiveViewer(
            child: Image.network(
              imageUrl,
              loadingBuilder: (ctx, child, progress) {
                if (progress == null) return child;
                return const Center(child: CircularProgressIndicator());
              },
              errorBuilder: (ctx, err, stack) =>
                  const Icon(Icons.broken_image, color: Colors.white, size: 50),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }
}
