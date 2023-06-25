import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:job_finder/views/screens/home_screen_and_search/search_screen.dart';
import 'package:job_finder/views/widgets/home_and_search_screen_widgets/job_title_widget.dart';
import 'package:job_finder/views/widgets/home_and_search_screen_widgets/search_widget.dart';
import '../../widgets/home_and_search_screen_widgets/home_screen_title.dart';
import '../../widgets/home_and_search_screen_widgets/job_category_widget.dart';
import '../../widgets/home_and_search_screen_widgets/suggest_headline_job.dart';
import '../../widgets/onboarding_screen_widgets/custom_button.dart';

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
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const SearchScreen();
                    },
                  ),
                );
              },
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  const SearchWidget(),
                  Container(
                    width: double.infinity,
                    height: 50,
                    color: Colors.transparent,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SuggestHeadlineJob(
              text: 'Suggested Job',
              onPressed: () {},
            ),
            const SizedBox(
              height: 10,
            ),
            CarouselSlider.builder(
              itemCount: 20,
              itemBuilder: (context, index, realIndex) {
                return Container(
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 1),
                  ),
                  child: Column(
                    children: [
                      const JobTitleWidget(
                        category: [
                          JobCategoryWidget(
                            category: 'Fulltime',
                          )
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('\$12K-15K/Month'),
                          CustomButton(
                            text: 'Apply Now',
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
              options: CarouselOptions(
                enableInfiniteScroll: true,
                viewportFraction: 1,
                height: 190,
                reverse: true,
                scrollDirection: Axis.horizontal,
                onPageChanged: (index, reason) {},
                padEnds: true,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SuggestHeadlineJob(
              text: 'Recent Jobs',
              onPressed: () {},
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
