import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../controller/cubit/signup_screens_cubit/work_type_selection_cubit.dart';
import '../../../model/signup_models/country_model.dart';
import '../../widgets/onboarding_screen_widgets/custom_button.dart';
import 'account_finished_screen.dart';

class PreferedWorkLocationScreen extends StatefulWidget {
  const PreferedWorkLocationScreen({super.key});

  @override
  State<PreferedWorkLocationScreen> createState() =>
      _PreferedWorkLocationScreenState();
}

//!---------------------------------------------------------------------------

class WorkPreferedLocationCubit extends Cubit<int> {
  WorkPreferedLocationCubit() : super(-1);

  void changeSelectedIndex(int index) => emit(index);
}

//!---------------------------------------------------------------------------

class _PreferedWorkLocationScreenState
    extends State<PreferedWorkLocationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => WorkPreferedLocationCubit(),
        ),
      ],
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
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Select the country you want for your job',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color.fromRGBO(115, 115, 121, 1),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            BlocBuilder<WorkTypeSelectedCubit, bool>(
              builder: (context, state) {
                return Expanded(
                  child: GridView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: coutriesNames.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 15,
                      mainAxisExtent: 45,
                    ),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          countries[index].selected =
                              !countries[index].selected;
                          BlocProvider.of<WorkTypeSelectedCubit>(context)
                              .changeSelected();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: !countries[index].selected
                                  ? const Color.fromRGBO(229, 231, 235, 1)
                                  : const Color.fromRGBO(51, 102, 255, 1),
                            ),
                            color: !countries[index].selected
                                ? const Color.fromRGBO(250, 250, 250, 1)
                                : const Color.fromRGBO(214, 228, 255, 1),
                          ),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 5,
                              ),
                              Image.asset(
                                countries[index].countryImage,
                                width: 30,
                                height: 30,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                countries[index].countryName,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomButton(
                text: 'Next',
                fontSize: 16,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AccountFinishedScreen(),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    ));
  }
}

List<String> coutriesNames = [
  'Argentina',
  'Brazil',
  'Singapore',
  'Argentina',
  'Canada',
  'China',
  'India',
  'Indonesia',
  'Malaysia',
  'Philippines',
  'Saudi_arabia',
  'United States',
  'Vietnam',
];

List<Country> countries = List.generate(
  coutriesNames.length,
  (index) {
    return Country(
        countryName: coutriesNames[index],
        countryImage: 'assets/icons/${coutriesNames[index]}.png');
  },
);
