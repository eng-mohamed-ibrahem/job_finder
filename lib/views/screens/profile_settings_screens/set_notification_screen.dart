import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_finder/model/profile_setting_screens/job_And_other_notifications_model.dart';

class SetNotificationScreen extends StatefulWidget {
  const SetNotificationScreen({super.key});

  @override
  State<SetNotificationScreen> createState() => _SetNotificationScreenState();
}

class JobNotificationSelection extends Cubit<bool> {
  JobNotificationSelection() : super(false);

  List<JobAndOtherNotificationsModel> jobNotificationList = [
    JobAndOtherNotificationsModel(
      jobNotificationName: 'Your Job Search Alert',
      status: true,
    ),
    JobAndOtherNotificationsModel(
      jobNotificationName: 'Job Application Update',
      status: true,
    ),
    JobAndOtherNotificationsModel(
      jobNotificationName: 'Job Application Reminders',
      status: false,
    ),
    JobAndOtherNotificationsModel(
      jobNotificationName: 'Jobs You May Be Interested In',
      status: true,
    ),
    JobAndOtherNotificationsModel(
      jobNotificationName: 'Job Seeker Updates',
      status: false,
    ),
    JobAndOtherNotificationsModel(
      jobNotificationName: 'Show Profile',
      status: true,
    ),
    JobAndOtherNotificationsModel(
      jobNotificationName: 'All Message',
      status: true,
    ),
    JobAndOtherNotificationsModel(
      jobNotificationName: 'Message Nudges',
      status: true,
    ),
  ];

  void toggleNotificationTo(int index) {
    jobNotificationList[index].status = !jobNotificationList[index].status;
    emit(!state);
  }
}

class _SetNotificationScreenState extends State<SetNotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
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
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Job Notification',
                  style: TextStyle(
                    color: Color.fromRGBO(107, 114, 128, 1),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
