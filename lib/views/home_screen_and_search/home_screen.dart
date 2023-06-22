import 'package:flutter/material.dart';
import 'package:job_finder/views/widgets/home_and_search_screen_widgets/job_title_widget.dart';
import 'package:job_finder/views/widgets/home_and_search_screen_widgets/search_widget.dart';
import '../widgets/home_and_search_screen_widgets/home_screen_title.dart';
import '../widgets/home_and_search_screen_widgets/job_category_widget.dart';
import '../widgets/home_and_search_screen_widgets/suggest_headline_job.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const TitleHomeScreen(),
            const SearchWidget(),
            SuggestHeadlineJob(
              text: 'Suggested Job',
              onPressed: () {},
            ),
            Column(
              children: [
                const JobTitleWidget(
                  category: [
                    JobCategoryWidget(
                      category: 'Fulltime',
                    )
                  ],
                ),
                Row(
                  children: [
                    const Text('\$12K-15K/Month'),
                    ElevatedButton(onPressed: () {}, child: const Text('Apply'))
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
