import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_finder/controller/cubit/signup_screens_cubit/signup_login_screens_cubit.dart';
import 'package:job_finder/views/screens/apply_job_screen/job_details_screen.dart';
import 'package:job_finder/views/screens/home_screen_and_search/search_screen.dart';
import 'package:job_finder/views/widgets/home_and_search_screen_widgets/job_title_widget.dart';
import 'package:job_finder/views/widgets/home_and_search_screen_widgets/search_widget.dart';
import '../../../controller/cubit/job_data_cubit/job_data_cubit.dart';
import '../../widgets/home_and_search_screen_widgets/home_screen_title.dart';
import '../../widgets/home_and_search_screen_widgets/suggest_headline_job.dart';
import '../../widgets/onboarding_screen_widgets/custom_button.dart';
import '../apply_job_screen/recent_jobs_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<JobDataCubit>(context).getSuggestedJobData(
      token: BlocProvider.of<SignupLoginScreenCubit>(context).userModel!.token,
    );
    BlocProvider.of<JobDataCubit>(context).getRecentJobs();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
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
            BlocBuilder<JobDataCubit, JobDataState>(
              buildWhen: (previous, current) {
                if (current is SuggestJobDataSuccess ||
                    current is SuggestJobDataError ||
                    current is SuggestJobDataLoading) {
                  return true;
                }
                return false;
              },
              builder: (context, state) {
                if (state is SuggestJobDataLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is SuggestJobDataError) {
                  return const Center(
                    child: Text('Something Unexpected Happened!'),
                  );
                }
                var jobs = BlocProvider.of<JobDataCubit>(context).suggestedJobs;
                return CarouselSlider.builder(
                  itemCount: jobs.length,
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
                          JobTitleWidget(
                            jobModel: jobs[index],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(jobs[index].salary),
                              CustomButton(
                                text: 'Apply Now',
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => JobDetailsScreen(
                                        jobModel: jobs[index],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                  options: CarouselOptions(
                    enableInfiniteScroll: true,
                    viewportFraction: .8,
                    height: 190,
                    reverse: true,
                    scrollDirection: Axis.horizontal,
                    padEnds: true,
                  ),
                );
              },
            ),
            const SizedBox(
              height: 10,
            ),
            SuggestHeadlineJob(
              text: 'Recent Jobs',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RecentJobsScreen(),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 10,
            ),
            BlocBuilder<JobDataCubit, JobDataState>(
              buildWhen: (previous, current) {
                if (current is RecentJobDataSuccess ||
                    current is RecentJobDataError ||
                    current is RecentJobDataLoading) {
                  return true;
                }
                return false;
              },
              builder: (context, state) {
                if (state is RecentJobDataLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is RecentJobDataError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Something Unexpected Happened!'),
                    ),
                  );
                }
                var jobs = BlocProvider.of<JobDataCubit>(context).recentJobs;
                return SizedBox(
                  height: 400,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return InkWell(
                        /// handle this if tapped on save job button and trigger [JobDetailsScreen] instead
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => JobDetailsScreen(
                                jobModel: jobs[index],
                              ),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.all(5),
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(width: 1),
                          ),
                          child: JobTitleWidget(
                            jobModel: jobs[index],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
