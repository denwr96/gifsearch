import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const SearchTextField({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: const InputDecoration(
        hintText: 'Search GIFs...',
        prefixIcon: Icon(Icons.search),
      ),
    );
  }
}
