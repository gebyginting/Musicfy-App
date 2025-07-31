import 'package:flutter/material.dart';

class SearchBarDelegate extends SliverPersistentHeaderDelegate {
  final TextEditingController controller;
  final Function(String) onChanged;
  final VoidCallback onClear;

  SearchBarDelegate({
    required this.controller,
    required this.onChanged,
    required this.onClear,
  });

  @override
  double get minExtent => 64;

  @override
  double get maxExtent => 64;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: const Color(0xFF121350),
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white12,
          borderRadius: BorderRadius.circular(12),
        ),
        child: TextField(
          controller: controller,
          style: const TextStyle(color: Colors.white),
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: "Search your vibe...",
            hintStyle: const TextStyle(color: Colors.white70),
            border: InputBorder.none,
            prefixIcon: const Icon(Icons.search, color: Colors.white70),
            suffixIcon:
                controller.text.isNotEmpty
                    ? IconButton(
                      icon: const Icon(Icons.clear, color: Colors.white),
                      onPressed: onClear,
                    )
                    : null,
          ),
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SearchBarDelegate oldDelegate) {
    return controller != oldDelegate.controller;
  }
}
