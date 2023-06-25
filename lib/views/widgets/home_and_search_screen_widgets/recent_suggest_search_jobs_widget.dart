import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RecentSuggestWidget extends StatelessWidget {
  const RecentSuggestWidget({
    super.key,
    required this.jobTitle,
    required this.isRecent,
    required this.index,
  });
  final String jobTitle;
  final bool isRecent;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          isRecent ? Icons.history : Icons.search_outlined,
          size: 16,
        ),
        Text(
          jobTitle,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Spacer(),
        InkWell(
          onTap: () {
            if (isRecent) {
              // remove with current index
            } else {
              // move to page popular with current index
            }
          },
          child: Icon(
            isRecent
                ? FontAwesomeIcons.xmark
                : FontAwesomeIcons.rightFromBracket,
            size: 22,
          ),
        )
      ],
    );
  }
}
