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
      color: const Color(0xFF121350), // background header
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Material(
        elevation: 2,
        color: Colors.white12,
        borderRadius: BorderRadius.circular(12),
        child: TextField(
          controller: controller,
          onChanged: onChanged,
          style: Theme.of(context).textTheme.bodyMedium,
          cursorColor: Colors.white70,
          decoration: InputDecoration(
            hintText: "Search your vibe...",
            hintStyle: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.white54),
            border: InputBorder.none,
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(vertical: 12),
            prefixIcon: const Icon(
              Icons.search,
              color: Colors.white70,
              size: 24,
            ),
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
