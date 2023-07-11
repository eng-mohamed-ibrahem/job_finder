import 'package:flutter/material.dart';
import 'package:job_finder/controller/utils/dio_helper/dio_helper.dart';

class TestWidget extends StatelessWidget {
  const TestWidget({super.key});

  getData() async {
    await DioHelper.getRequest(
            endPoint: 'jobs',
            token: '2718|RPTT4Gni8VSq7b2VgbGdvExDiQ5xeE9MbUJqUQ0J')
        .then((response) {
      debugPrint(response!.data.toString());
    });

    // await DioHelper.postData(
    //   endPoint: 'auth/login',
    //   data: {
    //     'email': 'mohamed.data13@gmail.com',
    //     'password': 'mohamed',
    //   },
    // ).then((response) {
    //   debugPrint(response!.data.toString());
    // });
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return const Scaffold(
      body: Center(
        child: Text('Test Widget'),
      ),
    );
  }
}
