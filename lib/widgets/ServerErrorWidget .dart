import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Servererrorwidget extends StatelessWidget {
  final VoidCallback? onRetry;

  const Servererrorwidget({super.key, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.cloud_off, color: Colors.white70, size: 60),
            const SizedBox(height: 16),
            Text(
              'Server sedang bermasalah',
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'Mohon coba beberapa saat lagi',
              style: GoogleFonts.poppins(fontSize: 14, color: Colors.white60),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            if (onRetry != null)
              ElevatedButton(
                onPressed: onRetry,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurpleAccent,
                ),
                child: const Text('Coba Lagi'),
              ),
          ],
        ),
      ),
    );
  }
}
