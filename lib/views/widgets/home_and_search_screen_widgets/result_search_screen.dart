import 'package:flutter/material.dart';
import 'package:job_finder/controller/utils/app_images.dart';
import 'package:job_finder/views/widgets/onboarding_screen_widgets/custom_button.dart';

import '../../../model/job_model/job_model.dart';
import '../../screens/apply_job_screen/job_details_screen.dart';
import 'job_title_widget.dart';

class ResultOfSearchScreen extends StatefulWidget {
  const ResultOfSearchScreen({super.key, required this.resultSearch});
  final List<JobModel> resultSearch;

  @override
  State<ResultOfSearchScreen> createState() => _ResultOfSearchScreenState();
}

class _ResultOfSearchScreenState extends State<ResultOfSearchScreen> {
  bool fullTimeTapped = false;
  bool partTimeTapped = false;
  bool seniorTapped = false;
  bool juniorTapped = false;
  late List<JobModel> resultFilterSearch;
  @override
  void initState() {
    resultFilterSearch = [...widget.resultSearch];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          SizedBox(
            height: 32,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                IconButton(
                  onPressed: () {
                    // show modal bottom sheet
                    showModalBottomSheet(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      context: context,
                      builder: (context) {
                        return Column(
                          children: [
                            SizedBox(
                              height: 24,
                              child: Row(
                                children: [
                                  BackButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  const Center(
                                    child: Text(
                                      'Set Filter',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromRGBO(17, 24, 39, 1),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  onTap: () {
                                    fullTimeTapped = !fullTimeTapped;
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: !partTimeTapped
                                            ? const Color(0xffE5E7EB)
                                            : const Color.fromRGBO(
                                                9, 26, 122, 1),
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      'Full Time',
                                      style: TextStyle(
                                        color: fullTimeTapped
                                            ? const Color.fromRGBO(
                                                107, 114, 128, 1)
                                            : const Color.fromRGBO(
                                                255, 255, 255, 1),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                InkWell(
                                  onTap: () {
                                    partTimeTapped = !partTimeTapped;
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: !partTimeTapped
                                            ? const Color(0xffE5E7EB)
                                            : const Color.fromRGBO(
                                                9, 26, 122, 1),
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      'Part Time',
                                      style: TextStyle(
                                        color: partTimeTapped
                                            ? const Color.fromRGBO(
                                                107, 114, 128, 1)
                                            : const Color.fromRGBO(
                                                255, 255, 255, 1),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    seniorTapped = !seniorTapped;
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: !partTimeTapped
                                            ? const Color(0xffE5E7EB)
                                            : const Color.fromRGBO(
                                                9, 26, 122, 1),
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      'Senior Level',
                                      style: TextStyle(
                                        color: partTimeTapped
                                            ? const Color.fromRGBO(
                                                107, 114, 128, 1)
                                            : const Color.fromRGBO(
                                                255, 255, 255, 1),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                InkWell(
                                  onTap: () {
                                    juniorTapped = !juniorTapped;
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: !partTimeTapped
                                            ? const Color(0xffE5E7EB)
                                            : const Color.fromRGBO(
                                                9, 26, 122, 1),
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      'Junior Level',
                                      style: TextStyle(
                                        color: partTimeTapped
                                            ? const Color.fromRGBO(
                                                107, 114, 128, 1)
                                            : const Color.fromRGBO(
                                                255, 255, 255, 1),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Center(
                              child: CustomButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  setFilter();
                                },
                                text: 'Show result',
                                fontSize: 16,
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: Image.asset(Assets.imagesIconsFilterSearch),
                ),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    fullTimeTapped = !fullTimeTapped;
                    setFilter();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: !partTimeTapped
                            ? const Color(0xffE5E7EB)
                            : const Color.fromRGBO(9, 26, 122, 1),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      'Full Time',
                      style: TextStyle(
                        color: fullTimeTapped
                            ? const Color.fromRGBO(107, 114, 128, 1)
                            : const Color.fromRGBO(255, 255, 255, 1),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    partTimeTapped = !partTimeTapped;
                    setFilter();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: !partTimeTapped
                            ? const Color(0xffE5E7EB)
                            : const Color.fromRGBO(9, 26, 122, 1),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      'Part Time',
                      style: TextStyle(
                        color: partTimeTapped
                            ? const Color.fromRGBO(107, 114, 128, 1)
                            : const Color.fromRGBO(255, 255, 255, 1),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xffF4F4F5),
              border: Border.all(
                color: const Color(0xffE5E7EB),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Featuring ${widget.resultSearch.length}Jobs',
                style: const TextStyle(
                  color: Color(0xFF111827),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return JobDetailsScreen(
                            jobModel: resultFilterSearch[index],
                          );
                        },
                      ),
                    );
                  },
                  child: JobTitleWidget(
                    jobModel: widget.resultSearch[index],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void setFilter() {
    if (fullTimeTapped) {
      resultFilterSearch = resultFilterSearch
          .where((element) => element.jobTimeType == 'Full time')
          .toList();
    }
    if (partTimeTapped) {
      resultFilterSearch = resultFilterSearch
          .where((element) => element.jobTimeType == 'Part time')
          .toList();
    }
    if (juniorTapped) {
      resultFilterSearch = resultFilterSearch
          .where((element) => element.jobLevel == 'junior')
          .toList();
    }
    if (seniorTapped) {
      resultFilterSearch = resultFilterSearch
          .where((element) => element.jobLevel == 'senior')
          .toList();
    }
    if (!fullTimeTapped && !partTimeTapped && !juniorTapped && !seniorTapped) {
      resultFilterSearch = [...widget.resultSearch];
    }
    setState(() {});
  }
}
