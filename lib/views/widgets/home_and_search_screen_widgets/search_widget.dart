import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'search...',
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
              color: Color.fromRGBO(209, 213, 219, 1), width: 1),
        ),
        prefixIcon: const Icon(
          Icons.search_outlined,
          color: Color.fromRGBO(41, 45, 50, 1),
        ),
      ),
    );
  }
}
