import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_riverpod/core/utils/constants.dart';
import 'package:todo_riverpod/core/widgets/core_widgets.dart';

import '../../../core/models/task_model.dart';
import '../controllers/date/date_provider.dart';
import '../controllers/todo/todo_provider.dart';
import '../pages/homepage.dart';

class UpdateTask extends ConsumerStatefulWidget {
  final Task task;
  const UpdateTask({required this.task, super.key});

  @override
  ConsumerState<UpdateTask> createState() => _AddPageState();
}

class _AddPageState extends ConsumerState<UpdateTask> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  @override
  void initState() {
    super.initState();
    titleController.text = widget.task.title ?? '';
    descriptionController.text = widget.task.desc ?? '';
    SchedulerBinding.instance.addPostFrameCallback((_) {
      ref.read(dateStateProvider.notifier).setDate(widget.task.date.toString());
      ref
          .read(startTimeStateProvider.notifier)
          .setStart(widget.task.startTime.toString());
      ref
          .read(finishTimeStateProvider.notifier)
          .setFinish(widget.task.endTime.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    final scheduleDate = ref.watch(dateStateProvider);
    final startTime = ref.watch(startTimeStateProvider);
    final endTime = ref.watch(finishTimeStateProvider);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppConst.kLight,
            ),
          ),
        ),
        body: SafeArea(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            children: [
              HeightSpacer(
                spaceHeight: 20.h,
              ),
              CustomTextFormField(
                hintText: 'Enter your Title',
                controller: titleController,
              ),
              HeightSpacer(
                spaceHeight: 20.h,
              ),
              CustomTextFormField(
                hintText: 'Enter your Description',
                controller: descriptionController,

                // hintStyle: appStyle(16, AppConst.kGreyLight, FontWeight.normal),
              ),
              HeightSpacer(
                spaceHeight: 20.h,
              ),
              CustomOutlineButton(
                borderColor: AppConst.kLight,
                height: 52.h,
                bgColor: AppConst.kBlueLight,
                text: scheduleDate.isEmpty ? 'Set Date' : scheduleDate,
                width: AppConst.kWidth,
                onPressed: () {
                  picker.DatePicker.showDatePicker(context,
                      showTitleActions: true,
                      minTime: DateTime.now(),
                      maxTime:
                          DateTime.now().add(const Duration(days: 365 * 2)),
                      theme: const picker.DatePickerTheme(
                          headerColor: Colors.white,
                          itemStyle: TextStyle(
                              color: AppConst.kBlueLight,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                          doneStyle:
                              TextStyle(color: AppConst.kGreen, fontSize: 16)),
                      onChanged: (date) {
                    ref
                        .read(dateStateProvider.notifier)
                        .setDate(date.toString().substring(0, 10));
                  }, onConfirm: (date) {
                    ref
                        .read(dateStateProvider.notifier)
                        .setDate(date.toString().substring(0, 10));
                  }, currentTime: DateTime.now(), locale: picker.LocaleType.en);
                },
              ),
              HeightSpacer(
                spaceHeight: 20.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomOutlineButton(
                    borderColor: AppConst.kLight,
                    height: 52.h,
                    bgColor: AppConst.kBlueLight,
                    text: startTime.isEmpty ? 'Start Time' : startTime,
                    width: AppConst.kWidth * 0.4,
                    onPressed: () {
                      picker.DatePicker.showDateTimePicker(context,
                          onChanged: (date) {
                            ref
                                .read(startTimeStateProvider.notifier)
                                .setStart(date.toString().substring(10, 16));
                          },
                          showTitleActions: true,
                          onConfirm: (date) {
                            ref
                                .read(startTimeStateProvider.notifier)
                                .setStart(date.toString().substring(10, 16));
                          },
                          locale: picker.LocaleType.en);
                    },
                  ),
                  CustomOutlineButton(
                    borderColor: AppConst.kLight,
                    height: 52.h,
                    bgColor: AppConst.kBlueLight,
                    text: endTime.isEmpty ? 'End Time' : endTime,
                    width: AppConst.kWidth * 0.4,
                    onPressed: () {
                      picker.DatePicker.showDateTimePicker(context,
                          showTitleActions: true, onChanged: (date) {
                        ref
                            .read(finishTimeStateProvider.notifier)
                            .setFinish(date.toString().substring(10, 16));
                      }, onConfirm: (date) {
                        ref
                            .read(finishTimeStateProvider.notifier)
                            .setFinish(date.toString().substring(10, 16));
                      }, locale: picker.LocaleType.en);
                    },
                  ),
                ],
              ),
              HeightSpacer(
                spaceHeight: 20.h,
              ),
              CustomOutlineButton(
                borderColor: AppConst.kLight,
                height: 52.h,
                bgColor: AppConst.kGreen,
                text: 'Submit',
                width: AppConst.kWidth,
                onPressed: () {
                  if (isContentNotEmpty(scheduleDate, startTime, endTime)) {
                    addTask(scheduleDate, startTime, endTime);
                    clearSelectedDateAndTime();

                    Navigator.pop(context);
                  } else {
                    ref.read(checkTaskEntryProvider.notifier).state = false;

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: const Duration(seconds: 1),
                        // animation: CurvedAnimation(
                        //   parent: animationController..forward(),
                        //   curve: Curves.bounceInOut,
                        // ),
                        content: Text(
                          'Please fill all the fields',
                          style: appStyle(12, AppConst.kLight, FontWeight.bold),
                        ),
                        backgroundColor: AppConst.kBkLight,
                        behavior: SnackBarBehavior.floating,
                        // action: SnackBarAction(
                        //   label: 'Dismiss',
                        //   disabledTextColor: Colors.white,
                        //   textColor: AppConst.kYellow,
                        //   onPressed: () {},
                        // ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ));
  }

  addTask(String scheduleDate, String startTime, String endTime) {
    Task task = Task(
      id: widget.task.id,
      title: titleController.text,
      desc: descriptionController.text,
      date: scheduleDate,
      startTime: startTime,
      endTime: endTime,
      isCompleted: 0,
      remind: 0,
      repeat: "yes",
    );
    ref.read(todoStateProvider.notifier).updateItem(task);
    ref.read(checkTaskEntryProvider.notifier).state = true;
  }

  bool isContentNotEmpty(
      String scheduleDate, String startTime, String endTime) {
    return titleController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty &&
        scheduleDate.isNotEmpty &&
        startTime.isNotEmpty &&
        endTime.isNotEmpty;
  }

  void clearSelectedDateAndTime() {
    ref.read(dateStateProvider.notifier).setDate('');
    ref.read(startTimeStateProvider.notifier).setStart('');
    ref.read(finishTimeStateProvider.notifier).setFinish('');
  }
}
