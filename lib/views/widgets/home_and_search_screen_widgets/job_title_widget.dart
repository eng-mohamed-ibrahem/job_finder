import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'job_category_widget.dart';

class JobTitleWidget extends StatelessWidget {
  const JobTitleWidget({super.key, required this.category});
  final List<JobCategoryWidget> category;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(
              child:
                  // Network image instead from assets
                  Image.asset(
                "assets/images/Logo.png",
                width: 40,
                height: 40,
              ),
            ),
            title: const Text(
              'job title',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
            ),
            subtitle: const Text(
              'company name',
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
            ),
            trailing: const Icon(FontAwesomeIcons.bookmark),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: category,
          )
        ],
      ),
    );
  }
}
