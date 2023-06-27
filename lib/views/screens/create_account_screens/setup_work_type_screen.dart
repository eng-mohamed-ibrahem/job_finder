import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:job_finder/views/screens/create_account_screens/work_preferred_location_screen.dart';
import 'package:job_finder/views/widgets/onboarding_screen_widgets/custom_button.dart';

import '../../../model/signup_models/work_type_model.dart';
import '../../widgets/signup_screen_widget/interested_work_type_widget.dart';

class WorkTypeScreen extends StatefulWidget {
  const WorkTypeScreen({super.key});

  @override
  State<WorkTypeScreen> createState() => _WorkTypeScreenState();
}

class _WorkTypeScreenState extends State<WorkTypeScreen> {
  final List<WorkTypeModel> workType = [
    WorkTypeModel(icon: FontAwesomeIcons.bezierCurve, text: 'UI/UX Designer'),
    WorkTypeModel(icon: FontAwesomeIcons.penNib, text: 'Ilustrator Designer'),
    WorkTypeModel(icon: FontAwesomeIcons.laptopCode, text: 'Developer'),
    WorkTypeModel(icon: FontAwesomeIcons.chartPie, text: 'Management'),
    WorkTypeModel(
        icon: FontAwesomeIcons.laptopFile, text: 'Information Technology'),
    WorkTypeModel(
        icon: FontAwesomeIcons.bookAtlas, text: 'Research and Analytics'),
  ];

  @override
  Widget build(BuildContext context) {
    log(' WorkTypeScreen');

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Text(
              'What type of work are you interested in?',
              style: TextStyle(
                fontSize: 24,
                color: Color.fromRGBO(17, 24, 39, 1),
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Tell us what you\'re interested in so we can customise the app for your needs.',
              style: TextStyle(
                color: Color.fromRGBO(115, 115, 121, 1),
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: GridView.builder(
                itemCount: workType.length,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  mainAxisExtent: 150,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 15,
                ),
                itemBuilder: (context, index) {
                  return InterestedWorkTypeWidget(
                    workTypeModel: workType[index],
                    index: index,
                  );
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20),
              width: double.infinity,
              child: CustomButton(
                  fontSize: 16,
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const PreferedWorkLocationScreen(),
                      ),
                      (route) => false,
                    );
                  },
                  text: 'Next'),
            ),
          ],
        ),
      ),
    );
  }
}
