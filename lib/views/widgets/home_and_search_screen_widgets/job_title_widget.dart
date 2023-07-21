import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:job_finder/controller/cubit/job_data_cubit/job_data_cubit.dart';

import '../../../model/job_model/job_model.dart';

class JobTitleWidget extends StatefulWidget {
  const JobTitleWidget({
    super.key,
    required this.jobModel,
  });
  final JobModel jobModel;

  @override
  State<JobTitleWidget> createState() => _JobTitleWidgetState();
}

class _JobTitleWidgetState extends State<JobTitleWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ListTile(
            leading: SizedBox(
              width: 40,
              height: 40,
              child: Image.network(
                widget.jobModel.image,
                fit: BoxFit.fill,
                loadingBuilder: (context, child, loadingProgress) {
                  return loadingProgress == null
                      ? child
                      : Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes == null
                                ? null
                                : loadingProgress.cumulativeBytesLoaded *
                                    1.0 /
                                    loadingProgress.expectedTotalBytes!,
                          ),
                        );
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Icon(Icons.error),
                  );
                },
              ),
            ),
            title: Text(
              widget.jobModel.name,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
            ),
            subtitle: Text(
              widget.jobModel.compName,
              style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
            ),
            trailing: BlocConsumer<JobDataCubit, JobDataState>(
              listener: (context, state) {
                if (state is SaveJobDataSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: widget.jobModel.isFavorite!
                          ? const Text('Job Saved Successfully!')
                          : const Text('Job Unsaved Successfully!'),
                    ),
                  );
                }
                if (state is SaveJobDataError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Something Unexpected Happened!'),
                    ),
                  );
                }
              },
              buildWhen: (previous, current) {
                if (current is SaveJobDataLoading ||
                    current is SaveJobDataSuccess ||
                    current is SaveJobDataError) {
                  return true;
                }
                return false;
              },
              builder: (context, state) {
                if (state is SaveJobDataLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return InkWell(
                  onTap: () {
                    BlocProvider.of<JobDataCubit>(context)
                        .saveJob(widget.jobModel);
                  },
                  child: Icon(
                    FontAwesomeIcons.bookmark,
                    color:
                        widget.jobModel.isFavorite! ? Colors.blue : Colors.grey,
                  ),
                );
              },
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromRGBO(214, 228, 255, 1),
                ),
                child: Text(
                  widget.jobModel.jobTimeType,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(51, 102, 255, 1),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromRGBO(214, 228, 255, 1),
                ),
                child: Text(
                  widget.jobModel.jobLevel,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(51, 102, 255, 1),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
