import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GenreChip extends StatelessWidget {
  final String name;

  const GenreChip(this.name, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(name, style: GoogleFonts.poppins(color: Colors.white)),
    );
  }
}
