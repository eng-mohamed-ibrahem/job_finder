import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PreferedWorkLocationScreen extends StatefulWidget {
  const PreferedWorkLocationScreen({super.key});

  @override
  State<PreferedWorkLocationScreen> createState() =>
      _PreferedWorkLocationScreenState();
}

class WorkPreferedLocationCubit extends Cubit<int> {
  WorkPreferedLocationCubit() : super(-1);

  void changeSelectedIndex(int index) => emit(index);
}

class _PreferedWorkLocationScreenState
    extends State<PreferedWorkLocationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
      create: (context) => WorkPreferedLocationCubit(),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Where are you preferred Location?',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Let us know, where is the work location you want at this time, so we can adjust it.',
              style: TextStyle(
                color: Color.fromRGBO(115, 115, 121, 1),
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            BlocBuilder<WorkPreferedLocationCubit, int>(
              builder: (context, state) {
                return Center(
                  child: Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromRGBO(244, 244, 245, 1),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () {
                            // change color of widget
                            context
                                .read<WorkPreferedLocationCubit>()
                                .changeSelectedIndex(0);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: state == 0
                                  ? const Color.fromRGBO(9, 26, 122, 1)
                                  : const Color.fromRGBO(244, 244, 245, 1),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 10),
                              child: Text(
                                'Work From Office',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: state == 0
                                      ? const Color.fromRGBO(255, 255, 255, 1)
                                      : const Color.fromRGBO(107, 114, 128, 1),
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // change color of widget
                            context
                                .read<WorkPreferedLocationCubit>()
                                .changeSelectedIndex(1);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: state == 1
                                  ? const Color.fromRGBO(9, 26, 122, 1)
                                  : const Color.fromRGBO(244, 244, 245, 1),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 10),
                              child: Text(
                                'Remote Work',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: state == 1
                                      ? const Color.fromRGBO(255, 255, 255, 1)
                                      : const Color.fromRGBO(107, 114, 128, 1),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
            
          ],
        ),
      ),
    ));
  }
}
